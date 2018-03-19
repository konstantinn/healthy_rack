RSpec.describe HealthyRack::Middleware do
  let(:app) do
    app = ->(_env) { [200, {}, [JSON.generate(result: 'ok')]] }
    Rack::Builder.new do |builder|
      builder.use HealthyRack.middleware, path: '/_health'
      builder.run app
    end
  end

  let(:session) { Rack::Test::Session.new(app) }

  after do
    HealthyRack.reset_config
  end

  context 'when non health endpoint was called' do
    before do
      session.get '/endpoint'
    end

    it 'responds with HTTP 200' do
      expect(http_status).to eq(200)
    end

    it "responds with '{ result: ok }'" do
      expect(json_body).to eq('result' => 'ok')
    end
  end

  context 'when health endpoint was called' do
    before do
      session.get '/_health'
    end

    it_behaves_like 'healthy response'
  end
end
