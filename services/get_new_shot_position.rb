# frozen_string_literal: true

# artificial intelligense for shooting =)
class GetNewShotPosition
  def initialize(damaged_parts_view_data, shooted_places)
    @shooted_places = shooted_places
    @damaged_parts_view_data = damaged_parts_view_data
  end

  def call
    choose_near_position
    choose_random_position unless @position
    [@position.floor(-1) / 10, @position % 10]
  end

  private

  def choose_near_position
    @damaged_parts_view_data.each do |ship_part|
      positions = [(ship_part + 10 if ship_part < 90),
                   (ship_part + 1 if ship_part % 10 != 9),
                   (ship_part - 10 if ship_part > 9),
                   (ship_part - 1 if ship_part % 10 != 0)]

      positions.each do |pos|
        @position = pos unless @shooted_places.include?(pos)
      end
    end
  end

  def choose_random_position
    @position = ((0...100).to_a - @shooted_places).sample
  end
end
