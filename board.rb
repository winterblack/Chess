require_relative "pieces"

class Board
  attr_reader :grid

  def initialize(test_board = false)
    @grid = Array.new(8) { Array.new(8, NullPiece.instance) }
    populate unless test_board
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    grid[row][col] = value
  end

  def move!(start, destination)
    piece = self[start]
    self[destination] = piece
    self[start] = NullPiece.instance
    piece.pos = destination
  end

  def in_bounds?(pos)
    pos.all?{|i| i.between?(0, 7)} ? true : false
  end

  def pieces
    @grid.flatten.reject {|piece| piece.is_a?(NullPiece)}
  end

  def in_check?(current_color)
    pieces.any? { |piece| piece.moves.include?(king(current_color).pos) }
  end

  def dup
    board = Board.new(true)
    pieces.each do |piece|
      piece = piece.dup
      piece.board = board
      board[piece.pos] = piece
    end
    board
  end

private
  def king(color)
    pieces.find {|piece| piece.color == color && piece.is_a?(King)}
  end

  def populate
    populate_back_row(:Black, 0)
    populate_pawns(:Black, 1)
    populate_pawns(:White, 6)
    populate_back_row(:White, 7)
  end

  def back_row
    [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  end

  def populate_back_row(color, row)
    back_row.each_with_index do |piece, col|
      @grid[row][col] = piece.new(color, self, [row, col])
    end
  end

  def populate_pawns(color, row)
    8.times { |col| @grid[row][col] = Pawn.new(color, self, [row, col]) }
  end
end
