class WebhookController < ApplicationController


  protect_from_forgery with: :null_session







  module Line
    module Bot
      class HTTPClient
        def http(uri)
          proxy = URI(ENV["FIXIE_URL"])
          http = Net::HTTP.new(uri.host, uri.port, proxy.host, proxy.port, proxy.user, proxy.password)
          if uri.scheme == "https"
            http.use_ssl = true
          end

          http
        end
      end
    end
  end








  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
  def callback

    body = request.body.read

    p @client
    p body

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
      end

      events = client.parse_events_from(body)
      events.each { |event|
        case event
        when Line::Bot::Event::Message
          case event.type
          when Line::Bot::Event::MessageType::Text
            message = {
              type: 'text',
              text: event.message['text']
            }
            client.reply_message(event['replyToken'], message)
          when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
            response = client.get_message_content(event.message['id'])
            p response
            tf = Tempfile.open("content")
            tf.write(response.body)
          end
        end
      }

      "OK"
    end
  end
