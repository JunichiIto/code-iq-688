require './fruit_log_parser'

describe FruitLogParser do
  describe '::parse_log' do
    specify do
      expect(FruitLogParser.parse_log('./fruits.log')).to eq [3, 6, 3, 5, 4]
    end
  end
  describe '::count_fruits' do
    subject { FruitLogParser.count_fruits(text) }
    describe 'sample' do
      let(:text) { '{apple strawberry (melon [ apple )}' }
      it { should eq 4 }
    end
    describe '01' do
      let(:text) { '{melon (()melon strawberry)][apple}' }
      it { should eq 4 }
    end
    describe '02' do
      let(:text) { '[apple apple }{melon](strawberry}(melon]]' }
      it { should eq 3 }
    end
    describe '03' do
      let(:text) { '({}apple) melon strawberry{melon(apple apple) melon strawberry}' }
      it { should eq 5 }
    end
    context 'same parenthesis nested' do
      describe do
        let(:text) { '(a)'}
        it { should eq 1 }
      end
      describe do
        let(:text) { '((a))'}
        it { should eq 1 }
      end
      describe do
        let(:text) { '(a())'}
        it { should eq 1 }
      end
      describe do
        let(:text) { '(()a)'}
        it { should eq 1 }
      end
      describe do
        let(:text) { '(a(b))'}
        it { should eq 2 }
      end
      describe do
        let(:text) { '((a)b)'}
        it { should eq 2 }
      end
      describe do
        let(:text) { '(a()b)'}
        it { should eq 2 }
      end
      describe do
        let(:text) { '(a(b)c)'}
        it { should eq 3 }
      end
      describe do
        let(:text) { '(a(b)c d)'}
        it { should eq 4 }
      end
      describe do
        let(:text) { '({}apple) melon strawberry(melon(apple apple) melon strawberry)' }
        it { should eq 5 }
      end
      describe do
        let(:text) { '({}apple) melon strawberry(melon(apple apple) (melon strawberry apple) melon' }
        it { should eq 3 }
      end
      describe do
        let(:text) { '({}apple) melon strawberry(melon(apple apple) (melon strawberry apple melon' }
        it { should eq 2 }
      end
      describe do
        let(:text) { '({}apple melon strawberry(melon(apple (apple melon strawberry apple melon' }
        it { should eq 0 }
      end
      describe do
        let(:text) { '({}apple) melon strawberry(melon(apple (apple)) (melon) (strawberry))' }
        it { should eq 5 }
      end
      describe do
        let(:text) { '({}apple) melon strawberry(melon(apple (apple)) (melon) (strawberry)) apple(melon(apple (apple)) (melon) (strawberry) melon)' }
        it { should eq 6 }
      end
    end
    describe 'hilohiro test' do
      describe do
        let(:text) { '{melon (()melon strawberry)][apple}' }
        it { should eq 4 }
        describe do
          let(:text) { '[apple apple }{melon](strawberry}(melon]]' }
          it { should eq 3 }
        end
        describe do
          let(:text) { '({}apple) melon strawberry{melon(apple apple) melon strawberry}' }
          it { should eq 5 }
        end
        describe do
          let(:text) { '(apple strawberry (melon {apple) strawberry) melon{apple} strawberry melon apple}' }
          it { should eq 7 }
        end
      end
    end
  end
end
