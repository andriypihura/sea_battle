# creates a part of ship
class ShipPart
  STATUSES = {
    alive: 'alive',
    dead: 'dead'
  }.freeze

  attr_reader :status, :position_letter, :position_number

  def initialize(position_letter, position_number)
    @status = STATUSES[:alive]
    @position_letter = position_letter
    @position_number = position_number
  end

  def kill
    @status = STATUSES[:dead]
  end
end
