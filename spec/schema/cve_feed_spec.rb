require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/cve_feed'

describe NVD::JSONFeeds::Schema::CVEFeed do
  describe "#initialize" do
    let(:data_version) { :"4.0" }
    let(:data_type)    { :CVE   }
    let(:data_format)  { :MITRE }
    let(:cve_items)    { [double(:CVEItem1), double(:CVEItem2)] }

    subject do
      described_class.new(
        data_version: data_version,
        data_type:    data_type,
        data_format:  data_format,
        cve_items:    cve_items
      )
    end

    it "must set #data_version" do
      expect(subject.data_version).to eq(data_version)
    end

    it "must set #data_type" do
      expect(subject.data_type).to eq(data_type)
    end

    it "must set #data_format" do
      expect(subject.data_format).to eq(data_format)
    end

    it "must set #cve_items" do
      expect(subject.cve_items).to eq(cve_items)
    end

    context "and when data_number_of_cves: is given" do
      let(:data_number_of_cves) { 2 }

      subject do
        described_class.new(
          data_version:        data_version,
          data_type:           data_type,
          data_format:         data_format,
          data_number_of_cves: data_number_of_cves,
          cve_items:           cve_items
        )
      end

      it "must set #data_number_of_cves" do
        expect(subject.data_number_of_cves).to eq(data_number_of_cves)
      end
    end

    context "but when data_number_of_cves: is not given" do
      it { expect(subject.data_number_of_cves).to be(nil) }
    end

    context "and when data_timestamp: is given" do
      let(:data_timestamp) { DateTime.now }

      subject do
        described_class.new(
          data_version:   data_version,
          data_type:      data_type,
          data_format:    data_format,
          data_timestamp: data_timestamp,
          cve_items:      cve_items
        )
      end

      it "must set #data_timestamp" do
        expect(subject.data_timestamp).to eq(data_timestamp)
      end
    end

    context "but when data_timestamp: is not given" do
      it { expect(subject.data_timestamp).to be(nil) }
    end

    context "but when data_version: is not given" do
      it do
        expect {
          described_class.new(
            data_type:   data_type,
            data_format: data_format,
            cve_items:   cve_items
          )
        }.to raise_error(ArgumentError)
      end
    end

    context "but when data_type: is not given" do
      it do
        expect {
          described_class.new(
            data_version: data_version,
            data_format:  data_format,
            cve_items:    cve_items
          )
        }.to raise_error(ArgumentError)
      end
    end

    context "but when data_format: is not given" do
      it do
        expect {
          described_class.new(
            data_version: data_version,
            data_type:    data_type,
            cve_items:    cve_items
          )
        }.to raise_error(ArgumentError)
      end
    end

    context "but when cve_items: is not given" do
      it do
        expect {
          described_class.new(
            data_version: data_version,
            data_type:    data_type,
            data_format:  data_format
          )
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".load" do
    include_examples ".load"

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
