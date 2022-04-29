
require 'pry'
require 'miscellaneous'

describe Miscellaneous do
  
  describe '#create_piece' do
    let(:dummy_class) { Class.new { extend Miscellaneous } }
    context 'when input is white pawn' do
      it 'returns white pawn piece' do
        w_pawn = "\u265F".encode('utf-8')
        expect(dummy_class.create_piece('w', 'pawn')).to eq(w_pawn)
      end
    end
  end

end