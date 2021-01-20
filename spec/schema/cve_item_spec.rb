require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/cve_item'

describe NVD::JSONFeeds::Schema::CVEItem do
  describe "#initialize" do
    context "when cve: is given" do
      let(:cve) { double("CVESchema::CVE") }

      subject { described_class.new(cve: cve) }

      it "must set #cve" do
        expect(subject.cve).to eq(cve)
      end

      context "and when configurations: is given" do
        let(:configurations) { double(:Configurations) }

        subject do
          described_class.new(cve: cve, configurations: configurations)
        end

        it "must set #configurations" do
          expect(subject.configurations).to eq(configurations)
        end
      end

      context "and when configurations: is not given" do
        it { expect(subject.configurations).to be(nil) }
      end

      context "and when impact: is given" do
        let(:impact) { double(:Impact) }

        subject do
          described_class.new(cve: cve, impact: impact)
        end

        it "must set #impact" do
          expect(subject.impact).to eq(impact)
        end
      end

      context "and when impact: is not given" do
        it { expect(subject.impact).to be(nil) }
      end

      context "and when published_date: is given" do
        let(:published_date) { double(:published_date) }

        subject do
          described_class.new(cve: cve, published_date: published_date)
        end

        it "must set #published_date" do
          expect(subject.published_date).to eq(published_date)
        end
      end

      context "and when published_date: is not given" do
        it { expect(subject.published_date).to be(nil) }
      end

      context "and when last_modified_date: is given" do
        let(:last_modified_date) { double(:last_modified_date) }

        subject do
          described_class.new(cve: cve, last_modified_date: last_modified_date)
        end

        it "must set #last_modified_date" do
          expect(subject.last_modified_date).to eq(last_modified_date)
        end
      end

      context "and when last_modified_date: is not given" do
        it { expect(subject.last_modified_date).to be(nil) }
      end
    end

    context "when cve: is not given" do
      it do
        expect {
          described_class.new
        }.to raise_error(ArgumentError)
      end
    end
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
