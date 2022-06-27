
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

  describe '#save_graveyard' do

    context 'when the graveyard is saved' do
      let(:game) { Game.new }
      subject(:graveyard) { described_class.new(game) }

      it 'returns a nested array of the graveyards' do
        graveyard.instance_variable_set(:@white_graveyard, ['♟','♟','♟','♟'])
        graveyard.instance_variable_set(:@black_graveyard, ['♘','♘','♘'])
        grave_array = [['♟','♟','♟','♟'], ['♘','♘','♘']]
        expect(graveyard.save_graveyard).to eq(grave_array)
      end
    end
  end
end