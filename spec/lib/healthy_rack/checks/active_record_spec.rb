RSpec.describe HealthyRack::Checks::ActiveRecord do
  subject do
    described_class.new
  end

  describe '#verify' do
    context 'when active record is defined' do
      it "doesn't raise error" do
        stub_const('ActiveRecord', Module.new)
        expect { subject.verify }.to_not raise_error
      end
    end

    context 'when active record is not defined' do
      it "raises 'UndefinedClassError'" do
        expect { subject.verify }.to raise_error(HealthyRack::Errors::UndefinedClassError)
      end
    end
  end

  describe '#call' do
    context 'when response from active record was received' do
      it "responds with 'true'" do
        migrator = double(current_version: '20170124143900')
        stub_const('ActiveRecord::Migrator', migrator)
        expect(subject.call).to eq(true)
      end
    end

    context 'when exception occured' do
      it "responds with 'false'" do
        migrator = double
        allow(migrator).to receive(:current_version).and_raise('boom')
        stub_const('ActiveRecord::Migrator', migrator)
        expect(subject.call).to eq(false)
      end
    end
  end
end
