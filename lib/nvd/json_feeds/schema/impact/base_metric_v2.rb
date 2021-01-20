require 'nvd/json_feeds/schema/cvss_v2'

module NVD
  module JSONFeeds
    module Schema
      class Impact
        #
        # Represents the `"baseMetricV2"` value.
        #
        class BaseMetricV2

          # The CVSSv2 data.
          #
          # @return [CVSSv2, nil]
          attr_reader :cvss_v2

          # The severity.
          #
          # @return [String, nil]
          attr_reader :severity

          # The exploitability score.
          #
          # @return [Float, nil]
          attr_reader :exploitability_score

          # The impact score.
          #
          # @return [Float, nil]
          attr_reader :impact_score

          # @return [Boolean, nil]
          attr_reader :ac_insuf_info

          # @return [Boolean, nil]
          attr_reader :obtain_all_privilege

          # @return [Boolean, nil]
          attr_reader :obtain_user_privilege

          # @return [Boolean, nil]
          attr_reader :obtain_other_privilege

          # @return [Boolean, nil]
          attr_reader :user_interaction_required

          #
          # Initializes the base metric V2 object.
          #
          # @param [CVSSv2, nil] cvss_v2
          #
          # @param [String, nil] severity
          #
          # @param [Float, nil] exploitability_score
          #
          # @param [Float, nil] impact_score
          #
          # @param [Boolean, nil] ac_insuf_info
          #
          # @param [Boolean, nil] obtain_all_privilege
          #
          # @param [Boolean, nil] obtain_user_privilege
          #
          # @param [Boolean, nil] obtain_other_privilege
          #
          # @param [Boolean, nil] user_interaction_required
          #
          def initialize(cvss_v2: nil,
                         severity: nil,
                         exploitability_score: nil,
                         impact_score: nil,
                         ac_insuf_info: nil,
                         obtain_all_privilege: nil,
                         obtain_user_privilege: nil,
                         obtain_other_privilege: nil,
                         user_interaction_required: nil)
            @cvss_v2 = cvss_v2
            @severity = severity
            @exploitability_score = exploitability_score
            @impact_score = impact_score
            @ac_insuf_info = ac_insuf_info
            @obtain_all_privilege = obtain_all_privilege
            @obtain_user_privilege = obtain_user_privilege
            @obtain_other_privilege = obtain_other_privilege
            @user_interaction_required = user_interaction_required
          end

          #
          # Maps the parsed JSON to a Symbol Hash for {#initialize}.
          #
          # @param [Hash{String => Object}] json
          #   The parsed JSON.
          #
          # @return [Hash{Symbol => Object}]
          #   The Symbol Hash.
          #
          def self.from_json(json)
            {
              cvss_v2: if (value = json['cvssV2'])
                         CVSSv2.load(value)
                       end,

              severity:                  json['severity'],
              exploitability_score:      json['exploitabilityScore'],
              impact_score:              json['impactScore'],
              ac_insuf_info:             json['acInsufInfo'],
              obtain_all_privilege:      json['obtainAllPrivilege'],
              obtain_user_privilege:     json['obtainUserPrivilege'],
              obtain_other_privilege:    json['obtainOtherPrivilege'],
              user_interaction_required: json['userInteractionRequired']
            }
          end

          #
          # Loads the base metrics V2 object from the parsed JSON.
          #
          # @param [Hash{String => Object}] json
          #   The parsed JSON.
          #
          # @return [BaseMetricV2]
          #   The loaded base metric V3 object.
          #
          def self.load(json)
            new(**from_json(json))
          end

        end

      end
    end
  end
end
