require_relative "game"
require_relative "display"

class Session

  def initialize
    @game = Game.new
    @display = Display.new(@game.board)
  end

  def play
    until @game.checkmate?
      begin
        @display.check if @game.in_check?
        make_move
        @game.switch_players
        @display.clear
      rescue StandardError => error
        @display.notifications[:error] = error.message
        retry
      end
    end
    @display.render
    puts "#{@game.current_color} is in checkmate."
  end

  def make_move
    start, destination = nil, nil
    until start && destination
      @display.render
      start ? destination = @display.get_input : start = @display.get_input
    end
    @game.move(start, destination)
  end
end

Session.new.play
