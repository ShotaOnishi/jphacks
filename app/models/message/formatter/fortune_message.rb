require 'date'

class FortuneMessage
  def output_message(context)
    p receive_api
    {
        type: "text",
        text: "AAA"
    }
  end

  def receive_api()
    HTTParty.get('http://api.jugemkey.jp/api/horoscope/free')
  end
end