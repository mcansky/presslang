class Word < ActiveRecord::Base
  has_many :definitions
  validates_format_of :lang, :with => /[a-z][a-z]/,
      :message => "2 letters format"
  validates_length_of :lang, :is => 2
  validates_size_of :definitions, :minimum => 1
  validates_presence_of :word

  def initializer(word,lang,definition)
    self.word = word
    self.lang = lang
    self.definitions << definition
  end

  def definition
    return definitions.last
  end
end
