# frozen_string_literal: true

# check for custom errors
class CheckErrors
  def initialize(show_messages: false)
    @show_messages = show_messages
  end

  def outside_field_area(ship_data)
    return if (ship_data & (100..150).to_a).empty?
    puts 'Ship can not be placed outside field area' if @show_messages
    true
  end

  def dont_fit(ship_data)
    return if ship_data.map { |e| e % 10 }.uniq.count == 1 ||
              ship_data.map { |e| e.floor(-1) }.uniq.count == 1
    puts 'do not fit in row/column' if @show_messages
    true
  end

  def dont_free_space(ship_data, field_data)
    return if (field_data & ship_data).empty?
    puts 'place for this ship already taken' if @show_messages
    true
  end

  def already_in_fire(shotted_places, position_letter, position_number)
    return unless shotted_places.include?(position_letter * 10 + position_number)
    puts 'Your have already fired in this place!' if @show_messages
    true
  end
end
