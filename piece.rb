class Piece
  attr_reader :color
  attr_accessor :pos, :board

  DISPLAY = {
    [:White, :King]   => " \u2654 ",
    [:White, :Queen]  => " \u2655 ",
    [:White, :Rook]   => " \u2656 ",
    [:White, :Bishop] => " \u2657 ",
    [:White, :Knight] => " \u2658 ",
    [:White, :Pawn]   => " \u2659 ",
    [:Black, :King]   => " \u265A ",
    [:Black, :Queen]  => " \u265B ",
    [:Black, :Rook]   => " \u265C ",
    [:Black, :Bishop] => " \u265D ",
    [:Black, :Knight] => " \u265E ",
    [:Black, :Pawn]   => " \u265F "
  }

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def to_s
    DISPLAY[[self.color, self.class.to_s.to_sym]]
  end

  def inspect
    "#{color} #{self.class}"
  end

  def valid_move?(destination)
    self.moves.include?(destination)
  end

  private
  def enemy_color
    color == :White ? :Black : :White
  end
end

require 'singleton'

class NullPiece
  include Singleton

  def color
    :none
  end

  def to_s
    "   "
  end

  def inspect
    "NullPiece"
  end
end
