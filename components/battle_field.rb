# creates battle field
class BattleField
  attr_reader :shoting_field, :placing_field

  def initialize(mannually: false)
    @mannually = mannually
    @check_errors = CheckErrors.new(show_messages: mannually)
    @shotted_places = []
    init_default_variables
    place_ships
    build_fields
    build_field_matrixes
    Communication::Info.field_ready if @mannually
  end

  def available_positions
    return [[rand(0..9), rand(0..9)]] if @placing_field.empty?
    ((0...100).to_a - @placing_field).map { |e| [e.floor(-1) / 10, e % 10] }
  end

  def add_ship(ship)
    @ships << ship
    build_fields
    build_field_matrixes
  end

  def can_be_placed(ship)
    ship_data = ship.view_data
    !@check_errors.outside_field_area(ship_data) &&
      !@check_errors.dont_fit(ship_data) &&
      !@check_errors.dont_free_space(ship_data, @placing_field)
  end

  def get_ship(position_letter, position_number)
    num_position = position_letter * 10 + position_number
    @ships.detect { |ship| ship.view_data.include?(num_position) }
  end

  def destroyed?
    @ships.select { |ship| ship.status == Ship::STATUSES[:dead] }.count == 10
  end

  def update(position_letter, position_number)
    @shotted_places << position_letter * 10 + position_number
    build_field_matrixes
  end

  def show_field_matrix(hidden = false)
    matrix_to_show = hidden ? @hidden_matrix : @opened_matrix
    matrix_to_show.each { |row| puts row }
  end

  def update_ship_status(ship)
    ship.update_status
    ship.status == Ship::STATUSES[:dead]
    @shotted_places += ship.view_data_with_restricted_area
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

  def build_field_matrixes
    @opened_matrix = build_matrix
    @hidden_matrix = build_matrix(hidden: true)
  end

  def build_matrix(hidden: false)
    Array.new(10) do |row|
      Ship::POS_LETTERS.keys[row].to_s + Array.new(10) do |col|
        num_position = row * 10 + col
        if hidden
          if @shotted_places.include?(num_position)
            @shoting_field.include?(num_position) ? ' {} ' : ' ** '
          else
            ' -- '
          end
        else
           @shoting_field.include?(num_position) ? ' [] ' : ' -- '
        end
      end.join
    end
  end
end
