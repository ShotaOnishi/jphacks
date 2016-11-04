require 'date'
require 'json'

class FortuneMessage
  def output_message(context)
    {
        type: "text",
        text: "AAA"
    }
  end

  def receive_api()
    p JSON.parse(HTTParty.get('http://api.jugemkey.jp/api/horoscope/free'))
  end
end