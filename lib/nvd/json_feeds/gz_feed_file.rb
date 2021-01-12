# frozen_string_literal: true

require 'nvd/json_feeds/feed_file'
require 'nvd/json_feeds/json_feed_file'

require 'shellwords'

module NVD
  module JSONFeeds
    class GzFeedFile < FeedFile

      #
      # The filename of the `.json` file within the `.gz` archive.
      #
      # @return [String]
      #
      def json_filename
        File.basename(@path,'.gz')
      end

      #
      # Reads the compressed feed file.
      #
      # @return [String]
      #
      def read
        `gunzip -c -k #{Shellwords.escape(@path)}`
      rescue Errno::ENOENT
        raise("gunzip command is not installed")
      end

      #
      # Extracts the feed file.
      #
      # @return [JSONFeedFile]
      #
      def extract
        unless system('gunzip', '-k', @path)
          raise("gunzip command failed")
        end

        extracted_dir  = File.dirname(@path)
        extracted_path = File.join(extracted_dir,json_filename)

        unless File.file?(extracted_path)
          raise("extraction failed: #{@path.inspect}")
        end

        return JSONFeedFile.new(extracted_path)
      end
    end
  end
end
