# frozen_string_literal: true

# inits shot
class Shot
  def initialize(battle_field, position_letter, position_number)
    @battle_field = battle_field
    @position_letter = position_letter
    @position_number = position_number
  end

  def call
    ship = @battle_field.get_ship(@position_letter, @position_number)
    damage_ship(ship) if ship
    @battle_field.update(@position_letter, @position_number)
  end

  private

  def damage_ship(ship)
    @battle_field.damage_ship(ship, @position_letter, @position_number)
  end
end
