require_relative "board"

class Game
  attr_reader :board, :current_color

  def initialize
    @board = Board.new
    @current_color = :White
  end

  def move(start, destination)
    piece = board[start]
    raise "That's not your piece." unless piece.color == current_color
    if !piece.valid_move?(destination)
      raise "Invalid move."
    elsif move_into_check?(start, destination)
      raise "Can't put yourself in check."
    else
      board.move!(start, destination)
    end
  end

  def checkmate?
    return false unless in_check?
    current_pieces = board.pieces.select {|piece| piece.color == current_color}
    current_pieces.each do |piece|
      piece.moves.each do |move|
        test_board = board.dup
        test_board.move!(piece.pos, move)
        return false unless test_board.in_check?(current_color)
      end
    end
    true
  end

  def in_check?
    board.in_check?(current_color)
  end

  def switch_players
    @current_color = (current_color == :White ? :Black : :White)
  end

  private
  def move_into_check?(start, destination)
    test_board = board.dup
    test_board.move!(start, destination)
    test_board.in_check?(current_color)
  end
end
