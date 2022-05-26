require './firebase/client.rb'

class Dictionary
  FIREBASE_ROOT = %q[https://q8732.firebaseio.com/]
  class_eval do |_|
    @db_client = Client.new(databaseURL: FIREBASE_ROOT)
  end

  def self.wordOfTheDay(the_day = Date.today)
    res = @db_client.get("/chronological/#{the_day.strftime('%Y/%-m/%-d')}")
    word = getWord(res.body) if res.body
  end
  
  class << self
    def getWord(word)
      res = @db_client.get "/word/#{word}"
      res.body
    end
  end

end
