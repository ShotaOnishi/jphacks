class WebhookController < ApplicationController
  protect_from_forgery with: :null_session
  protect_from_forgery :except => [:callback]

  CHANNEL_SECRET = ENV['LINE_CHANNEL_SECRET']
  OUTBOUND_PROXY = ENV['OUTBOUND_PROXY']
  CHANNEL_ACCESS_TOKEN = ENV['LINE_CHANNEL_TOKEN']

  def callback
    unless is_validate_signature
      render :nothing => true, status: 470
    end

    event = params["events"][0]
    event_type = event["type"]
    reply_token = event["replyToken"]

    case event_type
      when "message"
        text = event['message']['text']
        if text.include?("運勢")
          message = ResponceMessage.new(FortuneMessage.new)
        else
          message = ResponceMessage.new(DefaultMessage.new)
        end
        p message

        # history of talk
        input_text = event["message"]["text"]
        line_group_id = event['source']['groupId']
        group = Group.where(:line_group_id => line_group_id).first_or_initialize
        group.talks.build(
            message: input_text
        )
        group.save

        client = LineClient.new(CHANNEL_ACCESS_TOKEN, OUTBOUND_PROXY)
        res = client.reply(reply_token, message.output_message)

        if res.status == 200
          logger.info({success: res})
        else
          logger.info({fail: res})
        end

      else
        exit 1
    end

    render :nothing => true, status: :ok
  end

  private
  # verify access from LINE
  def is_validate_signature
    signature = request.headers["X-LINE-Signature"]
    http_request_body = request.raw_post
    hash = OpenSSL::HMAC::digest(OpenSSL::Digest::SHA256.new, CHANNEL_SECRET, http_request_body)
    signature_answer = Base64.strict_encode64(hash)
    signature == signature_answer
  end
end
