RSpec.describe HealthyRack::Check do
  subject do
    described_class.new
  end

  describe '#verify' do
    it "returns 'nil'" do
      expect(subject.verify).to eq(nil)
    end
  end

  describe '#call' do
    it "raises 'NotImplementedError'" do
      expect { subject.call }.to raise_error(NotImplementedError)
    end
  end

  describe '#name' do
    context "when class doesn't have name" do
      it 'returns demodulized and underscored class name' do
        expect(subject.name).to eq('check')
      end
    end

    context 'when class has name' do
      let(:anonymous_class) do
        Class.new(described_class)
      end

      it "raises 'NotImplementedError'" do
        expect { anonymous_class.new.name }.to raise_error(NotImplementedError)
      end
    end
  end
end
