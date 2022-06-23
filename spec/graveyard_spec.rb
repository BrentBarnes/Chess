
require_relative '../lib/main'

describe Graveyard do

  describe '#send_piece_to_graveyard' do

    context 'when a white pawn is passed in' do
      let(:game) { Game.new }
      subject(:graveyard) { described_class.new(game) }

      it 'adds the white pawn to the white graveyard' do
        graveyard.send_piece_to_graveyard(Pawn.new('white'))
        expect(graveyard.white_graveyard).to eq(['♟'])
      end
    end

    context 'when a black pawn is passed in' do
      let(:game) { Game.new }
      subject(:graveyard) { described_class.new(game) }

      it 'adds the white pawn to the white graveyard' do
        graveyard.send_piece_to_graveyard(Pawn.new('black'))
        expect(graveyard.black_graveyard).to eq(['♙'])
      end
    end
  end
end