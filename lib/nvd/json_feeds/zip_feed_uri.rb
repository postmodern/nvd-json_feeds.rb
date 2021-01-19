require 'nvd/json_feeds/feed_uri'
require 'nvd/json_feeds/zip_feed_file'

module NVD
  module JSONFeeds
    #
    # Represents a URI to a `.json.zip` feed file.
    #
    class ZipFeedURI < FeedURI

      #
      # Downloads the compressed feed file.
      #
      # @param [String] dest
      #   The destination file or directory.
      #
      # @return [ZipFeedFile]
      #
      def download(dest)
        ZipFeedFile.new(super(dest))
      end

    end
  end
end
