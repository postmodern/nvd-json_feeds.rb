require 'nvd/json_feeds/schema/configurations/node'
require 'nvd/json_feeds/schema/has_data_version'

module NVD
  module JSONFeeds
    module Schema
      #
      # Represents the `"configurations"` value.
      #
      class Configurations

        include HasDataVersion

        # The nodes of the configuration.
        #
        # @return [Array<Node>]
        attr_reader :nodes

        #
        # Initializes the configuration.
        #
        # @param [Array<Node>] nodes
        #
        def initialize(nodes: [], **kwargs)
          super(**kwargs)

          @nodes = nodes
        end

        #
        # Maps the parsed JSON to a Symbol Hash for {#initialize}.
        #
        # @param [Hash{String => Object}] json
        #
        # @return [Hash{Symbol => Object}]
        #
        def self.from_json(json)
          {
            **super(json),

            nodes: Array(json['nodes']).map(&Node.method(:load))
          }
        end

        #
        # Loads the configuration from the parsed JSON.
        #
        # @param [Hash{String => Object}] json
        #   The parsed JSON.
        #
        # @return [Cojnfiguration]
        #   The loaded configuration object.
        #
        def self.load(json)
          new(**from_json(json))
        end

      end
    end
  end
end
