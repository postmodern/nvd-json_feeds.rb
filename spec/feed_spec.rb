require 'spec_helper'
require 'nvd/json_feeds/feed'

describe Feed do
  let(:name) { :recent }

  subject { described_class.new(name) }

  describe "#initialize" do
    it "must set #name" do
      expect(subject.name).to eq(name)
    end

    describe "#meta" do
      subject { super().meta }

      it { expect(subject).to be_kind_of(MetaFeedURI) }

      it "must have the same name" do
        expect(subject.name).to eq(name)
      end

      it "must use '.meta' for the extension" do
        expect(subject.ext).to eq('.meta')
      end
    end

    describe "#gz" do
      subject { super().gz }

      it { expect(subject).to be_kind_of(GzFeedURI) }

      it "must have the same name" do
        expect(subject.name).to eq(name)
      end

      it "must use '.json.gz' for the extension" do
        expect(subject.ext).to eq('.json.gz')
      end
    end

    describe "#zip" do
      subject { super().zip }

      it { expect(subject).to be_kind_of(ZipFeedURI) }

      it "must have the same name" do
        expect(subject.name).to eq(name)
      end

      it "must use '.json.zip' for the extension" do
        expect(subject.ext).to eq('.json.zip')
      end
    end
  end
end
