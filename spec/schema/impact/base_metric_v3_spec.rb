require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/impact'

describe Schema::Impact::BaseMetricV3 do
  describe "#initialize" do
    context "when cvss_v3: is given" do
      let(:cvss_v3) { double(:CVSSv3) }

      subject { described_class.new(cvss_v3: cvss_v3) }

      it "must set #cvss_v3" do
        expect(subject.cvss_v3).to eq(cvss_v3)
      end

      context "and when exploitability_score: is given" do
        let(:exploitability_score) { 5.0 }

        subject do
          described_class.new(
            cvss_v3:              cvss_v3,
            exploitability_score: exploitability_score
          )
        end

        it "must set #exploitability_score" do
          expect(subject.exploitability_score).to eq(exploitability_score)
        end
      end

      context "but when exploitability_score: is not given" do
        it { expect(subject.exploitability_score).to be(nil) }
      end

      context "and when impact_score: is given" do
        let(:impact_score) { 5.0 }

        subject do
          described_class.new(
            cvss_v3:              cvss_v3,
            impact_score: impact_score
          )
        end

        it "must set #impact_score" do
          expect(subject.impact_score).to eq(impact_score)
        end
      end

      context "but when impact_score: is not given" do
        it { expect(subject.impact_score).to be(nil) }
      end
    end

    context "when cvss_v3: is not given" do
      it do
        expect {
          described_class.new
        }.to raise_error(ArgumentError)
      end
    end
  end

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
