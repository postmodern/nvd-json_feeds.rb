require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/cpe/match'

describe Schema::CPE::Match do
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
