# frozen_string_literal: true

# creates battle field
class BattleField
  attr_reader :shoting_field, :placing_field,
              :shotted_places, :damaged_parts_view_data

  def initialize(mannually: false)
    @mannually = mannually
    @check_errors = CheckErrors.new(show_messages: mannually)
    @shotted_places = []
    @damaged_parts_view_data = []
    init_default_variables
    place_ships
    build_fields
    Communication::Info.field_ready if @mannually
  end

  def available_positions
    return [[rand(0..9), rand(0..9)]] if @placing_field.empty?
    ((0...100).to_a - @placing_field).map { |e| [e.floor(-1) / 10, e % 10] }
  end

  def add_ship(ship)
    @ships << ship
    build_fields
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
    build_fields
  end

  def get_field_row_data(hidden = false)
    build_fields
    hidden ? @hidden_field_view_rows_data : @opened_field_view_rows_data
  end

  def update_ship_status(ship)
    ship.update_status
    return unless ship.dead?
    @shotted_places += ship.view_data_with_restricted_area
    @damaged_parts_view_data.delete_if { |el| ship.view_data.include?(el) }
  end

  def damage_ship(ship, position_letter, position_number)
    ship.get_part(position_letter, position_number).kill
    @damaged_parts_view_data << position_letter * 10 + position_number
    update_ship_status(ship)
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
    @opened_field_view_rows_data = build_field_view_rows_data
    @hidden_field_view_rows_data = build_field_view_rows_data(hidden: true)
  end

  def build_field_view_rows_data(hidden: false)
    Array.new(10) do |row|
      Ship::POS_LETTERS.keys[row].to_s + Array.new(10) do |col|
        symbol_for_position(row * 10 + col, hidden)
      end.join
    end
  end

  def symbol_for_position(num_position, hidden)
    if @shotted_places.include?(num_position)
      @shoting_field.include?(num_position) ? ' {} ' : ' ** '
    elsif hidden
      ' -- '
    else
      @shoting_field.include?(num_position) ? ' [] ' : ' -- '
    end
  end
end
