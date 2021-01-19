require 'spec_helper'
require 'feed_file_examples'
require 'nvd/json_feeds/zip_feed_file'

require 'shellwords'

describe NVD::JSONFeeds::ZipFeedFile do
  let(:fixtures_dir)  { File.expand_path('../fixtures',__FILE__) }
  let(:json_filename) { 'nvdcve-1.1-recent.json'                 }
  let(:json_file)     { File.join(fixtures_dir,json_filename)    }

  let(:zip_filename) { "#{json_filename}.zip"                  }
  let(:dir)          { File.join(fixtures_dir,'zip_feed_file') }
  let(:path)         { File.join(dir,zip_filename)             }

  subject { described_class.new(path) }

  include_examples "FeedFile"

  describe "#json_filename" do
    it "must return the '.json' filename without the '.zip' extension" do
      expect(subject.json_filename).to eq(json_filename)
    end
  end

  describe "#read" do
    it "must read the unziped contents" do
      expect(subject.read).to be == File.read(json_file)
    end

    context "when unzip is not installed" do
      before do
        expect(subject).to receive(:`).and_raise(Errno::ENOENT)
      end

      it do
        expect { subject.read }.to raise_error(RuntimeError)
      end
    end
  end

  describe "#extract" do
    let(:extracted_json_file) { File.join(dir,json_filename) }

    it "must unzip the '.zip' file and return a JSONFeedfile" do
      feed_file = subject.extract

      expect(feed_file).to be_kind_of(JSONFeedFile)
      expect(feed_file.path).to eq(extracted_json_file)
      expect(File.file?(extracted_json_file)).to be(true)
    end

    after { FileUtils.rm_f(extracted_json_file) }
  end
end
