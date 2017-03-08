
module SlidingPiece

  def who_goes_there(other_piece)
    return :empty if self.empty_space?(board[other_piece])
    return :enemy if self.enemy?(board[other_piece])
    return :friend if self.friend?(board[other_piece])
  end

  def find_moves
    valid_moves = Hash.new { |h, k| h[k] = [position] }

    allowed_directions.each do |dir|
      delta = Piece::DIRECTIONS[dir]

      flag = false
      until flag
        last_move = valid_moves[dir].last
        new_move = [last_move[0] + delta[0], last_move[1] + delta[1]]
        if board.in_bounds?(new_move)
          case who_goes_there(new_move)
          when :empty
            valid_moves[dir] << new_move
          when :enemy
            valid_moves[dir] << new_move
            flag = true
          when :friend
            flag = true
          end
        else
          flag = true
        end #end of board.in_bounds?
      end # end of until loop
    end # end of each loop

    parse_moves(valid_moves)
  end #end of method

  def parse_moves(valid_moves_hash)
    moves = []
    valid_moves_hash.values.each do |array|
      moves += array
    end

    moves.delete(position)
    moves
  end #end of method


end ## end SlidingPiece module
