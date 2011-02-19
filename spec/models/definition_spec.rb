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

describe "Definition with all should be valid" do
  subject { Definition.new :definition => "a definition",
    :author => "@mcansky",
    :word => Word.new,
    :sha => Digest::SHA1.hexdigest("a definition")}
  it { should be_valid }
end

describe "Testing Definition author attribute : incorrect should fail" do
  subject { Definition.new(:word => Word.new,
    :author => "czef",
    :definition => "ad dezf",
    :sha => Digest::SHA1.hexdigest("a definition")) }
  it { should be_invalid, "should be twitter format" }
end

describe "Testing Definition sha attribute : incorrect should fail" do
  subject { Definition.new(:word => Word.new,
    :author => "czef",
    :definition => "ad dezf",
    :sha => "zefzef") }
  it { should be_invalid, "sha1 too short" }
end