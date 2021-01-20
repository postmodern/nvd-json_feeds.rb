require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/impact'

describe Schema::Impact::BaseMetricV3 do
  describe ".load" do
    include_examples ".load"

    let(:json_node) { json_tree['CVE_Items'][0]['impact']['baseMetricV3'] }

    include_examples "JSON Object field", json_key:     'cvssV3',
                                          required:     true,
                                          method:       :cvss_v3,
                                          object_class: Schema::CVSSv3

    include_examples "JSON field", json_key: 'exploitabilityScore',
                                   method:   :exploitability_score

    include_examples "JSON field", json_key: 'impactScore',
                                   method:   :impact_score
  end
end
