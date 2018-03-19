RSpec.describe HealthyRack::Checks::Sidekiq do
  subject do
    described_class.new
  end

  describe '#verify' do
    context 'when sidekiq is defined' do
      it "doesn't raise error" do
        stub_const('Sidekiq', Module.new)
        expect { subject.verify }.to_not raise_error
      end
    end

    context 'when sidekiq is not defined' do
      it "raises 'UndefinedClassError'" do
        expect { subject.verify }.to raise_error(HealthyRack::Errors::UndefinedClassError)
      end
    end
  end

  describe '#call' do
    context 'when response from sidekiq was received' do
      it "responds with 'true'" do
        sidekiq = double(redis_info: { 'redis_version' => '3.2.4' })
        stub_const('Sidekiq', sidekiq)
        expect(subject.call).to eq(true)
      end
    end

    context 'when exception occured' do
      it "responds with 'false'" do
        sidekiq = double
        allow(sidekiq).to receive(:redis_info).and_raise('boom')
        stub_const('Sidekiq', sidekiq)
        expect(subject.call).to eq(false)
      end
    end
  end
end
