<img width="50%" src="https://img.shields.io/badge/Telegram%20Box-blue?logo=telegram&style=flat-square" alt="Telegram Box">

Update a gist to contain your latest Telegram channel message.

## Setup

### Using [Vercel](http://vercel.com/) and Webhooks (recommended)

1. Add the following secrets to your Vercel account (or [create one](https://vercel.com/signup)):

   - `tg_box_bot_token`: Telegram bot token. The bot should be added to your **public** channel first. [Click here](http://t.me/BotFather) to create a bot.
   - `tg_box_gh_token`: GitHub token with `gist` scope. [Click here](https://github.com/settings/tokens/new?description=tg-box&scopes=gist) to create one.
   - `tg_box_gist_id`: Gist ID. [Click here](https://gist.github.com/) to create a gist.

2. [Deploy to Vercel](https://vercel.com/import/project?template=http://github.com/kidonng/tg-box)
3. [Set up the Webhook](https://core.telegram.org/bots/api#setwebhook): `https://api.telegram.org/bot<token>/setWebhook?url=<url>` (**Make sure to use a private URL!**)
4. Profit 🚀

### Using polling

1. Add the following environment variables:
   - `BOT_TOKEN`: Telegram bot token. The bot should be added to your **public** channel first. [Click here](http://t.me/BotFather) to create a bot.
   - `GH_TOKEN`: GitHub token with `gist` scope. [Click here](https://github.com/settings/tokens/new?description=tg-box&scopes=gist) to create one.
   - `GIST_ID`: Gist ID. [Click here](https://gist.github.com/) to create a gist.
2. Clone the repository
3. Install `ts-node` and run `ts-node api/index.ts`
4. Profit 🚀

## That's it?

- Pin the gist on your GitHub profile page
- `<iframe>` the gist on your webpage
- ...you name it!
