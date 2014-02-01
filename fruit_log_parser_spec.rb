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
        puts FruitLogParser.count_fruits(')apple {apple }[strawberry}strawberry melon]}')
        puts FruitLogParser.count_fruits('{apple [melon (strawberry](melon melon apple()}apple}')
        puts FruitLogParser.count_fruits('[melon ]](apple strawberry {melon ]) apple (apple{')
        puts FruitLogParser.count_fruits('(melon {apple strawberry strawberry)( apple [strawberry}}apple')
        puts FruitLogParser.count_fruits('strawberry (apple {apple }}}strawberry melon){apple strawberry (melon)[}')
        expect(true).to be_true
      end
    end
  end
end
