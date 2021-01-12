require 'nvd/json_feeds/schema/timestamp'
require 'nvd/json_feeds/schema/configuration'
require 'nvd/json_feeds/schema/impact'
require 'cve_schema/cve'

module NVD
  module JSONFeeds
    module Schema
      #
      # Represents the `"CVE_Item"` JSON object.
      #
      class CVEItem

        # The CVE object.
        #
        # @return [CVESchema::CVE]
        attr_reader :cve

        # @return [Configuration, nil]
        attr_reader :configuration

        # @return [Impact, nil]
        attr_reader :impact

        # @return [DateTime, nil]
        attr_reader :published_date

        # @return [DateTime, nil]
        attr_reader :last_modified_date

        #
        # Initializes the CVE Item object.
        #
        # @param [CVESchema::CVE] cve
        #   The CVE object.
        #
        def initialize(cve: , configuration: nil,
                       impact: nil,
                       published_date: nil,
                       last_modified_date: nil)
          @cve = cve

          @configuration      = configuration
          @impact             = impact
          @published_date     = published_date
          @last_modified_date = last_modified_date
        end

        #
        # Maps the parsed JSON to a Symbol Hash for {#initialize}.
        #
        # @param [Hash{String => Object}] json
        #   The parsed JSON.
        #
        # @return [Hash{Symbol => Object}]
        #   The mapped Symbol Hash.
        #
        def self.from_json(json)
          {
            cve: CVESchema::CVE.load(json.fetch('cve')),
            configuration: if (configuration = json['configuration'])
                             Configuration.load(configuration)
                           end,
            impact: if (impact = json['impact'])
                      Impact.load(impact)
                    end,

            published_date: if (published_date = json['publishedDate'])
                              Timestamp.parse(published_date)
                            end,

            last_modified_date: if (last_modified_date = json['lastModifiedDate'])
                                  Timestamp.parse(last_modified_date)
                                end
          }
        end

        #
        # Loads the CVE Item object from the parsed JSON.
        #
        # @param [Hash{String => Object}] json
        #   The parsed JSON.
        #
        # @return [CVEItem]
        #   The loaded CVE Item object.
        #
        def self.load(json)
          new(**from_json(json))
        end

      end
    end
  end
end
