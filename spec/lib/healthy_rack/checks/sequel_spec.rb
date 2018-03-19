RSpec.describe HealthyRack::Checks::Sequel do
  subject do
    described_class.new
  end

  describe '#verify' do
    context 'when sequel is defined' do
      it "doesn't raise error" do
        stub_const('Sequel', Module.new)
        expect { subject.verify }.to_not raise_error
      end
    end

    context 'when sequel is not defined' do
      it "raises 'UndefinedClassError'" do
        expect { subject.verify }.to raise_error(HealthyRack::Errors::UndefinedClassError)
      end
    end
  end

  describe '#call' do
    context 'when response from sequel was received' do
      it "responds with 'true'" do
        stub_const('Sequel::Model', spy)
        expect(subject.call).to eq(true)
      end
    end

    context 'when exception occured' do
      it "responds with 'false'" do
        model = double
        allow(model).to receive(:db).and_raise('boom')
        stub_const('Sequel::Model', model)
        expect(subject.call).to eq(false)
      end
    end
  end
end
