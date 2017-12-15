#the bot runs the game

DISCOUNT = 0.9
LEARNRATE = 0.4
RANDMOVE = 0.01

class Qplayer
  attr_accessor :score, :x, :y, :qtable
  def initialize(map, impo_state)
    @actions = [0,1,2,3] #0 is N 1 is E 2 is S 4 i s W
    @firstrun = true
    @map = map

    @impo_state = impo_state

    @x = 0
    @y = 0
    @score = 0
  end

  def get_input
    if @firstrun
      init_qtable
      @firstrun = false
    else
      act = maximize(@y, @x)
      case act
      when 0
        if @y < @map.length-1
          yp = @y+1
        else
          yp = 3
        end
        xp = @x
      when 1
        if @x < @map[0].length-1
          xp = @x+1
        else
          xp = 3
        end
        yp = @y
      when 2
        if @y >0
          yp = @y-1
        else
          yp = 0
        end
        xp = @x
      when 3
        if @x >0
          xp = @x-1
        else
          xp = 0
        end
        yp = @y
      end

      ran = false
      @impo_state.each do |impo|
        if yp == impo[0] && xp == impo[1]
          bellman(impo[2], act, @y, @x, yp, xp)

          if impo[2] >0
            @score += 1
            @x = 0
            xp = 0
            @y = 0
            yp = 0
          else
            @score -= 1
            @x = 0
            xp = 0
            @y = 0
            yp = 0
          end
          ran = true
        end
      end

      if ran == false
        bellman(0, act, @y, @x, yp, xp)
      end

      @x = xp
      @y = yp

    end

  end

  def bellman(reward, action, y, x, yp, xp)
    @qtable[y][x][action] = @qtable[y][x][action] + LEARNRATE*( reward + DISCOUNT*(@qtable[yp][xp][maximize(yp, xp)]) - @qtable[y][x][action])

  end

  def maximize(y, x)
    if rand >= RANDMOVE
      actions = @qtable[y][x]
      acmax = actions.max

      #for some actions that are teh same
      ind = []
      num = 0
      actions.each do |a1|
        if a1 == acmax
          ind << num
        end
        num += 1
      end

      return ind[rand(0..ind.length-1)]

    else
      return rand(0..3)
    end
  end

  def init_qtable
    @qtable = Array.new(@map.length) { Array.new(@map[0].length) {Array.new(@actions.length)}}

    @map.length.times do |l|
      @map[l-1].length.times do |s|
        @actions.length.times do |a|
          @qtable[l][s][a] = 0
        end
      end
    end
  end
end
