require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/cve_feed'

describe NVD::JSONFeeds::Schema::CVEFeed do
  describe "#initialize" do
  end

  describe ".load" do
    include_examples ".load"

    it { expect(subject).to be_kind_of(described_class) }

    include_examples "JSON field", json_key: 'CVE_data_type',
                                   required: true,
                                   method:   :data_type,
                                   map:      described_class::DATA_TYPES

    include_examples "JSON field", json_key: 'CVE_data_format',
                                   required: true,
                                   method:   :data_format,
                                   map:      described_class::DATA_FORMATS

    include_examples "JSON field", json_key: 'CVE_data_version',
                                   required: true,
                                   method:   :data_version,
                                   map:      described_class::DATA_VERSIONS

    include_examples "JSON field", json_key: 'CVE_data_numberOfCVEs',
                                   required: true,
                                   method:   :data_number_of_cves,
                                   value:    ->{ json_value.to_i }

    include_examples "JSON field", json_key: 'CVE_data_timestamp',
                                   method:   :data_timestamp,
                                   value:    ->{ Schema::Timestamp.parse(json_value) }

    include_examples "JSON Array field", json_key:      'CVE_Items',
                                         method:        :cve_items,
                                         required:      true,
                                         element_class: Schema::CVEItem
  end
end
