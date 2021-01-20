require 'rspec'
require 'json'

RSpec.shared_examples ".from_json" do
  let(:fixtures_dir)  { File.expand_path('../../fixtures',__FILE__) }
  let(:json_filename) { 'nvdcve-1.1-recent.json'                    }
  let(:json_file)     { File.join(fixtures_dir,json_filename)       }

  let(:json_tree) { JSON.parse(File.read(json_file)) }
  let(:json_node) { json_tree }

  subject { described_class.from_json(json_node) }
end

RSpec.shared_examples ".load" do
  include_examples ".from_json"

  subject { described_class.load(json_node) }

  it { expect(subject).to be_kind_of(described_class) }
end

RSpec.shared_examples "JSON field" do |method: , json_key: , required: false, value: nil, map: nil|
  context "\"#{json_key}\"" do
    let(:json_value) { json_node[json_key] }

    if value then let(:expected,&value)
    else
      if map then let(:expected) { map[json_value] }
      else        let(:expected) { json_value }
      end
    end

    if required
      it "must set ##{method}" do
        expect(subject.send(method)).to eq(expected)
      end

      context "when the \"#{json_key}\" key is missing" do
        before { json_node.delete(json_key) }

        it do
          expect {
            described_class.load(json_node)
          }.to raise_error(KeyError)
        end
      end
    else
      context "when the \"#{json_key}\" key is present" do
        it "must set ##{method}" do
          expect(subject.send(method)).to eq(expected)
        end
      end

      context "when the \"#{json_key}\" key is missing" do
        before { json_node.delete(json_key) }

        it do
          expect(subject.send(method)).to be(nil)
        end
      end
    end
  end
end

RSpec.shared_examples "JSON Object field" do |method: , json_key: , required: false, object_class: |
  let(:json_value) { json_node[json_key] }

  if required
    it { expect(subject.send(method)).to be_kind_of(object_class) }

    context "when the \"#{json_key}\" key is missing" do
      before { json_node.delete(json_key) }

      it do
        expect {
          described_class.load(json_node)
        }.to raise_error(KeyError)
      end
    end
  else
    context "when the \"#{json_key}\" key is present" do
      it { expect(subject.send(method)).to be_kind_of(object_class) }
    end

    context "when the \"#{json_key}\" key is missing" do
      before { json_node.delete(json_key) }

      it do
        expect(subject.send(method)).to be(nil)
      end
    end
  end
end

RSpec.shared_examples "JSON Array field" do |method: , json_key: , required: false, element_class: |
  let(:json_value) { json_node[json_key] }

  if required
    it { expect(subject.send(method)).to be_kind_of(Array) }
    it { expect(subject.send(method)).to_not be_empty }
    it { expect(subject.send(method)).to all(be_kind_of(element_class)) }

    it "must parse every element of \"#{json_key}\"" do
      expect(subject.send(method).length).to eq(json_value.length)
    end

    context "when the \"#{json_key}\" key is missing" do
      before { json_node.delete(json_key) }

      it do
        expect {
          described_class.load(json_node)
        }.to raise_error(KeyError)
      end
    end
  else
    context "when the \"#{json_key}\" key is present" do
      it { expect(subject.send(method)).to be_kind_of(Array) }
      it { expect(subject.send(method)).to_not be_empty }
      it { expect(subject.send(method)).to all(be_kind_of(element_class)) }
    end

    context "when the \"#{json_key}\" key is missing" do
      before { json_node.delete(json_key) }

      it do
        expect(subject.send(method)).to eq([])
      end
    end
  end
end
