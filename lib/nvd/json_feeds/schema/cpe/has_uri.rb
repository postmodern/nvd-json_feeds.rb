module NVD
  module JSONFeeds
    module Schema
      module CPE
        #
        # Adds the {#cpe23uri} and {#cpe22uri} attributes.
        #
        module HasURI
          #
          # Extends {ClassMethods}.
          #
          def self.included(base)
            base.extend ClassMethods
          end

          #
          # Class methods.
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
                cpe23uri: json.fetch('cpe23Uri'),
                cpe22uri: json['cpe22Uri']
              }
            end
          end

          #
          # Initializes the CPE URIs.
          #
          # @param [String] cpe23uri
          #   The CPE 2.3 URI.
          #
          # @param [String] cpe22uri
          #   The CPE 2.2 URI.
          #
          def initialize(cpe23uri: , cpe22uri: nil)
            @cpe23uri = cpe23uri
            @cpe22uri = cpe22uri
          end

          # The CPE 2.3 URI.
          #
          # @return [String]
          attr_reader :cpe23uri

          alias cpe_uri cpe23uri

          # The CPE 2.2 URI.
          #
          # @return [String, nil]
          attr_reader :cpe22uri
        end
      end
    end
  end
end
