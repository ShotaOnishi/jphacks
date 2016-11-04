require 'date'
require 'json'

class FortuneMessage
  def output_message(context)
    p receive_api
    {
        type: "text",
        text: "AAA"
    }
  end

  def receive_api()
    result = JSON.parse(HTTParty.get('http://api.jugemkey.jp/api/horoscope/free'))
    p result[Date.today.to_s.gsub('-', '/')]
  end
end