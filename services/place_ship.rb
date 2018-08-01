# frozen_string_literal: true

# place ship
class PlaceShip
  def initialize(battle_field, ship, mannually)
    @battle_field = battle_field
    @ship = ship
    @mannually = mannually
  end

  def call
    @mannually ? place_mannually : place_to_rand_position
  end

  private

  def place_mannually
    loop do
      set_mannual_position
      break if ship_can_be_placed
      Communication::Info.cant_place
    end
    add_ship_to_battlefield
    ShowFields.new(@battle_field).call
  end

  def place_to_rand_position
    loop { break if set_rand_position }
    add_ship_to_battlefield
  end

  def set_mannual_position
    Communication::Info.ship_size_details(@ship.size)
    position = Communication::Question.position
    place_ship(
      position[:pos_letter],
      position[:pos_number],
      Communication::Question.direction
    )
  end

  def set_rand_position
    @battle_field.available_positions.shuffle.each do |pos|
      place_ship(pos[0], pos[1])
      return true if ship_can_be_placed
    end
    false
  end

  def place_ship(position_letter, position_number, direction = nil)
    @ship.place(position_letter, position_number, direction)
  end

  def add_ship_to_battlefield
    @battle_field.add_ship(@ship)
  end

  def ship_can_be_placed
    @battle_field.can_be_placed(@ship)
  end
end
