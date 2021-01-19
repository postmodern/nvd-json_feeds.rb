# frozen_string_literal: true

require 'net/https'

module NVD
  module JSONFeeds
    #
    # Base class for all feed URIs.
    #
    class FeedURI

      SCHEMA_VERSION = '1.1'

      BASE_URI = "https://nvd.nist.gov/feeds/json/cve/#{SCHEMA_VERSION}"

      # The feed name or year.
      #
      # @return [:modified, :recent, Integer]
      attr_reader :name

      # The feed file extension.
      #
      # @return [String]
      attr_reader :ext

      # The file name of the feed.
      #
      # @return [String]
      attr_reader :filename

      # The feed URI.
      #
      # @return [URI::HTTPS]
      attr_reader :uri

      #
      # Initializes the feed URI.
      #
      # @param [:modified, :recent, Integer] name
      #   The feed name or year.
      #
      # @param [String] ext
      #   The feed file extension (ex: `.json.gz`).
      #
      def initialize(name,ext)
        @name = name
        @ext  = ext

        @filename = "nvdcve-#{SCHEMA_VERSION}-#{@name}#{@ext}"
        @uri      = URI("#{BASE_URI}/#{@filename}")
      end

      #
      # Performs and HTTP GET request to the feed URI.
      #
      # @yield [chunk]
      #   If a block is given, it will be passed each chunk read from the
      #   response.
      #
      # @yieldparam [String] chunk
      #   A chunk of data read from the response body.
      #
      # @return [String]
      #   If no block is given, the full response body will be returned.
      #
      def get(&block)
        if block
          Net::HTTP.start(@uri.host,@uri.port, use_ssl: true) do |http|
            request = Net::HTTP::Get.new(uri)

            http.request(request) do |response|
              response.read_body(&block)
            end
          end
        else
          Net::HTTP.get(@uri)
        end
      end

      #
      # Downloads the feed to the given destination.
      #
      # @param [String] dest
      #   Either a destination file or directory.
      #
      def download(dest)
        dest_path = if File.directory?(dest) then File.join(dest,@filename)
                    else                          dest
                    end

        File.open(dest_path,'w') do |file|
          get do |chunk|
            file.write(chunk)
          end
        end

        return dest_path
      end

      #
      # Converts the feed URI to a regular URI.
      #
      # @return [URI::HTTPS]
      #   The feed URI.
      #
      def to_uri
        @uri
      end

      #
      # Converts the feed URI to a String.
      #
      # @return [String]
      #   The String version of the feed URI.
      #
      def to_s
        @uri.to_s
      end

      #
      # Inspects the feed URI.
      #
      # @return [String]
      #
      def inspect
        "#<#{self.class}: #{self}>"
      end

    end
  end
end
