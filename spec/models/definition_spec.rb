require 'spec_helper'
require 'digest/sha1'

describe "Testing Definition associations" do
  subject { Definition.new }
  it { should belong_to(:word) }
end

describe "Basic Definition should be invalid" do
  subject { Definition.new }
  it { should be_invalid }
end

describe "Definition with only definition should be invalid" do
  subject { Definition.new :definition => "a definition" }
  it { should be_invalid }
end

describe "Definition with only definition should be invalid" do
  subject { Definition.new :definition => "a definition" }
  it { should be_invalid }
end

describe "Definition with all should be invalid" do
  subject { Definition.new :definition => "a definition",
    :author => "@mcansky",
    :word => Word.new,
    :sha => Digest::SHA1.hexdigest("a definition")}
  it { should be_valid }
end
