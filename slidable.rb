module Slidable
  ORTHOGONAL = [[0,1], [0,-1], [1,0], [-1,0]]
  DIAGONAL = [[1,1],[-1,-1],[1,-1],[-1,1]]

  def moves
    moves = []
    deltas.each { |delta| moves += free_moves(pos, delta) }
    moves.reject { |pos| pos == self.pos }
  end

  private
  def free_moves(start, delta)
    slide = [start[0] + delta[0], start[1] + delta[1]]

    return [start] unless @board.in_bounds?(slide)
    return [start] if @board[start].color == enemy_color
    return [start] if @board[slide].color == self.color

    [start] + free_moves(slide, delta)
  end
end
