#2d learnign

require_relative "bot.rb"

class Game
  def initialize
    @map = make_map
    @impo_state = impo_state_determine(@map)

  '  @map = [
      ["S", "O", "O", "O", "O", "O"],
      ["O", "O", "O", "H", "O", "O"],
      ["O", "O", "O", "H", "O", "O"],
      ["H", "H", "O", "O", "O", "O"],
      ["O", "O", "O", "H", "H", "O"],
      ["G", "H", "O", "O", "O", "G"]
    ] #O = empty, H = hole, G = Goal, S = start'



    @qplayer = Qplayer.new(@map, @impo_state)

    run_game
  end

  def run_game

    while @qplayer.score < 8
      map = @map.clone

      @qplayer.get_input
      draw_scene(map)
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
      map[0].length.times do |x|
        map[y-1][x-1] = "O"
      end
    end

    if sizex > sizey
      (sizey+3).times do
        map[rand(0..map.length-1)][rand(0..map[0].length-1)] = "H"
      end
    else
      (sizex+3).times do
        map[rand(0..map.length-1)][rand(0..map[0].length-1)] = "H"
      end
    end

    map[map.length-1][map[0].length-1] = "G"

    return map
  end

  def impo_state_determine(map)
    impo_states = []

    map.length.times do |y|
      map[0].length.times do |x|
        if map[y-1][x-1] == "H"
          impo_states << [y-1, x-1, -1]
        elsif map[y-1][x-1] == "G"
          impo_states << [y-1, x-1, 1]
        end
      end
    end
    return impo_states

  end
end


game=Game.new
