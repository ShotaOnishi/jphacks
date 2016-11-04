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
    result = HTTParty.get('http://api.jugemkey.jp/api/horoscope/free')[Date.today.to_s.gsub('-', '/')]


  end
end