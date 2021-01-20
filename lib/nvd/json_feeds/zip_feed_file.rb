# frozen_string_literal: true

require 'nvd/json_feeds/feed_file'
require 'nvd/json_feeds/json_feed_file'
require 'nvd/json_feeds/exceptions'

require 'shellwords'

module NVD
  module JSONFeeds
    #
    # Represents a `.json.zip` feed file.
    #
    class ZipFeedFile < FeedFile

      #
      # The filename of the `.json` file within the `.zip` archive.
      #
      # @return [String]
      #
      def json_filename
        File.basename(@path,'.zip')
      end

      #
      # Reads the compressed feed file.
      #
      # @return [String]
      #
      # @raise [ReadFailed]
      #   The `unzip` command is not installed.
      #
      def read
        `unzip -qq -p #{Shellwords.escape(@path)} #{Shellwords.escape(json_filename)}`
      rescue Errno::ENOENT
        raise(ReadFailed,"unzip command is not installed")
      end

      #
      # Extracts the feed file.
      #
      # @return [JSONFeedFile]
      #
      # @raise [ExtractFailed]
      #   The `unzip` command failed or the `.json` file was not extracted.
      #
      def extract(dest_dir=nil)
        extracted_dir = dest_dir || File.dirname(@path)

        unless system('unzip', '-qq', '-d', extracted_dir, @path, json_filename)
          raise(ExtractFailed,"unzip command failed")
        end

        extracted_path = File.join(extracted_dir,json_filename)

        unless File.file?(extracted_path)
          raise(ExtractFailed,"extraction failed: #{@path.inspect}")
        end

        return JSONFeedFile.new(extracted_path)
      end
    end
  end
end
