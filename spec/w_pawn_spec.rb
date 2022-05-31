
require 'w_pawn'

describe WPawn do

  describe '#same_team?' do
    subject(:w_pawn) { described_class.new }
    context 'when player1_turn is true' do
      it 'returns true' do
        expect(w_pawn.same_team?(true)).to eq(true)
      end
    end

    context 'when player1_turn is false' do
      it 'returns false' do
        expect(w_pawn.same_team?(false)).to eq(false)
      end
    end
  end
end
