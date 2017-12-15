#2d learnign

require_relative "bot.rb"

class Game
  def initialize
@map = make_map
@map_ = @map.clone

    @map = [
      ["S", "O", "O", "O", "O", "O"],
      ["O", "O", "O", "H", "O", "O"],
      ["O", "O", "O", "H", "O", "O"],
      ["H", "H", "O", "O", "O", "O"],
      ["O", "O", "O", "H", "H", "O"],
      ["G", "H", "O", "O", "O", "G"]
    ] #O = empty, H = hole, G = Goal, S = start

    @impo_state = [[5, 0, 1], [5,5,1], [3,0,-1], [3,1,-1], [4,3,-1],[4,4,-1], [1,3,-1],[2,3,-1], [5,1,-1]] # [y value, x value, reward], []

    @qplayer = Qplayer.new(@map, @impo_state)

    run_game
  end

  def run_game

    while @qplayer.score < 8
      @map = @map_
      @map = [
        ["S", "O", "O", "O", "O", "O"],
        ["O", "O", "O", "H", "O", "O"],
        ["O", "O", "O", "H", "O", "O"],
        ["H", "H", "O", "O", "O", "O"],
        ["O", "O", "O", "H", "H", "O"],
        ["G", "H", "O", "O", "O", "G"]
      ]
      @qplayer.get_input
      draw_scene(@map)
      puts "#{@qplayer.score} "
      sleep 0.1
    end



  end

  def draw_scene(map)
    map[@qplayer.y][@qplayer.x] = "X"
    map.each do |y_line|
      y_line.each do |x|
        print "#{x} "
      end
      print "\n"
    end
  end

  def make_map
    sizex = rand(5..15)
    sizey = rand(5..15)

    map = Array.new(sizey) {Array.new(sizex)}
    map.length.times do |y|
      yline.length.times do |x|
        map[y-1][x-1] = "O"
      end
    end

    map[map.length-1][map[0].length-1] = "G"

    if sizex > sizey
      (sizey-1).times do

    else

    end




  end
end


game=Game.new
