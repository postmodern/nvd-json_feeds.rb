require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/configurations'

describe Schema::Configurations do
  describe "#initialize" do
    let(:data_version) { :"4.0" }

    context "when data_version: is given" do
      subject { described_class.new(data_version: data_version) }

      it "must set #data_version" do
        expect(subject.data_version).to eq(data_version)
      end

      context "and when nodes: is given" do
        let(:nodes) { [double(:Node1), double(:Node2)] }

        subject do
          described_class.new(data_version: data_version, nodes: nodes)
        end

        it "must set #nodes" do
          expect(subject.nodes).to eq(nodes)
        end
      end

      context "but when nodes: is not given" do
        it { expect(subject.nodes).to eq([]) }
      end
    end

    context "when data_version: is not given" do
      it do
        expect {
          described_class.new
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".load" do
    include_examples ".load"

    let(:json_node) { json_tree['CVE_Items'][0]['configurations'] }

    include_examples "JSON field", json_key: 'CVE_data_version',
                                   required: true,
                                   method:   :data_version,
                                   map:      described_class::DATA_VERSIONS

    include_examples "JSON Array field", json_key: 'nodes',
                                         method: :nodes,
                                         element_class: described_class::Node

  end
end
