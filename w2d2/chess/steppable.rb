module SteppingPiece

  def find_moves
    valid_moves = []
    find_all_moves.each do |move|
      if board.in_bounds?(move)
        if self.empty_space?(board[move]) || self.enemy?(board[move])
          valid_moves << move
        end
      end
    end
    valid_moves
  end

  def find_all_moves
    all_moves = []

    allowed_deltas.each do |delta|
      all_moves << [position[0] + delta[0], position[1] + delta[1]]
    end

    all_moves
  end
end
