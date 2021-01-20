require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/configurations/node'

describe Schema::Configurations::Node do
  describe "#initialize" do
    context "when operator: is given" do
      let(:operator) { :AND }

      subject { described_class.new(operator: operator) }

      it "must set #operator" do
        expect(subject.operator).to eq(operator)
      end
    end

    context "when operator: is not given" do
      it { expect(subject.operator).to be(nil) }
    end

    context "when negate: is given" do
      let(:negate) { true }

      subject { described_class.new(negate: negate) }

      it "must set #negate" do
        expect(subject.negate).to eq(negate)
      end
    end

    context "when negate: is not given" do
      it { expect(subject.negate).to be(nil) }
    end

    context "when children: is given" do
      let(:children) { [double(:Node1), double(:Node2)] }

      subject { described_class.new(children: children) }

      it "must set #children" do
        expect(subject.children).to eq(children)
      end
    end

    context "when children: is not given" do
      it { expect(subject.children).to eq([]) }
    end

    context "when cpe_match: is given" do
      let(:cpe_match) { [double("CPE::Match1"), double("CPE::Match2")] }

      subject { described_class.new(cpe_match: cpe_match) }

      it "must set #cpe_match" do
        expect(subject.cpe_match).to eq(cpe_match)
      end
    end

    context "when cpe_match: is not given" do
      it { expect(subject.cpe_match).to eq([]) }
    end
  end

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
