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
end
