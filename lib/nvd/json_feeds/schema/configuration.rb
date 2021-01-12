require 'nvd/json_feeds/schema/cpe/match'
require 'nvd/json_feeds/schema/has_data_version'

module NVD
  module JSONFeeds
    module Schema
      #
      # Represents the `"configuration"` value.
      #
      class Configuration
        #
        # Represents a value within `"nodes"`.
        #
        class Node

          OPERATORS = {
            'OR'  => :OR,
            'AND' => :AND
          }

          # @return [:OR, :AND, String]
          attr_reader :operator

          # @return [Boolean, nil]
          attr_reader :negate

          # @return [Array<Node>]
          attr_reader :children

          # @return [Array<CPE::Match>]
          attr_reader :cpe_match

          #
          # Initializes the node.
          #
          # @param [:OR, :AND, String] operator
          #
          # @param [Boolean, nil] negate
          #
          # @param [Array<Node>] children
          #
          # @param [Array<CPE::Match>] cpe_match
          #
          def initialize(operator: nil, negate: nil, children: [], cpe_match: [])
            @operator = operator
            @negate   = negate

            @children = children
            @cpe_match = cpe_match
          end

          #
          # Determines if {#negate} is `true`.
          #
          # @return [Boolean]
          #
          def negate?
            @negate == true
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
          # @see https://csrc.nist.gov/schema/nvd/feed/1.1-Beta/cvss-v2.0_beta.json
          #
          def self.from_json(json)
            {
              operator: if (operator = json['operator'])
                          OPERATORS.fetch(operator,operator)
              end,
              negate:   json['negate'],

              children:  Array(json['children']).map(&method(:load)),
              cpe_match: Array(json['cpe_match']).map(&CPE::Match.method(:load))
            }
          end

          #
          # Loads the node object from the parsed JSON.
          #
          # @param [Hash{String => Object}] json
          #   The parsed JSON.
          #
          # @return [Node]
          #   The node object.
          #
          def self.load(json)
            new(**from_json(json))
          end

        end

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
