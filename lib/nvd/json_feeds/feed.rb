# frozen_string_literal: true

require 'nvd/json_feeds/meta_feed_uri'
require 'nvd/json_feeds/gz_feed_uri'
require 'nvd/json_feeds/zip_feed_uri'

module NVD
  module JSONFeeds
    #
    # Represents a feed and it's various downloads.
    #
    class Feed

      # The feed name or year number.
      #
      # @return [:modified, :recent, Integer]
      attr_reader :name

      # The "meta" feed URI.
      #
      # @return [MetaFeedURI]
      attr_reader :meta

      # The ".gz" feed URI.
      #
      # @return [GzFeedURI]
      attr_reader :gz

      # The ".zip" feed URI.
      #
      # @return [ZipFeedURI]
      attr_reader :zip

      #
      # Initializes the feed.
      #
      # @param [:modified, :recent, Integer] name
      #   The feed name or year number.
      #
      def initialize(name)
        @name = name

        @meta = MetaFeedURI.new(@name,'.meta')
        @gz   = GzFeedURI.new(@name,'.json.gz')
        @zip  = ZipFeedURI.new(@name,'.json.zip')
      end

    end
  end
end
