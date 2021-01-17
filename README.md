# nvd-json_feeds

* [Homepage](https://github.com/postmodern/nvd-json_feeds.rb#readme)
* [Issues](https://github.com/postmodern/nvd-json_feeds.rb/issues)
* [Documentation](http://rubydoc.info/gems/nvd-json_feeds/frames)
* [Email](mailto:postmodern.mod3 at gmail.com)

## Description

Provides a Ruby API to [NVD JSON Feeds].

## Features

* Supports [NVD JSON 1.1 Schema].

## Examples

    require 'nvd/json_feeds'

Access the Modified CVEs feed:

    NVD::JSONFeeds[:modified]
    # => #<NVD::JSONFeeds::Feed:0x0000556b4db58660
    #  @gz=
    #   #<NVD::JSONFeeds::GzFeedURI: https://nvd.nist.gov/feeds/json/cve/1.1/nvdcve-1.1-modified.json.gz>,
    #  @meta=
    #   #<NVD::JSONFeeds::MetaFeedURI: https://nvd.nist.gov/feeds/json/cve/1.1/nvdcve-1.1-modified.meta>,
    #  @name=:modified,
    #  @zip=
    #   #<NVD::JSONFeeds::ZipFeedURI: https://nvd.nist.gov/feeds/json/cve/1.1/nvdcve-1.1-modified.json.zip>>

Access the Recent CVEs feed:

    NVD::JSONFeeds[:recent]
    # => #<NVD::JSONFeeds::Feed:0x0000556b4da14c68
    #  @gz=
    #   #<NVD::JSONFeeds::GzFeedURI: https://nvd.nist.gov/feeds/json/cve/1.1/nvdcve-1.1-recent.json.gz>,
    #  @meta=
    #   #<NVD::JSONFeeds::MetaFeedURI: https://nvd.nist.gov/feeds/json/cve/1.1/nvdcve-1.1-recent.meta>,
    #  @name=:recent,
    #  @zip=
    #   #<NVD::JSONFeeds::ZipFeedURI: https://nvd.nist.gov/feeds/json/cve/1.1/nvdcve-1.1-recent.json.zip>>

Access the year 2020 CVEs feed:

    NVD::JSONFeeds[2020]
    # => #<NVD::JSONFeeds::Feed:0x0000556b4d55da80
    #  @gz=
    #   #<NVD::JSONFeeds::GzFeedURI: https://nvd.nist.gov/feeds/json/cve/1.1/nvdcve-1.1-2020.json.gz>,
    #  @meta=
    #   #<NVD::JSONFeeds::MetaFeedURI: https://nvd.nist.gov/feeds/json/cve/1.1/nvdcve-1.1-2020.meta>,
    #  @name=2020,
    #  @zip=
    #   #<NVD::JSONFeeds::ZipFeedURI: https://nvd.nist.gov/feeds/json/cve/1.1/nvdcve-1.1-2020.json.zip>>

Read the `.meta` feed file:

    meta = NVD::JSONFeeds[2020].meta.parse
    # => #<NVD::JSONFeeds::Meta:0x0000556b4e6f4960
    meta.last_modified_date
    # => #<DateTime: 2021-01-17T03:17:48-05:00 ((2459232j,29868s,0n),-18000s,2299161j)>
    meta.size
    # => 67524038
    meta.zip_size
    # => 3777141
    meta.gz_size
    # => 3777005
    meta.sha256
    # => "9288B92370FC4D6E92ACB6FFDDDA378C4B9F1B3B5257105BD6D92535DA46BD55"

Download the `.zip`/`.gz` feed file:

    zip_feed = NVD::JSONFeeds[2020].zip.download(dest)
    # => #<NVD::JSONFeeds::ZipFeedFile: ...>
    gz_feed = NVD::JSONFeeds[2020].gz.download(dest)
    # => #<NVD::JSONFeeds::GzFeedFile: ...>

Access a pre-downloaded `.zip`/`.gz` feed file:

    zip_feed = NVD::JSONFeeds::ZipFeedFile.new('path/to/nvdcve-1.1-2020.json.zip')
    # => #<NVD::JSONFeeds::ZipFeedFile: ...>
    gz_feed = NVD::JSONFeeds::GzFeedFile.new('path/to/nvdcve-1.1-2020.json.gz')
    # => #<NVD::JSONFeeds::GzFeedFile: ...>

Parse a `.zip`/`.gz` feed file (without extracting it):

    cve_feed = zip_feed.parse
    # => #<NVD::JSONFeeds::Schema::CVEFeed: ...>
    cve_feed = gz_feed.parse
    # => #<NVD::JSONFeeds::Schema::CVEFeed: ...>

Extracts a `.zip`/`.gz` feed file:

    json_feed = zip_feed.extract(dest_dir)
    # => #<NVD::JSONFeeds::JSONFeedFile: ...>
    json_feed = gz_feed.extract
    # => #<NVD::JSONFeeds::JSONFeedFile: ...>

Access a pre-extracted `.json` feed file:

    json_feed = NVD::JSONFeeds::JSONFeed.new('path/to/nvdcve-1.1-2020.json')
    # => #<NVD::JSONFeeds::JSONFeedFile: ...>
    cve_feed = json_feed.parse
    # => #<NVD::JSONFeeds::Schema::CVEFeed: ...>

## Requirements

* [ruby] >= 2.7.0
* [multi_json] ~> 1.0
* [cve_schema] ~> 0.1

## Install

    $ gem install nvd-json_feeds

### Gemfile

    gem 'nvd-json_feeds', '~> 0.1'

## Copyright

Copyright (c) 2021 Hal Brodigan

See {file:LICENSE.txt} for details.

[NVD JSON Feeds]: https://nvd.nist.gov/vuln/data-feeds#JSON_FEEDS
[NVD JSON 1.1 Schema]: https://csrc.nist.gov/schema/nvd/feed/1.1/nvd_cve_feed_json_1.1.schema

[multi_json]: https://github.com/intridea/multi_json#readme
[cve_schema]: https://github.com/postmodern/cve_schema.rb#readme
