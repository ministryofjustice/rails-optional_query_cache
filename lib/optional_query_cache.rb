require 'active_record'

require 'optional_query_cache/version'

# Rack middleware to allow per-route disabling of ActiveRecord::QueryCache
class OptionalQueryCache < ActiveRecord::QueryCache
end
