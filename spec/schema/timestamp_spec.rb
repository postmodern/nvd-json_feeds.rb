require 'spec_helper'
require 'nvd/json_feeds/schema/timestamp'

describe "NVD::JSONFeeds::Schema::Timestamp" do
  subject { Schema::Timestamp }

  it { expect(subject).to be(CVESchema::CVE::Timestamp) }
end
