require 'spec_helper'
require 'nvd/json_feeds/feed_uri'

describe FeedURI do
  let(:name) { :recent }
  let(:ext)  { '.json.gz' }
  
  subject { described_class.new(name,ext) }

  describe "#initialize" do
    it "must set #name" do
      expect(subject.name).to eq(name)
    end

    it "must set #ext" do
      expect(subject.ext).to eq(ext)
    end

    it "must set #filename" do
      expect(subject.filename).to eq("nvdcve-1.1-#{name}#{ext}")
    end
  end

  describe "#get", :integartion do
    let(:contents) { Net::HTTP.get(subject.uri) }

    context "when not given a block" do
      it "must return the full String of the file" do
        expect(subject.get).to eq(contents)
      end
    end

    context "when given a block" do
      it "must yield each chunk of the file" do
        chunks = []

        subject.get { |chunk| chunks << chunk } 

        expect(chunks.join).to eq(contents)
      end
    end
  end

  describe "#download", :integration do
    context "when given a file" do
      it "must return the path to the newly downloaded file" do
      end
    end

    context "when given a directory" do
      it "must return the path to the newly downloaded file in the directory" do
      end
    end
  end

  describe "#uri" do
    subject { super().uri }

    it { expect(subject).to be_kind_of(URI::HTTPS) }

    describe "host" do
      it { expect(subject.host).to eq('nvd.nist.gov') }
    end

    describe "path" do
      it { expect(subject.path).to start_with('/feeds/json/cve/1.1/') }
    end
  end

  describe "#to_s" do
    it "must the String version of the URI" do
      expect(subject.to_s).to eq(subject.uri.to_s)
    end
  end

  describe "#inspect" do
    it "must include the class name and URI" do
      expect(subject.inspect).to eq("#<#{described_class}: #{subject.uri}>")
    end
  end
end
