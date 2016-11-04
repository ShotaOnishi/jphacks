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

    headers = {
        'X-JUGEMKEY-API-CREATED' => '2006-07-26T06:55:44Z',
        'X-JUGEMKEY-API-KEY' => "f6fe8e8481ab91c4785eec03e93c505b",
        'X-JUGEMKEY-API-SIG' => "8720df454dd79b9c7acfa3338b35a17273f54472"
    }
    request = 'http://api.jugemkey.jp/api/horoscope/' + year + '/' + month + '/' + day
    HTTParty.get(request, {}, headers)


  end
end