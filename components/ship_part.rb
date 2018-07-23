# creates a part of ship
class ShipPart
  def initialize(position_letter, position_number)
    @status = Ship::STATUSES[:alive]
    @position_letter = position_letter
    @position_number = position_number
  end
end
