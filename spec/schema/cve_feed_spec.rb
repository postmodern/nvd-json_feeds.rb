require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/cve_feed'

describe NVD::JSONFeeds::Schema::CVEFeed do
  describe "#initialize" do
  end

  describe ".load" do
    include_examples ".load"

    it { expect(subject).to be_kind_of(described_class) }

    context '"CVE_date_type"' do
      let(:json_value) { json_node['CVE_data_type'] }
      let(:expected)   { described_class::DATA_TYPES[json_value] }

      it "must set #data_type" do
        expect(subject.data_type).to eq(expected)
      end

      context 'when missing' do
        before { json_node.delete('CVE_data_type') }

        it do
          expect {
            described_class.load(json_node)
          }.to raise_error(KeyError)
        end
      end
    end

    context '"CVE_date_format"' do
      let(:json_value) { json_node['CVE_data_format'] }
      let(:expected)   { described_class::DATA_FORMATS[json_value] }

      it "must set #data_format" do
        expect(subject.data_format).to eq(expected)
      end

      context 'when missing' do
        before { json_node.delete('CVE_data_format') }

        it do
          expect {
            described_class.load(json_node)
          }.to raise_error(KeyError)
        end
      end
    end

    context '"CVE_data_version"' do
      let(:json_value) { json_node['CVE_data_version'] }
      let(:expected)   { Schema::HasDataVersion::DATA_VERSIONS[json_value] }

      it "must set #data_version" do
        expect(subject.data_version).to eq(expected)
      end

      context 'when missing' do
        before { json_node.delete('CVE_data_version') }

        it do
          expect {
            described_class.load(json_node)
          }.to raise_error(KeyError)
        end
      end
    end

    context '"CVE_data_numberOfCVEs"' do
      let(:json_value) { json_node['CVE_data_numberOfCVEs'] }
      let(:expected)   { json_value.to_i }

      it "must set #data_number_of_cves" do
        expect(subject.data_number_of_cves).to eq(expected)
      end

      context 'when missing' do
        before { json_node.delete('CVE_data_numberOfCVEs') }

        it do
          expect {
            described_class.load(json_node)
          }.to raise_error(KeyError)
        end
      end
    end

    context '"CVE_data_timestamp"' do
      context "when present" do
        let(:json_value) { json_node['CVE_data_timestamp']     }
        let(:expected)   { Schema::Timestamp.parse(json_value) }

        it "must parse and set #data_timestamp" do
          expect(subject.data_timestamp).to eq(expected)
        end
      end

      context "when missing" do
        before { json_node.delete('CVE_data_timestamp') }

        it { expect(subject.data_timestamp).to be(nil) }
      end
    end

    context '"CVE_Items"' do
      let(:json_value) { json_node['CVE_Items'] }

      it { expect(subject.cve_items).to be_kind_of(Array) }
      it { expect(subject.cve_items).to_not be_empty }
      it { expect(subject.cve_items).to all(be_kind_of(Schema::CVEItem)) }

      it 'must parse all elements of "CVE_Items"' do
        expect(subject.cve_items.length).to eq(json_value.length)
      end

      context "when missing" do
        before { json_node.delete('CVE_Items') }

        it do
          expect {
            described_class.load(json_node)
          }.to raise_error(KeyError)
        end
      end
    end
  end
end
