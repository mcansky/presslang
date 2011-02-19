require 'spec_helper'

describe "Testing Word associations" do
  subject { Word.new }
  it { should have_many(:definitions) }
end

describe "Basic Word should be invalid" do
  subject { Word.new }
  it { should be_invalid }
end

describe "Basic Word should respond to definition" do
  subject { Word.new }
  it { should respond_to(:definition) }
end

describe "Word with just word should be invalid" do
  subject { Word.new :word => "word" }
  it { should be_invalid }
end

describe "Word with just lang should be invalid" do
  subject { Word.new :lang => "en" }
  it { should be_invalid }
end

describe "Word with just lang sized 2+ should be invalid" do
  subject { Word.new :word => "cezf", :lang => "ena" }
  it { should be_invalid, "2 letters format" }
end