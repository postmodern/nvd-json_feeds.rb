require 'spec_helper'
require 'nvd/json_feeds'

describe NVD::JSONFeeds do
  it "should have a VERSION constant" do
    expect(subject.const_get('VERSION')).to_not be_empty
  end
end
