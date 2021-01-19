require 'spec_helper'
require 'nvd/json_feeds/feed_file'

describe FeedFile do
  let(:fixtures_dir) { File.expand_path('../fixtures',__FILE__) }
  let(:filename)     { 'nvdcve-1.1-recent.json'                 }
  let(:path)         { File.join(fixtures_dir,filename)         }
  
  subject { described_class.new(path) }

  describe "#initialize" do
    it "must set #path" do
      expect(subject.path).to eq(path)
    end

    context "when given a relative path" do
      let(:path) { File.join('../fixtures',filename) }

      it "must expand the relative path" do
        expect(subject.path).to eq(File.expand_path(path))
      end
    end
  end

  describe "#read" do
    it do
      expect { subject.read }.to raise_error(NotImplementedError)
    end
  end

  describe "#to_s" do
    it "must the #path" do
      expect(subject.to_s).to eq(subject.path)
    end
  end

  describe "#inspect" do
    it "must include the class name and path" do
      expect(subject.inspect).to eq("#<#{described_class}: #{subject.path}>")
    end
  end
end
