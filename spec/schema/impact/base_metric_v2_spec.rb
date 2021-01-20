require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/impact/base_metric_v2'

describe Schema::Impact::BaseMetricV2 do
  describe "#initialize" do
    context "when cvss_v2: is given" do
      let(:cvss_v2) { double(:CVSSv3) }

      subject { described_class.new(cvss_v2: cvss_v2) }

      it "must set #cvss_v2" do
        expect(subject.cvss_v2).to eq(cvss_v2)
      end
    end

    context "when cvss_v2: is not given" do
      it { expect(subject.cvss_v2).to be(nil) }
    end

    context "when severity: is given" do
      let(:severity) { 'high' }

      subject do
        described_class.new(severity: severity)
      end

      it "must set #severity" do
        expect(subject.severity).to eq(severity)
      end
    end

    context "when severity: is not given" do
      it { expect(subject.severity).to be(nil) }
    end

    context "when exploitability_score: is given" do
      let(:exploitability_score) { 5.0 }

      subject do
        described_class.new(exploitability_score: exploitability_score)
      end

      it "must set #exploitability_score" do
        expect(subject.exploitability_score).to eq(exploitability_score)
      end
    end

    context "when exploitability_score: is not given" do
      it { expect(subject.exploitability_score).to be(nil) }
    end

    context "when impact_score: is given" do
      let(:impact_score) { 5.0 }

      subject do
        described_class.new(impact_score: impact_score)
      end

      it "must set #impact_score" do
        expect(subject.impact_score).to eq(impact_score)
      end
    end

    context "when impact_score: is not given" do
      it { expect(subject.impact_score).to be(nil) }
    end

    context "when ac_insuf_info: is given" do
      let(:ac_insuf_info) { 'high' }

      subject do
        described_class.new(ac_insuf_info: ac_insuf_info)
      end

      it "must set #ac_insuf_info" do
        expect(subject.ac_insuf_info).to eq(ac_insuf_info)
      end
    end

    context "when ac_insuf_info: is not given" do
      it { expect(subject.ac_insuf_info).to be(nil) }
    end

    context "when obtain_all_privilege: is given" do
      let(:obtain_all_privilege) { 'high' }

      subject do
        described_class.new(obtain_all_privilege: obtain_all_privilege)
      end

      it "must set #obtain_all_privileges" do
        expect(subject.obtain_all_privilege).to eq(obtain_all_privilege)
      end
    end

    context "when obtain_all_privilege: is not given" do
      it { expect(subject.obtain_all_privilege).to be(nil) }
    end

    context "when obtain_user_privilege: is given" do
      let(:obtain_user_privilege) { 'high' }

      subject do
        described_class.new(obtain_user_privilege: obtain_user_privilege)
      end

      it "must set #obtain_user_privilege" do
        expect(subject.obtain_user_privilege).to eq(obtain_user_privilege)
      end
    end

    context "when obtain_user_privilege: is not given" do
      it { expect(subject.obtain_user_privilege).to be(nil) }
    end

    context "when obtain_other_privilege: is given" do
      let(:obtain_other_privilege) { 'high' }

      subject do
        described_class.new(obtain_other_privilege: obtain_other_privilege)
      end

      it "must set #obtain_other_privilege" do
        expect(subject.obtain_other_privilege).to eq(obtain_other_privilege)
      end
    end

    context "when obtain_other_privilege: is not given" do
      it { expect(subject.obtain_other_privilege).to be(nil) }
    end

    context "when user_interaction_required: is given" do
      let(:user_interaction_required) { 'high' }

      subject do
        described_class.new(user_interaction_required: user_interaction_required)
      end

      it "must set #user_interaction_required" do
        expect(subject.user_interaction_required).to eq(user_interaction_required)
      end
    end

    context "when user_interaction_required: is not given" do
      it { expect(subject.user_interaction_required).to be(nil) }
    end
  end

  describe ".load" do
    include_examples ".load"

    let(:json_node) { json_tree['CVE_Items'][0]['impact']['baseMetricV2'] }

    include_examples "JSON Object field", json_key:     'cvssV2',
                                          method:       :cvss_v2,
                                          object_class: Schema::CVSSv2

    include_examples "JSON field", json_key: 'severity',
                                   method:   :severity

    include_examples "JSON field", json_key: 'exploitabilityScore',
                                   method:   :exploitability_score

    include_examples "JSON field", json_key: 'impactScore',
                                   method:   :impact_score

    include_examples "JSON field", json_key: 'acInsufInfo',
                                   method:   :ac_insuf_info

    include_examples "JSON field", json_key: 'obtainAllPrivilege',
                                   method:   :obtain_all_privilege

    include_examples "JSON field", json_key: 'obtainUserPrivilege',
                                   method:   :obtain_user_privilege

    include_examples "JSON field", json_key: 'obtainOtherPrivilege',
                                   method:   :obtain_other_privilege

    include_examples "JSON field", json_key: 'userInteractionRequired',
                                   method:   :user_interaction_required
  end
end
