require "optparse"

Options = Struct.new(:formula_only, :pin)
options = Options.new(false, true)

OptionParser.new do |opts|
  opts.on("--formula-only") do
    options.formula_only = true
  end

  opts.on("--no-pin") do
    options.pin = false
  end
end.parse!

if ARGV[0].nil? || ARGV[1].nil?
  onoe "Formula name and version are required"
  exit 1
end

formula = ARGV[0]
version = ARGV[1]

info = `brew info #{formula}`.split("\n")[0]

if info.include? "pinned at"
  opoo "#{formula} is pinned, shift anyway? [y/N]"

  if STDIN.gets.chomp.downcase != "y"
    exit
  end

  ohai "Unpinning #{formula}"
  system("brew unpin #{formula}")
end

formula_fullname = info.split(":")[0]
tap = formula_fullname.include?("/") ? formula_fullname.split("/")[0..1].join("/") : "homebrew/core"

formula_path = `brew formula #{formula}`.strip
tap_path = `brew --repo #{tap}`.strip

ohai "Searching commit SHA of #{formula} #{version}"

hash = nil

IO.popen("git -C #{tap_path} --no-pager log --pretty=oneline #{formula_path}") do |io|
  io.each do |line|
    puts line

    commit_version = /(?:add|update) (.+) bottle/.match(line)

    if commit_version
      if commit_version[1] == version
        hash = line.split(" ")[0]
        break
      end

      if Gem::Version.new(commit_version[1]) < Gem::Version.new(version)
        odie "Specified version not found"
      end
    end
  end
end

if hash == nil
  odie "Specified version not found"
end

if options.formula_only
  ohai "Checkout formula to #{hash}"
  system("git -C #{tap_path} checkout #{hash} #{formula_path}")
else
  ohai "Checkout tap to #{hash}"
  system("git -C #{tap_path} checkout -q #{hash}")
end

ohai "Installing specified version"

system("brew reinstall #{formula}")

ohai "Reverting checkout"

if options.formula_only
  system("git -C #{tap_path} checkout .")
else
  head = `git -C #{tap_path} symbolic-ref refs/remotes/origin/HEAD`.split('refs/remotes/origin/')[1]
  system("git -C #{tap_path} checkout #{head}")
end

if options.pin
  ohai "Pinning #{formula}"
  system("brew pin #{formula}")
end

ohai "Successfully shifted #{formula} to #{version}"
