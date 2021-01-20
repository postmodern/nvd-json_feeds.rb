require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/cpe/name'

describe Schema::CPE::Name do
  describe ".load" do
    pending 'need to find an example containing the "cpe_name" key' do
      include_examples ".load"

      let(:json_node) do
        json_tree['CVE_Items'][0]['configurations']['nodes'][0]['cpe_match'][0]['cpe_name']
      end
    end
  end
end
