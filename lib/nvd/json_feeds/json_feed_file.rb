require 'nvd/json_feeds/feed_file'

module NVD
  module JSONFeeds
    #
    # Represents a `.json` feed file.
    #
    class JSONFeedFile < FeedFile

      #
      # Reads the JSON feed file.
      #
      # @return [String]
      #
      def read
        File.read(@path)
      end

    end
  end
end
