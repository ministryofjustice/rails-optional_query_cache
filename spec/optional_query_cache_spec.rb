require 'action_controller/metal/exceptions'
require 'active_record'
require 'rack'

require 'spec_helper'

require 'optional_query_cache'

RSpec.describe OptionalQueryCache do
  let(:app) { ->(env) { [200, env, 'app'] } }

  let :subject do
    described_class.new(app)
  end

  let :env do
    double.tap do |env|
      allow(env).to receive(:[]).with('REQUEST_PATH').and_return('')
    end
  end

  context 'with a normal route' do
    before do
      allow(env).to receive(:[]).with('action_dispatch.routes').and_return(
        double(
          'routes',
          recognize_path: {}
        )
      )
    end

    it 'permits query caching' do
      expect(ActiveRecord::Base).to receive(:connection).and_return(
        double(
          'connection',
          query_cache_enabled: true,
          enable_query_cache!: nil
        )
      )
      subject.call(env)
    end
  end

  context 'with disable_query_cache set on the route' do
    before do
      allow(env).to receive(:[]).with('action_dispatch.routes').and_return(
        double(
          'routes',
          recognize_path: {
            disable_query_cache: true
          }
        )
      )
    end

    it 'disables query caching for the route' do
      expect(ActiveRecord::Base).not_to receive(:connection)
      subject.call(env)
    end
  end

  context 'with an unrecognised route' do
    before do
      allow(env).to receive(:[]).with('action_dispatch.routes').and_raise(
        ActionController::RoutingError.new('Unrecognised route')
      )
    end

    it 'permits query caching' do
      expect(ActiveRecord::Base).to receive(:connection).and_return(
        double(
          'connection',
          query_cache_enabled: true,
          enable_query_cache!: nil
        )
      )
      subject.call(env)
    end
  end
end
