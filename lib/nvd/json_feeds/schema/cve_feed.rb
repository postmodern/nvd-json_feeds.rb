require 'nvd/json_feeds/schema/has_data_version'
require 'nvd/json_feeds/schema/timestamp'
require 'nvd/json_feeds/schema/cve_item'

module NVD
  module JSONFeeds
    module Schema
      #
      # Represents the parsed contents of a JSON CVE feed.
      #
      class CVEFeed

        include HasDataVersion
        include Enumerable

        DATA_TYPES = {
          'CVE' => :CVE
        }

        DATA_FORMATS = {
          'MITRE' => :MITRE
        }

        # The feed format.
        #
        # @return [:MITRE]
        attr_reader :data_format

        # The feed type.
        #
        # @return [:CVE]
        attr_reader :data_type

        # The number of CVEs.
        #
        # @return [Integer, nil]
        attr_reader :data_number_of_cves

        # The feed timestamp.
        #
        # @return [DateTime, nil]
        attr_reader :date_timestamp

        # The CVE items.
        #
        # @return [Array<CVEItem>]
        attr_reader :cve_items

        #
        # Initializes the JSON feed.
        #
        # @param [:MITRE] data_format
        #
        # @param [:CVE] data_type
        #
        # @param [Integer, nil] data_number_of_cves
        #
        # @param [DateTime, nil] data_timestamp
        #
        # @param [Array<CVEItem>] cve_items
        #
        def initialize(data_format: , data_type: , data_number_of_cves: nil,
                                                   data_timestamp: nil,
                                                   cve_items: ,
                                                   **kwargs)
          super(**kwargs)

          @data_format = data_format
          @data_type   = data_type
          @data_timestamp = data_timestamp

          @cve_items = cve_items
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
            data_type:   json.fetch('CVE_data_type'),
            data_format: json.fetch('CVE_data_format'),
            **super(json),

            data_number_of_cves: json.fetch('CVE_data_numberOfCVEs').to_i,

            data_timestamp: if (timestamp = json['CVE_data_timestamp'])
                              Timestamp.parse(timestamp)
                            end,

            cve_items: json.fetch('CVE_Items').map(&CVEItem.method(:load))
          }
        end

        #
        # Loads the JSON feed data from the parsed JSON.
        #
        # @param [Hash{String => Object}] json
        #   The parsed JSON.
        #
        # @return [JSONFeed]
        #   The loaded JSON data.
        #
        def self.load(json)
          new(**from_json(json))
        end

        #
        # Enumerates over each CVE item in the feed.
        #
        # @yield [cve_itme]
        #   The given block will be passed each CVE Item.
        #
        # @yieldparam [CVEItem] cve_item
        #   A CVE Item in the feed.
        #
        # @return [Enumerator]
        #   If no block is given, an enumerator will be returned.
        #
        def each(&block)
          @cve_items.each(&block)
        end

      end
    end
  end
end
