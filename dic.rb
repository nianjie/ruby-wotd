class Dictionary
  def self.wordOfTheDay(the_day = Date.today)
    puts the_day
    word = {title: 'audit', definition: 'audit', link: 'https://www.oxfordlearnersdictionaries.com/definition/english/audit_1', updated: '2020-12-17T01:00:00Z'}
  end

  class << self
    def getWord(word)
      {title: word, definition: word, link: 'https://www.oxfordlearnersdictionaries.com/definition/english/audit_1', updated: '2020-12-17T01:00:00Z'}
    end
  end
end