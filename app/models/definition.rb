# encoding : UTF-8
class Definition < ActiveRecord::Base
  belongs_to :word
  validates_format_of :author, :with => /[a-zA-Z0-9+]/, :message => "should be min size of 1"
  validates_length_of :definition, :minimum => 1    
  validates_length_of :sha, :is => 40, :message => "sha1 too short"
  #validates_presence_of :word
  validates_length_of :author, :minimum => 1
end
