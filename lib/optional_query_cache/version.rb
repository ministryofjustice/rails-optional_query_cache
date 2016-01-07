require 'active_record'

class OptionalQueryCache < ActiveRecord::QueryCache
  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 1
    PATCH = 0

    STRING = [MAJOR, MINOR, PATCH].join('.')
  end
end
