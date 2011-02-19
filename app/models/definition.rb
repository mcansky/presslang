class Definition < ActiveRecord::Base
  belongs_to :word
  validates_format_of :author, :with => /@[a-zA-Z0-9+]/,
      :message => "twitter user"
  validates_length_of :definition, :minimum => 1
  validates_presence_of :word
  validates_presence_of :author
end
