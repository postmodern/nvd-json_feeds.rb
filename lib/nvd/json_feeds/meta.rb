require 'nvd/json_feeds/exceptions'

require 'time'

module NVD
  module JSONFeeds
    #
    # Represents the parsed contents of a `.meta` file.
    #
    class Meta

      # The date the feed file was last updated.
      #
      # @return [DateTime]
      attr_reader :last_modified_date

      # The size of the uncompressed `.json` feed file.
      #
      # @return [Integer]
      attr_reader :size

      # The size of the `.zip` feed file.
      #
      # @return [Integer]
      attr_reader :zip_size

      # The size of the `.gz` feed file.
      #
      # @return [Integer]
      attr_reader :gz_size

      # The SHA256 checksum of the uncompressed `.json` feed file.
      #
      # @return [String]
      # @note NVD uses all upper-case SHA256 checksums.
      attr_reader :sha256

      #
      # Initializes the feed metadata.
      #
      # @param [DateTime] last_modified_date
      #   The parsed `lastModifiedDate` timestamp.
      #
      # @param [Integer] size
      #   The `size` value.
      #
      # @param [Integer] zip_size
      #   The `zipSize` value.
      #
      # @param [Integer] gz_size
      #   The `gzSize` value.
      #
      # @param [String] sha256
      #   The `sha256` value.
      #
      def initialize(last_modified_date,size,zip_size,gz_size,sha256)
        @last_modified_date = last_modified_date

        @size     = size
        @zip_size = zip_size
        @gz_size  = gz_size
        @sha256   = sha256
      end

      #
      # Parses the text.
      #
      # @param [String] string
      #   The raw meta string.
      #
      # @return [Meta]
      #   The parsed meta information.
      #
      # @raise [MetaParseError]
      #   The meta string was malformed.
      #
      def self.parse(string)
        last_modified_date = nil
        size     = nil
        zip_size = nil
        gz_size  = nil
        sha256   = nil

        string.each_line do |line|
          name, value = line.chomp.split(':',2)

          case name
          when 'lastModifiedDate'
            last_modified_date = DateTime.parse(value)
          when 'size'    then size     = value.to_i
          when 'zipSize' then zip_size = value.to_i
          when 'gzSize'  then gz_size  = value.to_i
          when 'sha256'  then sha256   = value
          end
        end

        unless last_modified_date
          raise(MetaParseError,"lastModifiedDate missing")
        end

        unless size
          raise(MetaParseError,"size entry missing")
        end

        unless zip_size
          raise(MetaParseError,"zipSize entry missing")
        end

        unless gz_size
          raise(MetaParseError,"gzSize entry missing")
        end

        unless sha256
          raise(MetaParseError,"sha256 entry missing")
        end

        return new(last_modified_date,size,zip_size,gz_size,sha256)
      end

    end
  end
end
