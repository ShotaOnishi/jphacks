require 'date'

class FortuneMessage
  def output_message(context)
    {
        :type => 'template',
        :altText => 'this is a carousel template',
        :template => {
            :type => 'carousel',
            :columns => receive_api
        }
    }
  end

  def receive_api()
    tmp = HTTParty.get('http://api.jugemkey.jp/api/horoscope/free')['horoscope'][date.today.to_s.gsub('-', '/')]
    res = tmp.sort_by{|s| s["rank"]}

    culums = []
    for i in res do
      text = {
          :thumbnailImageUrl => "http://www.study-style.com/seiza/images/01Aries.png",
          :title => i['sign'],
          :text => i['content']
      }
      culums.push(text)
    end
    culums
  end

end