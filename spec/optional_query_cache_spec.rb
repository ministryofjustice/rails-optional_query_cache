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
    Rack::MockRequest.env_for('http://example.org')
  end

  context 'with a normal route' do
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
