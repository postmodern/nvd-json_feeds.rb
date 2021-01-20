require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/cve_item'

describe NVD::JSONFeeds::Schema::CVEItem do
  describe "#initialize" do
  end

  describe ".load" do
    include_examples ".load"

    let(:json_node) { json_tree['CVE_Items'][0] }

    include_examples "JSON Object field", json_key:     'cve',
                                          required:     true,
                                          method:       :cve,
                                          object_class: CVESchema::CVE

    include_examples "JSON Object field", json_key:     'configurations',
                                          method:       :configurations,
                                          object_class: Schema::Configurations

    include_examples "JSON Object field", json_key:     'impact',
                                          method:       :impact,
                                          object_class: Schema::Impact

    include_examples "JSON field", json_key: 'publishedDate',
                                   method:   :published_date,
                                   value:    ->{ Schema::Timestamp.parse(json_value) }

    include_examples "JSON field", json_key: 'lastModifiedDate',
                                   method:   :last_modified_date,
                                   value:    ->{ Schema::Timestamp.parse(json_value) }
  end
end
