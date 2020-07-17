import Telegraf from 'telegraf'
import { Octokit } from '@octokit/rest'
import { last } from 'lodash'
import dayjs from 'dayjs'
import wrap from 'wrap-ansi'
import { NowRequest, NowResponse } from '@vercel/node'

const { BOT_TOKEN, GH_TOKEN, GIST_ID, IS_VERCEL } = process.env

const telegraf = new Telegraf(BOT_TOKEN)
const {
  gists: { get, update },
} = new Octokit({ auth: GH_TOKEN })

telegraf.on(
  ['channel_post', 'edited_channel_post'],
  async ({ editedChannelPost, channelPost }) => {
    const {
      chat: { title, username },
      message_id,
      date,
      edit_date,
      text,
      caption,
    } = editedChannelPost ?? channelPost

    const {
      data: { files },
    } = await get({ gist_id: GIST_ID })
    const [[filename, { content }]] = Object.entries(files)

    const link = last(content.split('\n'))
    const id = Number(last(link.split('/')))

    // Do nothing when editing old posts
    if (id && message_id < id) return

    const time = dayjs((edit_date ?? date) * 1000).format('YYYY-MM-DD HH:mm')
    const lines = `${wrap(text ?? caption, 63, {
      hard: true,
    })}\nhttps://t.me/${username}/${message_id}`

    update({
      gist_id: GIST_ID,
      files: {
        [filename]: {
          filename: `${title} - ${time}`,
          content: lines,
        },
      },
    })
  }
)

export default ({ body }: NowRequest, res: NowResponse) => {
  if (!body) return res.send('It works!')
  telegraf.handleUpdate(body, res)
}

if (!IS_VERCEL) telegraf.launch()
