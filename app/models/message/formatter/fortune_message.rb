require 'date'

class FortuneMessage
  def output_message(context)
    p "AAAAAAAA"
    p receive_api
    {
        type: "text",
        text: "AAA"
    }
  end

  def receive_api()
    today = Date.today
    year = today.year.to_s
    month = today.month.to_s
    day = today.day.to_s

    HTTParty.get('http://api.jugemkey.jp/api/horoscope/free')


  end
end