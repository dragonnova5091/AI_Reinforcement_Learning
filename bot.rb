#bot

DISCOUNT = 0.9
LEARNRATE = 0.2
RANDMOVE = 0.1

 
class Qplayer
  attr_accessor :qtable, :score, :state, :mapsize
  def initialize(map_size)
    @actions = [0, 1] #left = 0 right = 1
    @r = Random.new
    @map_size = map_size
    @firstrun = true
    @state = 3
    @score = 0


  end

  def init_qtable
    @qtable = Array.new(@map_size) { Array.new(@actions.length) }

    @map_size.times do |s|
      @actions.length.times do |a|
        @qtable[s][a] = 0#rand
      end
    end

  end

  def get_input

    #puts @firstrun
    if @firstrun
      @firstrun = false
      init_qtable
      #puts @firstrun

    else

      a = maximize(@state)
      if a == 0
        if @state == 1
          bellman(-1, a, @state, @state-1)
        elsif @state > 1 && @state < 9
          bellman(0, a, @state, @state-1)
        elsif @state == 0
          @score -=1
          @state=3
        elsif @state == 10
          @score += 1
          @state=3
        end

        @state-=1
      elsif a == 1
        if @state > 1 && @state < 9
          bellman(0, a, @state, @state+1)
        elsif @state == 9
          bellman(1, a, @state, @state+1)
        elsif @state == 0
          @score -=1
          @state=3
        elsif @state == 10
          @score += 1
          @state=3
        end
        @state +=1
      end

    end
  end

  def bellman(reward, action, state, statep)
    @qtable[state][action] = @qtable[state][action] + LEARNRATE*( reward + DISCOUNT*(@qtable[statep][maximize(statep)]) - @qtable[state][action])

  end

  def maximize(state)
    if rand >= RANDMOVE
      if @qtable[state][0] > @qtable[state][1]
        a = 0
      elsif @qtable[state][0] < @qtable[state][1]
        a = 1
      else
        a = rand(0..1)
      end
    else
      a = rand(0..1)
    end


    #puts "~~#{a}~~"
    return a
  end


end
