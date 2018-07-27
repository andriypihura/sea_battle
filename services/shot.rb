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
    puts 'part'
    print ship.get_part(@position_letter, @position_number)
    puts
    ship.get_part(@position_letter, @position_number).kill
    @battle_field.update_ship_status(ship)
  end
end
