require_relative 'piece'
require_relative 'slidable'
require_relative 'stepable'
require_relative 'pawn'

class Queen < Piece
  include Slidable

  def deltas
    ORTHOGONAL + DIAGONAL
  end
end

class Bishop < Piece
  include Slidable

  def deltas
    DIAGONAL
  end
end

class Rook < Piece
  include Slidable

  def deltas
    ORTHOGONAL
  end
end

class King < Piece
  include Stepable

  def deltas
    [[1,1],[1,0],[1,-1],[0,1],[0,-1], [-1,-1], [-1,0],[-1,1]]
  end
end

class Knight < Piece
  include Stepable

  def deltas
    [[1,2], [1,-2], [2,1], [2,-1], [-2,1], [-2,-1], [-1,2], [-1,-2]]
  end
end
