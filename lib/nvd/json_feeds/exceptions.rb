module NVD
  module JSONFeeds
    class MetaParseError < RuntimeError
    end

    class FeedFileError < RuntimeError
    end

    class ReadFailed < FeedFileError
    end

    class ExtractFailed < FeedFileError
    end
  end
end
