
require_relative '../lib/main'

describe UI do

  describe '#get_player_first_input' do
    let(:game) { Game.new }
    subject(:ui) { described_class.new(game, game.board, game.move_manager, game.check_manager) }
    context 'when player selects a valid input' do
      it 'returns that input' do
        d2_cell = game.board.board[6][3]
        set_piece('white', Pawn, 'd2')
        allow(ui).to receive(:gets).and_return('d2')
        expect(ui.get_player_first_input).to eq(d2_cell)
      end
    end

    context 'when player selects an out of bounds input' do
      it 'restarts loop until a valid input is given' do
        d2_cell = game.board.board[6][3]
        set_piece('white', Pawn, 'd2')
        allow(ui).to receive(:gets).and_return('v20', 'd2')
        expect(ui).to receive(:gets).twice
        ui.get_player_first_input
      end
    end

    context 'when player selects a cell with an enemy on it' do
      it 'restarts loop until a valid input is given' do
        d2_cell = game.board.board[6][3]
        set_piece('black', Pawn, 'a7')
        set_piece('white', Pawn, 'd2')
        allow(ui).to receive(:gets).and_return('a7', 'd2')
        expect(ui).to receive(:gets).twice
        ui.get_player_first_input
      end
    end

    context 'when player selects an empty cell' do
      it 'restarts loop until a valid input is given' do
        d2_cell = game.board.board[6][3]
        set_piece('white', Pawn, 'd2')
        allow(ui).to receive(:gets).and_return('d3', 'd2')
        expect(ui).to receive(:gets).twice
        ui.get_player_first_input
      end
    end

    context 'when player selects a piece that has no available moves' do
      it 'restarts loop until a valid input is given' do
        d2_cell = game.board.board[6][3]
        set_piece('white', Pawn, 'd2')
        set_piece('white', Pawn, 'd3')
        set_piece('white', Pawn, 'e2')        
        allow(ui).to receive(:gets).and_return('d2', 'e2')
        expect(ui).to receive(:gets).twice
        ui.get_player_first_input
      end
    end
  end

  describe '#get_player_second_input' do
    let(:game) { Game.new }
    subject(:ui) { described_class.new(game, game.board, game.move_manager, game.check_manager) }
    let(:d2) { game.board.board[6][3] }
    before do
      set_piece('white', Rook, 'd2')
    end
    context 'when Rook is on d2 and second input is valid' do
      it 'returns the cell object of second input' do
        # allow(ui).to receive(:get_player_first_input).and_return(d2)
        allow(ui).to receive(:gets).and_return('d3')
        d3 = game.board.board[5][3]
        expect(ui.get_player_second_input(d2)).to eq(d3)
      end
    end

    context 'when Rook is on d2 and second input is not valid' do
      it 'runs the loop until a valid input is given' do
        # allow(ui).to receive(:get_player_first_input).and_return(d2)
        allow(ui).to receive(:gets).and_return('a4', 'h2')
        expect(ui).to receive(:gets).twice
        ui.get_player_second_input(d2)
      end
    end
  end

  describe '#move_piece' do
    let(:game) { Game.new }
    subject(:ui) { described_class.new(game, game.board, game.move_manager, game.check_manager) }
    let(:d2) { game.board.board[6][3] }
    let(:d8) { game.board.board[0][3]}
    before do
      set_piece('white', Rook, 'd2')
    end

    context 'when Rook moves from d2 to empty d8' do
      it 'updates content of the to cell' do
        allow(game.check_manager).to receive(:active_team_check?).and_return(false)
        allow(ui).to receive(:gets).and_return('d2','d8')
        ui.move_piece
        expect(d8.content).to eq(' ♜ ')
      end

      it 'updates piece of the to cell' do
        allow(game.check_manager).to receive(:active_team_check?).and_return(false)
        allow(ui).to receive(:gets).and_return('d2','d8')
        ui.move_piece
        expect(d8.piece).to be_a(Rook)
      end

      it 'clears the content of the from cell' do
        allow(game.check_manager).to receive(:active_team_check?).and_return(false)
        allow(ui).to receive(:gets).and_return('d2','d8')
        ui.move_piece
        expect(d2.content).to eq('   ')
      end

      it 'clears the piece of the from cell' do
        allow(game.check_manager).to receive(:active_team_check?).and_return(false)
        allow(ui).to receive(:gets).and_return('d2','d8')
        ui.move_piece
        expect(d2.piece).to be_a(EmptySpace)
      end
    end

    context 'when Rook moves from d2 to enemy occupied d8' do
      it 'sends enemy piece to the graveyard' do
        set_piece('black', Pawn, 'd8')
        allow(game.check_manager).to receive(:active_team_check?).and_return(false)
        allow(ui).to receive(:gets).and_return('d2','d8')
        ui.move_piece
        expect(game.graveyard.black_graveyard).to eq(['♙'])
      end
    end
  end
end

#Helper Methods

def set_piece(color, piece_type, coordinate)
  piece = Piece.piece_for(color, piece_type)
  game.board.place_piece(piece, coordinate)
end