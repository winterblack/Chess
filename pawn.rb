require_relative 'piece'

class Pawn < Piece

  def moves
    march + flank
  end

  private
  def march_delta
    color == :White ? -1 : 1
  end

  def flank_deltas
    color == :White ? [[-1, -1], [-1, 1]] : [[1, -1], [1, 1]]
  end

  def march
    step_one = step_forward(pos)
    steps = [step_one]
    steps << step_forward(step_one) if start_row && step_one
    steps = in_bound(steps.compact)
  end

  def step_forward(pos)
    step = [pos[0] + march_delta, pos[1]]
    @board[step].is_a?(NullPiece) ? step : nil
  end

  def start_row
    pos[0] == ((color == :White) ? 6 : 1)
  end

  def flank
    flanks = []
    flank_deltas.each do |delta|
      flanks << [pos[0] + delta[0], pos[1] + delta[1]]
    end
    flanks = in_bound(flanks)
    flanks.select{ |move| @board[move].color == enemy_color }
  end

  def in_bound(moves)
    moves.select { |move| @board.in_bounds?(move)}
  end
end
