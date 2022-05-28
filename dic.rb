require './firebase/client.rb'

class Dictionary
  class << self
    def wordOfTheDay(the_day = Date.today)
      res = db_client.get("/chronological/#{the_day.strftime('%Y/%-m/%-d')}")
      word = getWord(res.body) if res.body
    end
  
    def getWord(word)
      res = db_client.get "/word/#{word}"
      res.body
    end

    def db_client
      @db_client ||= Client.new
    end
  end

end
