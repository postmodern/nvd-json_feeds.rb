module NVD
  module JSONFeeds
    module Schema
      #
      # Adds the {#data_version} attribute.
      #
      module HasDataVersion
        DATA_VERSIONS = {'4.0' => :"4.0"}

        #
        # Extends {ClassMethods}.
        #
        def self.included(base)
          base.extend ClassMethods
        end

        #
        # The class methods.
        #
        module ClassMethods
          #
          # Maps the parsed JSON to a Symbol Hash for {#initialize}.
          #
          # @param [Hash{String => Object}] json
          #   The parsed JSON.
          #
          # @return [Hash{Symbol => Object}]
          #   The Symbol Hash.
          #
          def from_json(json)
            {
              data_version: DATA_VERSIONS.fetch(json.fetch('CVE_data_version'))
            }
          end
        end

        # The data version.
        #
        # @return [:"4.0", String]
        attr_reader :data_version

        #
        # Initializes the data version.
        #
        # @param [:"4.0", String] data_version
        #   The data version.
        #
        def initialize(data_version: )
          @data_version = data_version
        end
      end
    end
  end
end
