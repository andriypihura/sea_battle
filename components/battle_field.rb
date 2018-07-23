# creates battle field
class BattleField
  attr_reader :shoting_field, :placing_field

  def initialize(mannually: false)
    @mannually = mannually
    @check_errors = CheckErrors.new(show_messages: mannually)
    init_default_variables
    place_ships
    build_fields
    Communication::Info.field_ready
  end

  def available_positions
    return [[rand(0..9), rand(0..9)]] if @placing_field.empty?
    ((0...100).to_a - @placing_field).map { |e| [e.floor(-1) / 10, e % 10] }
  end

  def add_ship(ship)
    @ships << ship
    build_fields
    show_field if @mannually
  end

  def can_be_placed(ship)
    ship_data = ship.view_data
    !@check_errors.outside_field_area(ship_data) &&
      !@check_errors.dont_fit(ship_data) &&
      !@check_errors.dont_free_space(ship_data, @placing_field)
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
    @shoting_field = @ships.map(&:view_data).flatten
    @placing_field = @ships.map(&:view_data_with_restricted_area).flatten
  end
end
