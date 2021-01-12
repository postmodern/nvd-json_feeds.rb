require 'nvd/json_feeds/feed'
require 'nvd/json_feeds/version'

require 'date'

module NVD
  module JSONFeeds
    FEEDS =  Hash[[:modified, :recent, *(2002 .. Date.today.year)].map { |name|
      [name, Feed.new(name)]
    }]

    #
    # Accesses a feed with the given name or year number.
    #
    # @param [:modified, :recent, Integer] name
    #   The feed name or year number.
    #
    # @return [Feed, nil]
    #   The feed.
    #
    def self.[](name)
      FEEDS[name]
    end
  end
end
