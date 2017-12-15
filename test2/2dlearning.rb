#2d learnign

require_relative "bot.rb"

class Game
  def initialize
    @map = [
      ["S", "O", "H", "O"],
      ["O", "O", "O", "O"],
      ["O", "H", "O", "O"],
      ["O", "O", "O", "G"]
    ] #O = empty, H = hole, G = Goal, S = start
    @qplayer = Qplayer.new

    run_game
  end

  def run_game

    while @qplayer.score >-10 && @qplayer.score < 8
      @map = [
        ["S", "O", "H", "O"],
        ["O", "O", "O", "O"],
        ["O", "H", "O", "O"],
        ["O", "O", "O", "G"]
      ]
      @qplayer.get_input
      draw_scene(@map)
      puts "#{@qplayer.score} "
      sleep 0.15
    end

    

  end

  def draw_scene(map)
    map[@qplayer.y][@qplayer.x] = "P"
    map.each do |y_line|
      y_line.each do |x|
        print "#{x} "
      end
      print "\n"
    end
  end
end


game=Game.new
