
module Line
  CHANNEL_SECRET = ENV['LINE_CHANNEL_SECRET']
  OUTBOUND_PROXY = ENV['OUTBOUND_PROXY']
  CHANNEL_ACCESS_TOKEN = ENV['LINE_CHANNEL_TOKEN']

  class << self
    def reply(message)
      client = LineClient.new(CHANNEL_ACCESS_TOKEN, OUTBOUND_PROXY)
      res = client.reply(replyToken, message)

      if res.status == 200
        logger.info({success: res})
      else
        logger.info({fail: res})
      end
    end
  end

end