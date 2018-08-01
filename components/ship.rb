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
              :view_data, :view_data_with_restricted_area, :status

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
    build_ship_view_data
    init_ship_parts
    build_ship_with_restricted_area_view_data
  end

  def rotate
    @direction = if direction == DIRECTIONS[:horizontal]
                   DIRECTIONS[:vertical]
                 else
                   DIRECTIONS[:horizontal]
                 end
  end

  def update_status
    damaged_parts_count = @parts.count do |part|
      part.status == ShipPart::STATUSES[:dead]
    end
    return if damaged_parts_count.zero?
    @status = STATUSES[damaged_parts_count == size ? :dead : :damaged]
  end

  def get_part(position_letter, position_number)
    @parts.detect do |part|
      part.position_letter == position_letter &&
        part.position_number == position_number
    end
  end

  def dead?
    status == STATUSES[:dead]
  end

  private

  def rand_direction
    [DIRECTIONS[:vertical], DIRECTIONS[:horizontal]].sample
  end

  def init_ship_parts
    @parts = Array.new(size) do |s|
      if direction == DIRECTIONS[:vertical]
        ShipPart.new(@position_letter + s * 10, @position_number)
      else
        ShipPart.new(@position_letter, @position_number + s)
      end
    end
  end

  def build_ship_view_data
    @view_data = [position_letter * 10 + position_number]
    return if size == 1
    (2..size).each do
      @view_data.push(
        @view_data[-1] + (direction == DIRECTIONS[:vertical] ? 10 : 1)
      )
    end
  end

  def build_ship_with_restricted_area_view_data
    @view_data_with_restricted_area = @view_data.map do |num|
      [
        num,
        *bottom_line_restricted_area(num),
        *top_line_restricted_area(num),
        *left_right_restricted_area(num)
      ]
    end.flatten.uniq.compact
  end

  def top_line_restricted_area(num)
    return [] if num < 10
    [num - 10, (num - 11 if num % 10 != 0), (num - 9 if num % 10 != 9)].compact
  end

  def bottom_line_restricted_area(num)
    return [] if num > 89
    [num + 10, (num + 11 if num % 10 != 9), (num + 9 if num % 10 != 0)].compact
  end

  def left_right_restricted_area(num)
    [(num - 1 if num % 10 != 0), (num + 1 if num % 10 != 9)].compact
  end
end
