# creates battle field
class BattleField
  def initialize(mannually: false)
    @mannually = mannually
    @error_handler = ErrorHandler.new(show_messages: mannually)
    init_default_variables
    place_ships
    build_fields
    Communication::Info.field_ready
  end

  def show_field
    print '-'
    10.times { |e| print "  #{e} " }
    puts
    10.times do |row|
      str = Ship::POS_LETTERS.keys[row].to_s
      10.times do |col|
        str += @shoting_field.include?(row * 10 + col) ? ' [] ' : ' -- '
      end
      puts str
    end
  end

  def available_positions
    return [[rand(0..9), rand(0..9)]] if @placing_field.empty?
    ((0...100).to_a - @placing_field).map { |e| [e % 10, e.floor(-1) / 10] }
  end

  def add_ship(ship)
    @ships << ship
    build_fields
    show_field if @mannually
  end

  def can_be_placed(ship)
    ship_data = ship.numbers_data
    return false if @error_handler.outside_field_area(ship_data)
    return false if @error_handler.dont_fit(ship_data)
    return false if @error_handler.dont_free_space(ship_data, @placing_field)
    true
  end

  private

  def init_default_variables
    @shoting_field = []
    @placing_field = []
    @ships = []
  end

  def place_ships
    3.downto(0) do |x|
      (4 - x).times do
        PlaceShip.new(self, Ship.new(size: x + 1), @mannually).call
      end
    end
  end

  def build_fields
    @shoting_field = @ships.map(&:numbers_data).flatten
    @placing_field = @ships.map(&:numbers_data_with_restricted_area).flatten
  end
end
