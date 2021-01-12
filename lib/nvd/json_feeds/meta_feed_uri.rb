require 'nvd/json_feeds/feed_uri'
require 'nvd/json_feeds/meta'

module NVD
  module JSONFeeds
    #
    # Represents a URI to the `.meta` feed file.
    #
    class MetaFeedURI < FeedURI

      #
      # Requests and parses the feed metadata.
      #
      # @return [FeedMeta]
      #
      def parse
        Meta.parse(get)
      end

    end
  end
end
