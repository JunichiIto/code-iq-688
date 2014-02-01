require './fruit_log_parser'

describe FruitLogParser do
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
  end
  describe '::parse_log' do
    specify do
      expect(FruitLogParser.parse_log('./fruits.log')).to eq [3, 6, 3, 5, 4]
    end
  end
end
