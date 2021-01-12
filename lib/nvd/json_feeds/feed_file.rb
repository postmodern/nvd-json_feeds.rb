require 'nvd/json_feeds/schema/cve_feed'

require 'multi_json'
require 'digest/sha2'

module NVD
  module JSONFeeds
    class FeedFile

      # The path to the feed file.
      #
      # @return [String]
      attr_reader :path

      #
      # Initializes the feed file.
      #
      # @param [String] path
      #   The path to the feed file.
      #
      def initialize(path)
        @path = File.expand_path(path)
      end

      #
      # @see #parse
      #
      def self.parse(path)
        new(path).parse
      end

      #
      # Calculates the SHA256 checksum of the feed file.
      #
      # @return [String]
      #
      # @note NVD uses all upper-case SHA256 checksums.
      #
      def sha256
        Digest::SHA256.hexdigest(read).upcase
      end

      #
      # Reads the feed file.
      #
      # @return [String]
      #
      # @abstract
      #
      def read
        raise(NotImplementedError,"#{self.class}#read not implemented")
      end

      #
      # Parses the JSON.
      #
      # @return [Hash{String => Object}]
      #   The parsed JSON.
      #
      def json
        MultiJson.load(read)
      end

      #
      # Loads the CVE data from the feed file.
      #
      # @return [CVEFeed]
      #   The CVE feed data.
      #
      def parse
        Schema::CVEFeed.load(json)
      end

      #
      # Converts the feed file to a String.
      #
      # @return [String]
      #   The feed file path.
      #
      def to_s
        @path
      end

      #
      # Inspects the feed file.
      #
      # @return [String]
      #
      def inspect
        "<#{self.class}: #{self}>"
      end

    end
  end
end
