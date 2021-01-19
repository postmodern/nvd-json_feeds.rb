require 'spec_helper'
require 'nvd/json_feeds/meta'

describe Meta do
  let(:last_modified_date_string) { '2021-01-18T08:01:40-05:00' }
  let(:last_modified_date) { DateTime.parse(last_modified_date_string) }
  let(:size) { 3499526 }
  let(:zip_size) {212317 }
  let(:gz_size) { 212173 }
  let(:sha256) { '9013088A0E882B4FBB590A25D8CC00431AE4CA465CB66EF9E2F7F231EE54BE6F' }

  describe "#initialize" do
    subject do
      described_class.new(last_modified_date,size,zip_size,gz_size,sha256)
    end

    it "must set #last_modified_date" do
      expect(subject.last_modified_date).to eq(last_modified_date)
    end

    it "must set #size" do
      expect(subject.size).to eq(size)
    end

    it "must set #zip_size" do
      expect(subject.zip_size).to eq(zip_size)
    end

    it "must set #gz_size" do
      expect(subject.gz_size).to eq(gz_size)
    end

    it "must set #sha256" do
      expect(subject.sha256).to eq(sha256)
    end
  end

  describe ".parse" do
    let(:string) do
      [
        "lastModifiedDate:#{last_modified_date_string}",
        "size:#{size}",
        "zipSize:#{zip_size}",
        "gzSize:#{gz_size}",
        "sha256:#{sha256}"
      ].join("\r\n")
    end

    subject { described_class }

    it "must return a #{described_class} object" do
      expect(subject.parse(string)).to be_kind_of(described_class)
    end

    context "lastModifiedDate" do
      subject { described_class.parse(string) }

      it "must parse into a DatEtime" do
        expect(subject.last_modified_date).to be_kind_of(DateTime)
      end

      it { expect(subject.last_modified_date).to eq(last_modified_date) }
    end

    context "size" do
      subject { described_class.parse(string) }

      it "must convert into an Integer" do
        expect(subject.size).to be_kind_of(Integer)
      end

      it { expect(subject.size).to eq(size) }
    end

    context "zipSize" do
      subject { described_class.parse(string) }

      it "must convert into an Integer" do
        expect(subject.zip_size).to be_kind_of(Integer)
      end

      it { expect(subject.zip_size).to eq(zip_size) }
    end

    context "gzSize" do
      subject { described_class.parse(string) }

      it "must convert into an Integer" do
        expect(subject.gz_size).to be_kind_of(Integer)
      end

      it { expect(subject.gz_size).to eq(gz_size) }
    end

    context "sha256" do
      subject { described_class.parse(string) }

      it { expect(subject.sha256).to eq(sha256) }
    end

    context "when lastModifiedDate is missing" do
      let(:string) { super().sub(/^lastModifiedDate:.*$/,'') }

      it do
        expect { subject.parse(string) }.to raise_error(MetaParseError)
      end
    end

    context "when size is missing" do
      let(:string) { super().sub(/^size:.*$/,'') }

      it do
        expect { subject.parse(string) }.to raise_error(MetaParseError)
      end
    end

    context "when zipSize is missing" do
      let(:string) { super().sub(/^zipSize:.*$/,'') }

      it do
        expect { subject.parse(string) }.to raise_error(MetaParseError)
      end
    end

    context "when gzSize is missing" do
      let(:string) { super().sub(/^gzSize:.*$/,'') }

      it do
        expect { subject.parse(string) }.to raise_error(MetaParseError)
      end
    end

    context "when sha256 is missing" do
      let(:string) { super().sub(/^sha256:.*$/,'') }

      it do
        expect { subject.parse(string) }.to raise_error(MetaParseError)
      end
    end
  end
end
