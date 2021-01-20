require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/configurations'

describe Schema::Configurations::Node do
  describe ".load" do
    include_examples ".load"

    let(:json_node) { json_tree['CVE_Items'][0]['configurations']['nodes'][0] }

    include_examples "JSON field", json_key: 'operator',
                                   method:   :operator,
                                   map:      described_class::OPERATORS

    include_examples "JSON field", json_key: 'negate',
                                   method:   :negate

    pending 'need an example containing \"children\"'do
      include_examples "JSON Array field", json_key:     'children',
                                           method:        :children,
                                           element_class: described_class
    end

    include_examples "JSON Array field", json_key:     'cpe_match',
                                         method:        :cpe_match,
                                         element_class: Schema::CPE::Match

  end
end
