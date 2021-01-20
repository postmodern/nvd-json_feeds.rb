require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/cpe/match'

describe Schema::CPE::Match do
  describe "#initialize" do
    context "when cpe23uri: is given" do
      let(:cpe23uri) { 'cpe:2.3:a:bitcoinsv:bitcoin_sv:*:*:*:*:*:*:*:*' }

      context "and when vulnerable: is given" do
        let(:vulnerable) { true }

        subject do
          described_class.new(
            cpe23uri:   cpe23uri,
            vulnerable: vulnerable
          )
        end

        it "must set #vulnerable" do
          expect(subject.vulnerable).to eq(vulnerable)
        end

        context "and when version_start_excluding: is given" do
          let(:version) { '1.2.3' }

          subject do
            described_class.new(
              cpe23uri:   cpe23uri,
              vulnerable: vulnerable,
              version_start_excluding: version
            )
          end

          it "must set #version_start_excluding" do
            expect(subject.version_start_excluding).to eq(version)
          end
        end

        context "but when version_start_excluding: is not given" do
          it { expect(subject.version_start_excluding).to be(nil) }
        end

        context "and when version_start_including: is given" do
          let(:version) { '1.2.3' }

          subject do
            described_class.new(
              cpe23uri:   cpe23uri,
              vulnerable: vulnerable,
              version_start_including: version
            )
          end

          it "must set #version_start_including" do
            expect(subject.version_start_including).to eq(version)
          end
        end

        context "but when version_start_including: is not given" do
          it { expect(subject.version_start_including).to be(nil) }
        end

        context "and when version_end_excluding: is given" do
          let(:version) { '1.2.3' }

          subject do
            described_class.new(
              cpe23uri:   cpe23uri,
              vulnerable: vulnerable,
              version_end_excluding: version
            )
          end

          it "must set #version_end_excluding" do
            expect(subject.version_end_excluding).to eq(version)
          end
        end

        context "but when version_end_excluding: is not given" do
          it { expect(subject.version_end_excluding).to be(nil) }
        end

        context "and when version_end_including: is given" do
          let(:version) { '1.2.3' }

          subject do
            described_class.new(
              cpe23uri:   cpe23uri,
              vulnerable: vulnerable,
              version_end_including: version
            )
          end

          it "must set #version_end_including" do
            expect(subject.version_end_including).to eq(version)
          end
        end

        context "but when version_end_including: is not given" do
          it { expect(subject.version_end_including).to be(nil) }
        end

        context "and when cpe_name: is given" do
          let(:cpe_name) { [double("CPE::Name1"), double("CPE::Name2")] }

          subject do
            described_class.new(
              cpe23uri:   cpe23uri,
              vulnerable: vulnerable,
              cpe_name:   cpe_name
            )
          end

          it "must set #cpe_name" do
            expect(subject.cpe_name).to eq(cpe_name)
          end
        end

        context "but when cpe_name: is not given" do
          it { expect(subject.cpe_name).to eq([]) }
        end
      end

      context "but when vulnerable: is not given" do
        it do
          expect {
            described_class.new
          }.to raise_error(ArgumentError)
        end
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
    include_examples ".load"

    let(:json_node) do
      json_tree['CVE_Items'][0]['configurations']['nodes'][0]['cpe_match'][0]
    end

    include_examples "JSON field", json_key: 'vulnerable',
                                   required: true,
                                   method:   :vulnerable

    include_examples "JSON field", json_key: 'cpe23Uri',
                                   required: true,
                                   method:   :cpe23uri

    pending 'need to find an example containing the "cpe22Uri" key' do
      include_examples "JSON field", json_key: 'cpe22Uri',
                                     required: true,
                                     method:   :cpe22uri
    end

    pending 'need to find an example containing the "versionStartExcluding" key' do
      include_examples "JSON field", json_key: 'versionStartExcluding',
                                     method: :version_start_excluding
    end

    pending 'need to find an example containing the "versionStartIncluding" key' do
      include_examples "JSON field", json_key: 'versionStartIncluding',
                                     method: :version_start_including
    end

    include_examples "JSON field", json_key: 'versionEndExcluding',
                                   method: :version_end_excluding

    pending 'need to find an example containing the "versionEndIncluding" key' do
      include_examples "JSON field", json_key: 'versionEndIncluding',
                                     method: :version_end_including
    end

    pending 'need to find an example containing the "cpe_name" key' do
      include_examples "JSON Array field", json_key: 'cpe_name',
                                           method: :cpe_name,
                                           element_class: Schema::CPE::Name
    end
  end
end
