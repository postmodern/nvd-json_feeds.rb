require 'rspec'
require 'nvd/json_feeds/version'

include NVD::JSONFeeds

RSpec.configure do |specs|
  specs.filter_run_excluding :integration
end
