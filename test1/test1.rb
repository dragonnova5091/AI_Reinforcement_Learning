#attempt 1 at q-learning
require 'Matrix'
require 'io/console'

Dir.glob("*.rb").each do |f|
  if f != "test1.rb"
    require_relative f
  end
end

class Game
  attr_accessor :testrun
  def initialize
    #@testrun = 0
    @map_size = 11
    @qplayer = Qplayer.new(@map_size)
    run_game
    puts @qplayer.qtable

    while @qplayer.score > -5 && @qplayer.score < 15
      scene = "O=========C="
      scene = draw_scene(scene)
      run_game
      puts scene
      
      @qplayer.qtable.each do |a, b|
        puts "#{a} ~~ #{b}"
      end
      puts @qplayer.score
      puts "-------"

      sleep 0.05
    end

    @qplayer.qtable.each do |a, b|
      puts "#{a} ~~ #{b}"
    end



  end

  def run_game
    #@testrun += 1
    @qplayer.get_input

  end

  def draw_scene(scene)
    sc = scene.split("")
    sc[@qplayer.state] = "P"
    scene = sc.join("")
    return scene
  end
end



game = Game.new
puts game.testrun
