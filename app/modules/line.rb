
module Line
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