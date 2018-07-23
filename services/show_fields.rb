# show field
class ShowFields
  def initialize(user_battle_field, oponent_battle_field = nil)
    @user_battle_field = user_battle_field
    @oponent_battle_field = oponent_battle_field
  end

  def call
    show_fields
  end

  private

  def show_fields
    puts top_line
    10.times { |row| puts field_row(row) }
  end

  def top_line
    [@user_battle_field, @oponent_battle_field].compact.map do
      '-' + Array.new(10) { |e| "  #{e} " }.join
    end.join(ships_delimiter)
  end

  def field_row(row)
    shoting_field = @user_battle_field.shoting_field
    Ship::POS_LETTERS.keys[row].to_s + Array.new(10) do |col|
      shoting_field.include?(row * 10 + col) ? ' [] ' : ' -- '
    end.join
  end

  def ships_delimiter
    '  |||  '
  end
end
