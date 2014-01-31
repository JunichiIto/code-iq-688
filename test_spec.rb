require './test'

describe Test do
  describe '#hoge' do
    subject { Test.hoge(text) }
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
        puts Test.hoge(')apple {apple }[strawberry}strawberry melon]}')
        puts Test.hoge('{apple [melon (strawberry](melon melon apple()}apple}')
        puts Test.hoge('[melon ]](apple strawberry {melon ]) apple (apple{')
        puts Test.hoge('(melon {apple strawberry strawberry)( apple [strawberry}}apple')
        puts Test.hoge('strawberry (apple {apple }}}strawberry melon){apple strawberry (melon)[}')
        expect(true).to be_true
      end
    end
  end
end
