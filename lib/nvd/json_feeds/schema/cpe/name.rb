require 'nvd/json_feeds/schema/cpe/has_uri'
require 'nvd/json_feeds/schema/timestamp'

module NVD
  module JSONFeeds
    module Schema
      module CPE
        #
        # Represents the `"cpe_name"` value.
        #
        class Name

          include HasURI

          # Last modified date.
          #
          # @return [DateTime, nil]
          attr_reader :last_modified_date

          #
          # Initializes the CPE name.
          #
          # @param [DateTime, nil] last_modified_date
          #
          def initialize(last_modified_date: nil, **kwargs)
            super(**kwargs)

            @last_modified_date = last_modified_date
          end

          #
          # Maps the parsed JSON to a Symbol Hash for {#initialize}.
          #
          # @param [Hash{String => Object}] json
          #   The parsed JSON Hash.
          #
          # @return [Hash{Symbol => Object}]
          #   The mapped Symbol Hash.
          #
          def self.from_json(json)
            {
              **super(json),

              last_modified_date: if (last_modified_date = json['lastModifiedDate'])
                                    Timestamp.parse(last_modified_date)
                                  end
            }
          end

          #
          # Loads the CPE name object from the parsed JSON.
          #
          # @param [Hash{String => Object}] json
          #   The parsed JSON Hash.
          #
          # @return [Name]
          #   The loaded CPE name object.
          #
          def self.load(json)
            new(**from_json(json))
          end

        end
      end
    end
  end
end
