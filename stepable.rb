module Stepable

  def moves
    moves = []
    deltas.each { |delta| moves << [pos[0] + delta[0], pos[1] + delta[1]] }
    free(moves)
  end

  private
  def free(moves)
    free_moves = moves.select { |move| @board.in_bounds?(move) }
    free_moves.reject { |move| @board[move].color == self.color }
  end
end
