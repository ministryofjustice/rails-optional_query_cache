require 'active_record'

require 'optional_query_cache/version'

# Rack middleware to allow per-route disabling of ActiveRecord::QueryCache
class OptionalQueryCache < ActiveRecord::QueryCache
  def call(env)
    path_parameters = env['action_dispatch.routes'].recognize_path(
      env['REQUEST_PATH']
    )
    if path_parameters[:disable_query_cache]
      @app.call(env)
    else
      super(env)
    end
  end
end
