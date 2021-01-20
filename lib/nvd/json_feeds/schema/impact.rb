require 'nvd/json_feeds/schema/impact/base_metric_v2'
require 'nvd/json_feeds/schema/impact/base_metric_v3'

module NVD
  module JSONFeeds
    module Schema
      #
      # Represents the `"impact"` value.
      #
      class Impact

        # The base metric V3.
        #
        # @return [BaseMetricV3, nil]
        attr_reader :base_metric_v3

        # The base metric V2.
        #
        # @return [BaseMetricV2, nil]
        attr_reader :base_metric_v2

        #
        # Initializes the impact object.
        #
        # @param [BaseMetricV3, nil] base_metric_v3
        #   The parsed `"baseMetricV3"` object.
        #
        # @param [BaseMetricV2, nil] base_metric_v2
        #   The parsed `"baseMetricV3"` object.
        #
        def initialize(base_metric_v3: nil, base_metric_v2: nil)
          @base_metric_v3 = base_metric_v3
          @base_metric_v2 = base_metric_v2
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
            base_metric_v3: if (base_metric_v3 = json['baseMetricV3'])
                              BaseMetricV3.load(base_metric_v3)
                            end,

            base_metric_v2: if (base_metric_v2 = json['baseMetricV2'])
                              BaseMetricV2.load(base_metric_v2)
                            end
          }
        end

        #
        # Loads the impact object from the parsed JSON.
        #
        # @param [Hash{String => Object}] json
        #   The parsed JSON.
        #
        # @return [Impact]
        #   The loaded impact object.
        #
        def self.load(json)
          new(**from_json(json))
        end

      end
    end
  end
end
