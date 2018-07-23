# creates ship
class Ship
  POS_LETTERS = {
    a: 0,
    b: 1,
    c: 2,
    d: 3,
    e: 4,
    f: 5,
    g: 6,
    h: 7,
    i: 8,
    k: 9
  }.freeze
  DIRECTIONS = {
    horizontal: :horizontal,
    vertical: :vertical
  }.freeze
  STATUSES = {
    alive: 'alive',
    damaged: 'damaged',
    dead: 'dead'
  }.freeze

  attr_reader :size, :direction, :position_letter, :position_number,
              :numbers_data, :numbers_data_with_restricted_area

  def initialize(size: 1, direction: DIRECTIONS[:horizontal])
    @size = size
    @direction = direction
    @position_letter = POS_LETTERS[:a]
    @position_number = 0
    @status = STATUSES[:alive]
  end

  def place(position_letter, position_number, direction)
    @position_letter = position_letter
    @position_number = position_number
    @direction = direction || rand_direction
    build_ship_data
  end

  def rotate
    @direction = if @direction == DIRECTIONS[:horizontal]
                   DIRECTIONS[:vertical]
                 else
                   DIRECTIONS[:horizontal]
                 end
  end

  def build_ship_data
    build_ship_nums_data
    build_restricted_area_nums_data
  end

  def build_ship_nums_data
    @numbers_data = [position_letter * 10 + position_number]
    return if size == 1
    (2..size).each do
      @numbers_data.push(
        @numbers_data[-1] + (direction == DIRECTIONS[:vertical] ? 10 : 1)
      )
    end
  end

  def build_restricted_area_nums_data
    @numbers_data_with_restricted_area = @numbers_data.map do |e|
      arr = []
      arr << e + 10 if e < 90
      arr << e + 11 if e < 90 && e % 10 != 9
      arr << e + 9 if e < 90 && e % 10 != 0
      arr << e - 10 if e > 9
      arr << e - 11 if e > 9 && e % 10 != 0
      arr << e - 9 if e > 9 && e % 10 != 9
      arr << e - 1 if e % 10 != 0
      arr << e + 1 if e % 10 != 9
      arr
    end.flatten.uniq
  end

  def rand_direction
    [Ship::DIRECTIONS[:vertical], Ship::DIRECTIONS[:horizontal]].sample
  end
end
