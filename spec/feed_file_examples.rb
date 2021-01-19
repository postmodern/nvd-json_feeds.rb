require 'spec_helper'

RSpec.shared_examples_for "FeedFile" do
  describe "#read" do
    subject { super().read }

    it "must return a String" do
      expect(subject).to be_kind_of(String)
      expect(subject).to_not be_empty
    end
  end

  describe "#json" do
    subject { super().json }

    it "must return a parsed JSON Hash" do
      expect(subject).to be_kind_of(Hash)
      expect(subject).to_not be_empty
    end
  end

  describe "#parse" do
    it "must return a CVEFeed object" do
      expect(subject.parse).to be_kind_of(Schema::CVEFeed)
    end
  end
end
