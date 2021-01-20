require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/configurations'

describe Schema::Configurations do
  describe "#initialize" do
  end

  describe ".load" do
    include_examples ".load"

    let(:json_node) { json_tree['CVE_Items'][0]['configurations'] }

    include_examples "JSON field", json_key: 'CVE_data_version',
                                   required: true,
                                   method:   :data_version,
                                   map:      described_class::DATA_VERSIONS

    include_examples "JSON Array field", json_key: 'nodes',
                                         method: :nodes,
                                         element_class: described_class::Node

  end
end
