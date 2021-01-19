require 'nvd/json_feeds/feed_uri'

module NVD
  module JSONFeeds
    #
    # Represents a URI to a `.json.gz` feed file.
    #
    class GzFeedURI < FeedURI

      #
      # Downloads the compressed feed file.
      #
      # @param [String] dest
      #   The destination file or directory.
      #
      # @return [GzFeedFile]
      #
      def download(dest)
        GzFeedFile.new(super(dest))
      end

    end
  end
end
