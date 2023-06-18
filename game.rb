class Game
  attr_reader :area

  def initialize(height, width)
    @height = height
    @width = width
    @area = Game.area_init(@height, @width)
  end

  def self.area_init(height, width)
    area = []
    height.times do
      row = ""
      width.times do
        cell = self.generate_cell
        row += cell
      end
      area.push(row)
    end
    area
  end

  def self.generate_cell
    random_num = rand(2)
    if random_num == 0
      "■"
    else
      " "
    end
  end

  def next_turn
    area_copy = Marshal.load(Marshal.dump(@area))
    @area = @area.map.with_index do |row, i|
      new_row = ""

      row.chars.each_with_index do |cell, j|
        count = count_square(area_copy, i, j)

        if cell == " "
          case count
          when 3 then
            result = "■"
          else
            result = " "
          end
        else
          case count
          when 2 then
            result = "■"
          when 3 then
            result = "■"
          else
            result = " "
          end
        end

        new_row += result
      end

      new_row
    end

    self.display
  end

  def count_square(area, i, j)
    count = 0

    if i > 0
      if j > 0
        if area[i-1][j-1] == "■"
          count += 1
        end
      end
  
      if area[i-1][j] == "■"
        count += 1
      end
  
      if j < @width-1
        if area[i-1][j+1] == "■"
          count += 1
        end
      end
    end

    if j > 0
      if area[i][j-1] == "■"
        count += 1
      end
    end

    if j < @width-1
      if area[i][j+1] == "■"
        count += 1
      end
    end

    if i < @height - 1
      if j > 0
        if area[i+1][j-1] == "■"
          count += 1
        end
      end
    
      if area[i+1][j] == "■"
        count += 1
      end
      
      if j < @width-1
        if area[i+1][j+1] == "■"
          count += 1
        end
      end
    end
    
    count
  end

  def display
    print "\033[2J\033[0;0H"
    puts @area
    sleep 0.5
  end
end
