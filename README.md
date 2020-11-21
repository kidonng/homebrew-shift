# 🔄 Homebrew Shift

This tap provides a `brew shift` command for switching between formula versions. Easily downgrade a package or try out a newer but not the latest version of a package.

<details>

<summary>Demo</summary>

```
$ pnpm --version
5.13.2

$ brew shift pnpm 5.13.1
Warning: pnpm is pinned, shift anyway? [y/N]
y
==> Unpin pnpm
==> Searching commit SHA of pnpm 5.13.1
7df5457fc026760a1cd0b8fad6c18e410ac33d64 pnpm: update 5.13.2 bottle.
50ac76faf685b9df0af75b80f8a3153cf0d43e21 pnpm 5.13.2
c9d8d7f49f840d255f62b1fb32d78d3245eca76b pnpm: update 5.13.1 bottle.
==> Checkout tap to c9d8d7f49f840d255f62b1fb32d78d3245eca76b
==> Installing pnpm 5.13.1
==> Downloading https://homebrew.bintray.com/bottles/pnpm-5.13.1.big_sur.bottle.ta
Already downloaded: /Users/kid/Library/Caches/Homebrew/downloads/a9920687ed66fa5e74fd54a6a5de7350d6368311b6ea15f3a2db0c47f168aced--pnpm-5.13.1.big_sur.bottle.tar.gz
==> Reinstalling pnpm
==> Pouring pnpm-5.13.1.big_sur.bottle.tar.gz
🍺  /usr/local/Cellar/pnpm/5.13.1: 8,629 files, 22.9MB
==> Reverting checkout
Previous HEAD position was c9d8d7f49f pnpm: update 5.13.1 bottle.
Switched to branch 'master'
Your branch is up to date with 'origin/master'.
==> Pin pnpm
==> Successfully shifted pnpm to 5.13.1

$ pnpm --version
5.13.1
```
</details>

## Usage

```
brew tap kidonng/shift
brew shift <FORMULA> <VERSION> [options]
```

**Options:**

- `--formula-only`: Only shift formula's version. This means its dependencies won't be affected.
- `--no-pin`: Skip auto pinning after shifting.
