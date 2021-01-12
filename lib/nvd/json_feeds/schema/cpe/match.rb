require 'nvd/json_feeds/schema/cpe/name'

module NVD
  module JSONFeeds
    module Schema
      module CPE
        #
        # Represents the `"cpe_match"` value.
        #
        class Match

          include HasURI

          # @return [Boolean]
          attr_reader :vulnerable

          # @return [String, nil]
          attr_reader :version_start_excluding

          # @return [String, nil]
          attr_reader :version_start_including

          # @return [String, nil]
          attr_reader :version_end_excluding

          # @return [String, nil]
          attr_reader :version_end_including

          # @return [Array<Name>]
          attr_reader :cpe_name

          #
          # Initializes the CPE match object.
          #
          # @param [Boolean] vulnerable
          #
          # @param [String, nil] version_start_excluding
          #
          # @param [String, nil] version_start_including
          #
          # @param [String, nil] version_end_excluding
          #
          # @param [String, nil] version_end_including
          #
          # @param [Array<Name>] cpe_name
          #
          def initialize(vulnerable: , version_start_excluding: nil,
                                       version_start_including: nil,
                                       version_end_excluding: nil,
                                       version_end_including: nil,
                                       cpe_name: [],
                                       **kwargs)
            super(**kwargs)

            @vulnerable = vulnerable

            @version_start_excluding = version_start_excluding
            @version_start_including = version_start_including

            @version_end_excluding = version_end_excluding
            @version_end_including = version_end_including

            @cpe_name = cpe_name
          end

          #
          # Determines if the CPE match indicates whether it's vulnerable.
          #
          # @return [Boolean]
          #
          def vulnerable?
            @vulnerable == true
          end

          #
          # Maps the CPE match JSON to a Symbol Hash for {#initialize}.
          #
          # @param [Hash{String => Object}] json
          #   The parsed JSON.
          #
          # @return [Hash{Symbol => Object}]
          #   The mapped Symbol Hash.
          #
          def self.from_json(json)
            {
              vulnerable: json.fetch('vulnerable'),

              **super(json),

              version_start_excluding: json['versionStartExcluding'],
              version_start_including: json['versionStartIncluding'],

              version_end_excluding: json['versionEndExcluding'],
              version_end_including: json['versionEndIncluding'],

              cpe_name: Array(json['cpe_name']).map(&Name.method(:load))
            }
          end

          #
          # Loads the CPE match object from the parsed JSON.
          #
          # @param [Hash{String => Object}] json
          #   The parsed JSON.
          #
          # @return [Match]
          #   The loaded CPE match object.
          #
          def self.load(json)
            new(**from_json(json))
          end

        end
      end
    end
  end
end
