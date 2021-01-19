require 'spec_helper'
require 'nvd/json_feeds/zip_feed_uri'

describe NVD::JSONFeeds::ZipFeedURI do
  let(:fixtures_dir) { File.expand_path('../fixtures',__FILE__) }

  let(:name) { :recent }
  let(:ext)  { '.json.zip' }
  
  subject { described_class.new(name,ext) }

  describe "#download", :integration do
    let(:download_dir) { File.join(fixtures_dir,'download') }
    let(:dest) { File.join(download_dir,subject.filename) }

    before do
      FileUtils.mkdir_p(download_dir)
      FileUtils.rm_f(dest)
    end

    it "must return a ZipFeedFile object for the newly downloaded file" do
      feed_file = subject.download(dest)

      expect(feed_file).to be_kind_of(ZipFeedFile)
      expect(feed_file.path).to eq(dest)
      expect(File.file?(dest)).to be(true)
    end

    after do
      FileUtils.rm_f(dest)
    end
  end
end
