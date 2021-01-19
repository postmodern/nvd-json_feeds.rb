require 'spec_helper'
require 'feed_file_examples'
require 'nvd/json_feeds/json_feed_file'

describe JSONFeedFile do
  let(:fixtures_dir) { File.expand_path('../fixtures',__FILE__)         }
  let(:path)         { File.join(fixtures_dir,'nvdcve-1.1-recent.json') }

  subject { described_class.new(path) }

  include_examples "FeedFile"

  describe "#read" do
    it "must read the contents of the json file" do
      expect(subject.read).to eq(File.read(path))
    end
  end
end
