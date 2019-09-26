require 'gosu'

class Game < Gosu::Window

  @@black = Gosu::Color.argb(0xff_000000);
  @@white = Gosu::Color.argb(0xff_ffffff);
  @@s_size = 10;
  
  def initialize
    w = 640
    h = 480
    super w, h
    self.caption = "Conway's Game of Life"
    @width = w/@@s_size
    @height = h/@@s_size
    @length = @width*@height
    @board = Array.new(@length, false)
    initBoardF
  end

  def initBoardF
    center = @length/2+@height/2-1
    @board[center] = true
    @board[center+1] = true
    @board[center-1] = true
    @board[center-@height] = true
    @board[center+@height-1] = true
  end

  def update
    updateBoard()
  end

  def updateBoard
    nextBoard = Array.new(@length, false)
    for i in 0..@length
      nextBoard[i] = nextState((i/@height),(i%@height));
    end
    @board = nextBoard
  end
  
  def draw
    for i in 0..@width do
      for j in 0..@height do
        col = @@black;
        if isAlive(i,j)
          col = @@white;
        end
        draw_rect(i*@@s_size,j*@@s_size,@@s_size,@@s_size, col);
      end
    end
  end

  def nextState(i,j)
    neighbors = numAliveNeighbors(i,j)
    if isAlive(i,j)
      return ((neighbors > 1) and (neighbors < 4))
    else
      return (neighbors == 3)
    end
  end

  def numAliveNeighbors(i,j)
    count = 0;
    for a in -1..1
      for b in -1..1
        if not ((a == 0) and (b==0))
          if isAlive(i+a,j+b)
            count+=1;
          end
        end
      end
    end
    return count
  end
  
  #temp
  def isAlive(i, j)
    if (i < 0) or (j < 0) or (i >= @width) or (j >= @height)
      return false
    end
    return @board[i*@height+j]
  end
end

Game.new.show
