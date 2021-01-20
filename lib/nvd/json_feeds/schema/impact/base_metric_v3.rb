require 'nvd/json_feeds/schema/cvss_v3'

module NVD
  module JSONFeeds
    module Schema
      class Impact
        #
        # Represents the `"baseMetricV3"` value.
        #
        class BaseMetricV3

          # The CVSSv3 data.
          #
          # @return [CVSSv3]
          attr_reader :cvss_v3

          # The exploitability score.
          #
          # @return [Float, nil]
          attr_reader :exploitability_score

          # The impact score.
          #
          # @return [Float, nil]
          attr_reader :impact_score

          #
          # Initializes the base metric v3 object.
          #
          # @param [CVSSv3] cvss_v3
          #
          # @param [Float, nil] exploitability_score
          #
          # @param [Float, nil] impact_score
          #
          def initialize(cvss_v3: , exploitability_score: nil,
                                    impact_score: nil)
            @cvss_v3 = cvss_v3

            @exploitability_score = exploitability_score
            @impact_score         = impact_score
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
              cvss_v3: CVSSv3.load(json.fetch('cvssV3')),

              exploitability_score: json['exploitabilityScore'],
              impact_score:         json['impactScore']
            }
          end

          #
          # Loads the base metrics V3 object from the parsed JSON.
          #
          # @param [Hash{String => Object}] json
          #   The parsed JSON.
          #
          # @return [BaseMetricV3]
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
