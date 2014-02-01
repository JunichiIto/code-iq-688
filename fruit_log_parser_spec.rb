require './fruit_log_parser'

describe FruitLogParser do
  describe '#count_fruits' do
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
    describe 'solve question' do
      specify do
        File.readlines('./fruits.log').each do |line|
          puts FruitLogParser.count_fruits line
        end
        expect(true).to be_true
      end
    end
  end
end
