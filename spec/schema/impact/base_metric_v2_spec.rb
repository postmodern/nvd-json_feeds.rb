require 'spec_helper'
require 'schema/shared_examples'
require 'nvd/json_feeds/schema/impact'

describe Schema::Impact::BaseMetricV2 do
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
