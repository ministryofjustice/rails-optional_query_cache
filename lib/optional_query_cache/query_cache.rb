require 'active_record'

module OptionalQueryCache
  # Rack middleware to allow per-route disabling of ActiveRecord::QueryCache
  class QueryCache < ActiveRecord::QueryCache
    def call(env)
      if path_parameters(env)[:disable_query_cache]
        @app.call(env)
      else
        super(env)
      end
    end

    private

    def path_parameters(env)
      env['action_dispatch.routes'].recognize_path(
        env['REQUEST_PATH']
      )
    rescue ActionController::RoutingError
      {}
    end
  end
end
