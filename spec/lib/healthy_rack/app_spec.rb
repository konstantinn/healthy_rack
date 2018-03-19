RSpec.describe HealthyRack::App do
  let(:app) do
    Rack::URLMap.new('/_health' => HealthyRack.app)
  end

  let(:session) { Rack::Test::Session.new(app) }

  after do
    HealthyRack.reset_config
  end

  context 'without additional checks' do
    before do
      session.get '/_health'
    end

    it_behaves_like 'healthy response'
  end

  context 'when additional check is provided' do
    before do
      HealthyRack.configure do |config|
        config.add_checks(custom_check.new)
      end

      session.get '/_health'
    end

    context 'when check passed' do
      let(:custom_check) do
        Class.new(HealthyRack::Check) do
          def call
            true
          end

          def name
            :custom_check
          end
        end
      end

      it_behaves_like 'healthy response'
    end

    context 'when check failed' do
      let(:custom_check) do
        Class.new(HealthyRack::Check) do
          def call
            false
          end

          def name
            :custom_check
          end
        end
      end

      it_behaves_like 'error response', failed_checks: ['custom_check']
    end
  end
end
