
require_relative '../lib/main'

describe CheckManager do

  describe '#valid_moves_for_king' do
    let(:game) { Game.new }
    subject(:check_manager) { described_class.new(game, game.board, game.move_manager)}
    before do
      game.board.place_piece(King.new('black'), 'b8')
      game.board.place_piece(King.new('white'), 'g7')
    end

    context 'when white turn and friendly king on g7' do
      it 'returns the kings valid moves' do
        valid_moves = ['g8','h8','h7','h6','g6','f6','f7','f8'].sort
        expect(check_manager.valid_moves_for_king('friendly').sort).to eq(valid_moves)
      end
    end

    context 'when black turn and friendly king on b8' do
      it 'returns the kings valid moves' do
        game.instance_variable_set(:@turn, 2)
        valid_moves = ['a8','a7','b7','c7','c8'].sort
        expect(check_manager.valid_moves_for_king('friendly').sort).to eq(valid_moves)
      end
    end

    context 'when white turn and enemy king on b8' do
      it 'returns the kings valid moves' do
        valid_moves = ['a8','a7','b7','c7','c8'].sort
        expect(check_manager.valid_moves_for_king('enemy').sort).to eq(valid_moves)
      end
    end

    context 'when black turn and enemy king on g7' do
      it 'returns the kings valid moves' do
        game.instance_variable_set(:@turn, 2)
        valid_moves = ['g8','h8','h7','h6','g6','f6','f7','f8'].sort
        expect(check_manager.valid_moves_for_king('enemy').sort).to eq(valid_moves)
      end
    end
  end

  describe '#valid_attacks_for_team' do
    let(:game) { Game.new }
    let(:board) { Board.new(game, game.move_manager) }
    subject(:check_manager) { described_class.new(game, board, game.move_manager)}
    before do
      board.place_piece(Pawn.new('black'), 'c7')
      board.place_piece(Pawn.new('black'), 'b7')
      board.place_piece(Bishop.new('black'), 'd7')
      board.place_piece(King.new('black'), 'a7')
      board.place_piece(Pawn.new('white'), 'd2')
      board.place_piece(Pawn.new('white'), 'e3')
      board.place_piece(Bishop.new('white'), 'b2')
      board.place_piece(King.new('white'), 'e1')
    end

    context 'when white turn and there are friendly pieces on d2, b2, and e1' do
      it 'returns valid moves for all pieces' do
        correct_moves = ['d4','f4','a1','a3','c1','c3','e5','f6','g7','h8',
                        'd1','e2','f2','f1'].sort
        method_moves = check_manager.valid_attacks_for_team('friendly')
      expect(correct_moves == method_moves).to be true
      end
    end

    context 'when black turn and there are friendly pieces on c7, b7, d7, and a7' do
      it 'returns valid moves for all pieces' do
        game.instance_variable_set(:@turn, 2)
        correct_moves = ['c6','b6','d6','b5','c8','e8','a4','e6','f5','g4','h3',
                        'a8','b8','a6'].sort
      method_moves = check_manager.valid_attacks_for_team('friendly')
      expect(correct_moves == method_moves).to be true
      end
    end

    context 'when white turn and there are enemy pieces on c7, b7, d7, and a7' do
      it 'returns valid moves for all pieces' do
        correct_moves = ['c6','b6','d6','b5','c8','e8','a4','e6','f5','g4','h3',
                        'a8','b8','a6'].sort
        method_moves = check_manager.valid_attacks_for_team('enemy')
      expect(correct_moves == method_moves).to be true
      end
    end

    context 'when black turn and there are enemy pieces on d2, b2, and e1' do
      it 'returns valid moves for all pieces' do
        game.instance_variable_set(:@turn, 2)
        correct_moves = ['d4','f4','a1','a3','c1','c3','e5','f6','g7','h8',
                        'd1','e2','f2','f1'].sort
        method_moves = check_manager.valid_attacks_for_team('enemy')
      expect(correct_moves == method_moves).to be true
      end
    end
  end

  describe '#active_king_in_harms_way?' do
    let(:game) { Game.new }
    let(:board) { Board.new(game, game.move_manager) }
    subject(:check_manager) { described_class.new(game, board, game.move_manager)}

    context 'when black pawn threatens white king' do
      it 'returns true' do
        board.place_piece(Pawn.new('black'), 'b7')
        board.place_piece(King.new('white'), 'c6')
        expect(check_manager.active_king_in_harms_way?).to be true
      end
    end

    context 'when king is not threatened' do
      it 'returns false' do
        board.place_piece(Pawn.new('black'), 'h3')
        board.place_piece(King.new('white'), 'c6')
        expect(check_manager.active_king_in_harms_way?).to be false
      end
    end
  end

  describe '#moving_into_check?' do
    let(:game) { Game.new }
    let(:board) { Board.new(game, game.move_manager) }
    subject(:check_manager) { described_class.new(game, board, game.move_manager)}

    context 'when black rook threatens cell c6' do
      it 'returns true' do
        board.place_piece(Rook.new('black'), 'b6')
        board.place_piece(King.new('white'), 'c5')
        from_cell = board.board[3][2]
        expect(check_manager.moving_into_check?(from_cell, 'c6')).to be true
      end
    end

    context 'when black pawn threatens cell c6' do
      it 'returns true' do
        board.place_piece(Pawn.new('black'), 'b7')
        board.place_piece(King.new('white'), 'c5')
        from_cell = board.board[3][2]
        expect(check_manager.moving_into_check?(from_cell, 'c6')).to be true
      end
    end


  end

  describe '#active_team_check?' do
    let(:game) { Game.new }
    let(:board) { Board.new(game, game.move_manager) }
    subject(:check_manager) { described_class.new(game, board, game.move_manager)}

    context 'when black pawn threatens white king' do
      it 'returns true' do
        board.place_piece(Pawn.new('black'), 'b7')
        board.place_piece(King.new('white'), 'c6')
        expect(check_manager.active_team_check?).to be true
      end
    end

    context 'when king is not threatened' do
      it 'returns false' do
        board.place_piece(Pawn.new('black'), 'h3')
        board.place_piece(King.new('white'), 'c6')
        expect(check_manager.active_team_check?).to be false
      end
    end

    context 'when king is checkmated' do
      it 'returns false' do
        board.place_piece(Rook.new('black'), 'a3')
        board.place_piece(Rook.new('black'), 'b3')
        board.place_piece(King.new('white'), 'a1')
        expect(check_manager.active_team_check?).to be false
      end
    end
  end

  describe '#active_team_checkmate?' do
    let(:game) { Game.new }
    let(:board) { Board.new(game, game.move_manager) }
    subject(:check_manager) { described_class.new(game, board, game.move_manager)}

    context 'when white king is checkmated' do
      it 'returns true' do
        board.place_piece(Rook.new('black'), 'a3')
        board.place_piece(Rook.new('black'), 'b3')
        board.place_piece(King.new('white'), 'a1')
        expect(check_manager.active_team_checkmate?).to be true
      end
    end

    context 'when king is not threatened' do
      it 'returns false' do
        board.place_piece(Pawn.new('black'), 'h3')
        board.place_piece(King.new('white'), 'c6')
        expect(check_manager.active_team_checkmate?).to be false
      end
    end

    context 'when king is surrounded by friendlies' do
      it 'returns false' do
        board.place_piece(Pawn.new('white'), 'a2')
        board.place_piece(Pawn.new('white'), 'b2')
        board.place_piece(Pawn.new('white'), 'b1')
        board.place_piece(King.new('white'), 'a1')
        expect(check_manager.active_team_check?).to be false
      end
    end
  end
end