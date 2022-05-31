
require 'b_pawn'

describe BPawn do

  describe '#same_team?' do
    subject(:b_pawn) { described_class.new }
    context 'when player1_turn is true' do
      it 'returns false' do
        expect(b_pawn.same_team?(true)).to eq(false)
      end
    end

    context 'when player1_turn is false' do
      it 'returns true' do
        expect(b_pawn.same_team?(false)).to eq(true)
      end
    end
  end
end
