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
    damaged_parts = @parts.select { |part| part.status == ShipPart::STATUSES[:dead] }
    return if damaged_parts.empty?
    puts 'damaged_parts'
    print damaged_parts
    puts
    @status = STATUSES[damaged_parts.count == size ? :dead : :damaged]
  end

  def get_part(position_letter, position_number)
    puts 'parts'
    print @parts
    puts
    print position_letter, position_number
    puts
    @parts.detect do |part|
      part.position_letter == position_letter &&
        part.position_number == position_number
    end
  end

  private

  def rand_direction
    [DIRECTIONS[:vertical], DIRECTIONS[:horizontal]].sample
  end

  def init_ship_parts
    multiplier = direction == DIRECTIONS[:vertical] ? 10 : 1
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
    @view_data_with_restricted_area = @view_data.map do |e|
      [
        e,
        *bottom_line_restricted_area(e),
        *top_line_restricted_area(e),
        *left_right_restricted_area(e)
      ]
    end.flatten.uniq.compact
  end

  def top_line_restricted_area(e)
    return [] if e < 10
    [e - 10, (e - 11 if e % 10 != 0), (e - 9 if e % 10 != 9)].compact
  end

  def bottom_line_restricted_area(e)
    return [] if e > 89
    [e + 10, (e + 11 if e % 10 != 9), (e + 9 if e % 10 != 0)].compact
  end

  def left_right_restricted_area(e)
    [(e - 1 if e % 10 != 0), (e + 1 if e % 10 != 9)].compact
  end
end
