
require 'piece'
require 'piece_subclasses/king'

describe Piece do

  describe '#to_s' do
    subject(:piece) { described_class.new('white') }
    context 'after creating a white king' do
      it 'returns the white king symbol' do
        king = Piece.piece_for('white', King)
        expect(king.to_s).to eq('♚')
      end
    end
  end

  describe '#white?' do
    subject(:piece) { described_class.new('white') }
    context 'when the piece is a white king' do
      it 'returns true' do
        w_king = Piece.piece_for('white', King)
        expect(w_king.white?).to eq(true)
      end
    end

    context 'when the piece is a black king' do
      it 'returns false' do
        b_king = Piece.piece_for('black', King)
        expect(b_king.white?).to eq(false)
      end
    end
  end

  describe '#black?' do
    subject(:piece) { described_class.new('black') }
    context 'when the piece is a black king' do
      it 'returns true' do
        b_king = Piece.piece_for('black', King)
        expect(b_king.black?).to eq(true)
      end
    end

    context 'when the piece is a white king' do
      it 'returns true' do
        w_king = Piece.piece_for('white', King)
        expect(w_king.black?).to eq(false)
      end
    end
  end

  describe '#same_team?' do
    subject(:piece) { described_class.new('black') }
    context 'when player ones turn and piece is white' do
      it 'returns true' do
        player1_turn = true
        w_king = Piece.piece_for('white', King)
        expect(w_king.same_team?(player1_turn)).to eq(true)
      end
    end

    context 'when its not player ones turn and piece is white' do
      it 'returns false' do
        player1_turn = false
        w_king = Piece.piece_for('white', King)
        expect(w_king.same_team?(player1_turn)).to eq(false)
      end
    end

    context 'when player ones turn and piece is black' do
      it 'returns true' do
        player1_turn = true
        b_king = Piece.piece_for('black', King)
        expect(b_king.same_team?(player1_turn)).to eq(false)
      end
    end

    context 'when its not player ones turn and piece is black' do
      it 'returns true' do
        player1_turn = false
        b_king = Piece.piece_for('black', King)
        expect(b_king.same_team?(player1_turn)).to eq(true)
      end
    end
  end

end