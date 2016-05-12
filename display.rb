require "colorize"
require_relative "cursorable"
require_relative "board"

class Display
  attr_accessor :notifications
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [6, 4]
    @notifications = {}
  end

  def render
    system("clear")
    puts "Arrow keys to move, enter to confirm."
    build_grid.each { |row| puts row.join }
    @notifications.each do |key, val|
      puts "#{val}"
    end
  end

  def check
    @notifications[:check] = "Check!"
  end

  def clear
    @notifications = {}
  end

  private
  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :blue
    end
    { background: bg, color: :black }
  end
end
