
require 'pry'
require 'game'
require 'board'

describe Game do

  # describe '#move_piece' do
  #   subject(:game) { described_class.new(Board.new) }
  #   let(:pawn) { "\u265F".encode('utf-8') }
  #   before do
  #     set_piece('w', 'pawn', 'd2')
  #   end

  #   context 'when input is d2, d3' do
  #     it 'moves pawn one space forward' do
  #       game.move_piece('d2', 'd3')
  #       space = game.space_at('d3')
  #       expect(space.content).to eq(" #{pawn} ")
  #     end
  #   end

  #   context 'when input is d2, d3' do
  #     it 'clears the from space' do
  #       game.move_piece('d2', 'd3')
  #       space = game.space_at('d2')
  #       expect(space.content).to eq("   ")
  #     end
  #   end

  #   context 'when pawn tries to move ontop of friendly piece' do
  #     it 'calls the function again' do
  #       set_piece('w', 'pawn', 'd3')
  #       allow(game).to receive(:gets).and_return('d2', 'd5')
  #       expect(game).to receive(:move_piece).and_call_original.twice
  #       game.move_piece('d2', 'd3')
  #     end
  #   end

  #   context 'when input is white piece moves ontop of black piece' do
  #     it 'white pawn takes black pawn' do
  #       set_piece('b', 'pawn', 'd3')
  #       game.move_piece('d2', 'd3')
  #       space = game.space_at('d3')
  #       expect(space.content).to eq(" #{pawn} ")
  #     end
  #   end

  #   context 'when input is white piece moves ontop of black piece' do
  #     it 'sends black piece to graveyard' do
  #       set_piece('b', 'pawn', 'd3')
  #       game.move_piece('d2', 'd3')
  #       p2_graveyard = game.board.instance_variable_get(:@p2_graveyard)
  #       b_pawn = "\u2659".encode('utf-8')
  #       expect(p2_graveyard[0]).to eq("#{b_pawn}")
  #     end
  #   end
  # end

  # describe '#space_at' do
  #   subject(:game) { described_class.new(Board.new) }
  #   context 'when selection is valid' do
  #     it 'returns selected coordinate object' do
  #       coord_obj = game.board.board[6][3]
  #       expect(game.space_at('d2')).to eq(coord_obj)
  #     end
  #   end

  #   context 'when selection is not valid' do
  #     it 'calls function again' do
  #       allow(game).to receive(:gets).and_return('z3', 'd2')
  #       expect(game).to receive(:space_at).and_call_original.twice
  #       game.space_at
  #     end
  #   end
  # end

  # describe '#valid_board_space?' do
  #   subject(:game) { described_class.new(Board.new) }
  #   context 'when given valid input c5' do
  #     it 'returns true' do
  #       expect(game.valid_board_space?('c5')).to be true
  #     end
  #   end

  #   context 'when given invalid input cc' do
  #     it 'returns false' do
  #       expect(game.valid_board_space?('cc')).to be false
  #     end
  #   end

  #   context 'when given invalid input 24' do
  #     it 'returns false' do
  #       expect(game.valid_board_space?('24')).to be false
  #     end
  #   end
  # end

  describe '#get_start_position' do
    subject(:game) { described_class.new(Board.new) }
    let(:board) { Board.new }
    let(:white_space) { board.space_at('a3') }
    let(:black_space) { board.board[5][1] }
    let(:empty_space) { board.board[5][2] }
    before do
      board.place_piece(BPawn.new, 'b3')
    end
    
    context 'when the selected space has a white pawn' do
      it 'returns the piece on space a3' do
        # binding.pry
        board.place_piece(WPawn.new, 'a3')
        allow(game).to receive(:gets).and_return('a3')
        expect(game.get_start_position).to eq('a3')
      end
    end

    # context 'when the selected space has a black pawn' do
    #   xit 'returns false' do
    #   expect(game.get_start_position).to be false
    #   end
    # end

    # context 'when the selected space is empty' do
    #   xit 'returns false' do
    #   expect(game.valid_from_selection?('a3')).to be false
    #   end
    # end

    # context 'when the selected space is not on the board' do
    #   xit 'returns false' do
    #   expect(game.valid_from_selection?('w20')).to be false
    #   end
    # end
  end

  # describe '#valid_to_selection' do
  #   before do
  #     set_piece('w','pawn','a1')
  #     set_piece('b','pawn','a2')
  #   end
  
  #   subject(:game) { described_class.new(Board.new) }
  #   context 'when the selected space has a white pawn' do
  #     it 'returns false' do
  #     expect(game.valid_to_selection?('a1')).to be false
  #     end
  #   end

  #   context 'when the selected space has a black pawn' do
  #     it 'returns true' do
  #     expect(game.valid_to_selection?('a2')).to be true
  #     end
  #   end

  #   context 'when the selected space is empty' do
  #     it 'returns true' do
  #     expect(game.valid_to_selection?('a3')).to be true
  #     end
  #   end

  #   context 'when the selected space is not on the board' do
  #     it 'returns false' do
  #     expect(game.valid_to_selection?('aa')).to be false
  #     end
  #   end
  # end

  # describe '#same_team?' do
  #   subject(:game) { described_class.new(Board.new) }
  #   context 'when it is player 1s turn and the piece is white' do
  #     it 'returns true' do
  #       a1 = game.space_at('a1')
  #       a1.set_piece('w', 'pawn')
        
  #       expect(game.same_team?('a1')).to be true
  #     end
  #   end

  #   context 'when it is player 1s turn and the piece is black' do
  #     it 'returns false' do
  #       a1 = game.space_at('a1')
  #       a1.set_piece('b', 'pawn')
  #       expect(game.same_team?('a1')).to be false
  #     end
  #   end

  #   context 'when it is player 2s turn and the piece is black' do
  #     it 'returns true' do
  #       a1 = game.space_at('a1')
  #       a1.set_piece('b', 'pawn')
  #       game.instance_variable_set(:@turn, 2)
  #       expect(game.same_team?('a1')).to be true
  #     end
  #   end
    
  #   context 'when it is player 2s turn and the piece is white' do
  #     it 'returns false' do
  #       a1 = game.space_at('a1')
  #       a1.set_piece('w', 'pawn')
  #       game.instance_variable_set(:@turn, 2)
  #       expect(game.same_team?('a1')).to be false
  #     end
  #   end
  # end

  # describe '#send_piece_to_graveyard' do
  #   subject(:game) { described_class.new(Board.new) }
  #   context 'when the coordinate of a white piece is passed in' do
  #     it 'sends that piece to player 1s graveyard' do
  #       set_piece('w', 'pawn', 'c4')
  #       game.send_piece_to_graveyard('c4')
  #       p1_graveyard = game.board.instance_variable_get(:@p1_graveyard)
  #       w_pawn = "\u265F".encode('utf-8')
  #       expect(p1_graveyard[0]).to eq(w_pawn)
  #     end
  #   end

  #   context 'when the coordinate of a black piece is passed in' do
  #     it 'sends that piece to player 2s graveyard' do
  #       set_piece('b', 'pawn', 'c4')
  #       game.send_piece_to_graveyard('c4')
  #       p2_graveyard = game.board.instance_variable_get(:@p2_graveyard)
  #       b_pawn = "\u2659".encode('utf-8')
  #       expect(p2_graveyard[0]).to eq(b_pawn)
  #     end
  #   end
  # end

  describe '#player1_turn?' do
    subject(:game) { described_class.new(Board.new) }
    context 'when @turn is 1' do
      it 'returns true' do
        expect(game.player1_turn?).to be true
      end
    end

    context 'when @turn is 2' do
      it 'returns false' do
        game.instance_variable_set(:@turn, 100)
        expect(game.player1_turn?).to be false
      end
    end
  end

end


#Helper Methods

def set_piece(color_letter, piece_name, coordinate)
  row = selection_to_array_row(coordinate)
  column = selection_to_array_column(coordinate)
  piece = create_piece(color_letter, piece_name)

  game.board.board[row][column].content = " #{piece} "
end

# def set_piece(color_letter, piece_name)
#   piece = create_piece(color_letter, piece_name)
#   @content = " #{piece} "
# end