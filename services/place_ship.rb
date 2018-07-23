# place ship
class PlaceShip
  def initialize(battle_field, ship, mannually)
    @battle_field = battle_field
    @ship = ship
    @mannually = mannually
  end

  def call
    loop do
      @mannually ? set_mannual_position : set_rand_position
      break if @battle_field.can_be_placed(@ship)
      Communication::Info.cant_place
    end
    add_ship_to_battlefield
  end

  private

  def set_mannual_position
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
      break if @battle_field.can_be_placed(@ship)
    end
  end

  def place_ship(position_letter, position_number, direction = nil)
    @ship.place(position_letter, position_number, direction)
  end

  def add_ship_to_battlefield
    @battle_field.add_ship(@ship)
  end
end
