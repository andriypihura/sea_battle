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
    @user_battle_field.show_field_matrix
    puts top_line
    @oponent_battle_field.show_field_matrix(hidden: true)
  end

  def top_line
    '-' + Array.new(10) { |e| "  #{e} " }.join
  end
end
