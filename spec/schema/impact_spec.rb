require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/impact'

describe Schema::Impact do
  describe ".load" do
    include_examples ".load"

    let(:json_node) { json_tree['CVE_Items'][0]['impact'] }

    include_examples "JSON Object field", json_key:     'baseMetricV3',
                                          method:       :base_metric_v3,
                                          object_class: described_class::BaseMetricV3

    include_examples "JSON Object field", json_key:     'baseMetricV2',
                                          method:       :base_metric_v2,
                                          object_class: described_class::BaseMetricV2
  end
end
