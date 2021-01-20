require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/cpe/name'

describe Schema::CPE::Name do
  describe "#initialize" do
    context "when cpe23uri: is given" do
      let(:cpe23uri) { 'cpe:2.3:a:bitcoinsv:bitcoin_sv:*:*:*:*:*:*:*:*' }

      subject { described_class.new(cpe23uri: cpe23uri) }

      it "must set #cpe23uri" do
        expect(subject.cpe23uri).to eq(cpe23uri)
      end

      context "and when last_modified_date: is given" do
        let(:last_modified_date) { DateTime.now }

        subject do
          described_class.new(
            cpe23uri:           cpe23uri,
            last_modified_date: last_modified_date
          )
        end

        it "must set #last_modified_date" do
          expect(subject.last_modified_date).to eq(last_modified_date)
        end
      end

      context "but when last_modified_date: is not given" do
        it { expect(subject.last_modified_date).to be(nil) }
      end
    end

    context "but when cpe23uri: is not given" do
      it do
        expect {
          described_class.new
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".load" do
    pending 'need to find an example containing the "cpe_name" key' do
      include_examples ".load"

      let(:json_node) do
        json_tree['CVE_Items'][0]['configurations']['nodes'][0]['cpe_match'][0]['cpe_name']
      end
    end
  end
end
