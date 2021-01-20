require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/impact'

describe Schema::Impact do
  describe "#initialize" do
    context "when user_interaction_required: is given" do
      let(:base_metric_v3) { double(:BaseMetricV2) }

      subject do
        described_class.new(base_metric_v3: base_metric_v3)
      end

      it "must set #base_metric_v3" do
        expect(subject.base_metric_v3).to eq(base_metric_v3)
      end
    end

    context "when base_metric_v3: is not given" do
      it { expect(subject.base_metric_v3).to be(nil) }
    end

    context "when user_interaction_required: is given" do
      let(:base_metric_v2) { double(:BaseMetricV2) }

      subject do
        described_class.new(base_metric_v2: base_metric_v2)
      end

      it "must set #base_metric_v2" do
        expect(subject.base_metric_v2).to eq(base_metric_v2)
      end
    end

    context "when base_metric_v2: is not given" do
      it { expect(subject.base_metric_v2).to be(nil) }
    end
  end

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
