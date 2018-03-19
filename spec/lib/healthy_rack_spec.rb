RSpec.describe HealthyRack do
  describe '.configure' do
    context 'when additional check is provided ' do
      context 'when check fails verification' do
        let(:custom_check) do
          Class.new(HealthyRack::Check) do
            def verify
              raise HealthyRack::Errors::UndefinedClassError
            end
          end
        end

        it 'raises error during configuration' do
          expect do
            HealthyRack.configure do |config|
              config.add_checks(custom_check.new)
            end
          end.to raise_error(HealthyRack::Errors::UndefinedClassError)
        end
      end
    end
  end
end
