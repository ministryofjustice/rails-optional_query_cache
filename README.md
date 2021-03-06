OptionalQueryCache
==================

Drop-in replacement for ActiveRecord::QueryCache that allows
query-caching to be disabled on specific routes:

```ruby
get 'healthcheck', to: 'healthcheck#index', disable_query_cache: true
```

This is particularly useful for routes used to report if the app can
connect to the database or not (which ActiveRecord::QueryCache would
normally block by way of a connection error).

Getting started
---------------

Install the gem:

```ruby
# Gemfile
gem 'optional_query_cache', github: 'ministryofjustice/rails-optional_query_cache'
```

Tell your app to use the OptionalQueryCache middleware instead of
ActiveRecord::QueryCache:

```ruby
# config/application.rb
config.middleware.swap 'ActiveRecord::QueryCache', 'OptionalQueryCache::QueryCache'
```

Disable query caching on the routes in question:

```ruby
# config/routes.rb
get 'healthcheck', to: 'healthcheck#index', disable_query_cache: true
# or, for multiple routes…
scope disable_query_cache: true do
  get 'route1', to: 'route1#index'
  get 'route2', to: 'route2#index'
end
```
