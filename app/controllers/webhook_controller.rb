class WebhookController < ApplicationController
  include Line
  protect_from_forgery with: :null_session
  protect_from_forgery :except => [:callback]

  def callback
    unless is_validate_signature
      render :nothing => true, status: 470
    end

    event = params["events"][0]
    event_type = event["type"]
    replyToken = event["replyToken"]

    p event
    case event_type
      when "message"
        if event['text'].include?(["運勢", '占う'])
          redirect_to '/fortune'
        end

        # history of talk
        input_text = event["message"]["text"]
        line_group_id = event['source']['groupId']
        output_text = input_text
        group = Group.where(:line_group_id => line_group_id).first_or_initialize
        group.talks.build(
            :message => input_text
        )
        group.save
    end

    reply(output_text, replyToken)

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
