class Word < ActiveRecord::Base
  has_many :definitions, :conditions => {:banned => "n"}
  validates_format_of :lang, :with => /[a-z][a-z]/, :message => "2 letters format"
  validates_length_of :lang, :is => 2, :message => "2 letters format"
  #validates_size_of :definitions, :minimum => 1
  validates_size_of :word, :minimum => 1

  def definition
    return definitions.last
  end

  def banned?
    return true if definitions.size == 0
    return false
  end

  def empty?
    return banned?
  end
end
