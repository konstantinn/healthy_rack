RSpec.describe HealthyRack::Checks::Redis do
  subject do
    described_class.new('redis://redis:7379/0')
  end

  describe '#verify' do
    context 'when redis is defined' do
      it "doesn't raise error" do
        stub_const('Redis', Module.new)
        expect { subject.verify }.to_not raise_error
      end
    end

    context 'when redis is not defined' do
      it "raises 'UndefinedClassError'" do
        expect { subject.verify }.to raise_error(HealthyRack::Errors::UndefinedClassError)
      end
    end
  end

  describe '#call' do
    before do
      stub_const('Redis', redis)
    end

    context 'when response from redis was received' do
      context "when response is 'PONG'" do
        let(:redis) do
          Class.new do
            def initialize(url:); end

            def ping
              'PONG'
            end
          end
        end

        it "responds with 'true'" do
          expect(subject.call).to eq(true)
        end
      end

      context "when response is different from 'PONG'" do
        let(:redis) do
          Class.new do
            def initialize(url:); end

            def ping
              'DEFINITELY NOT A PONG'
            end
          end
        end

        it "responds with 'false'" do
          expect(subject.call).to eq(false)
        end
      end
    end

    context 'when exception occured' do
      let(:redis) do
        Class.new do
          def initialize(url:); end

          def ping
            raise 'ping pong failed'
          end
        end
      end

      it "responds with 'false'" do
        expect(subject.call).to eq(false)
      end
    end
  end
end
