# frozen_string_literal: true

# show field
class ShowFields
  def initialize(user_field, oponent_field = nil)
    @user_field_rows_data = user_field.get_field_row_data
    @oponent_field_rows_data = oponent_field&.get_field_row_data(hidden: true)
  end

  def call
    system('clear')
    show_fields
  end

  private

  def show_fields
    show_row(top_line, (top_line if @oponent_field_rows_data))
    10.times do |index|
      if @oponent_field_rows_data
        show_row(@user_field_rows_data[index], @oponent_field_rows_data[index])
      else
        show_row(@user_field_rows_data[index])
      end
    end
  end

  def top_line
    '-' + Array.new(10) { |e| "  #{e} " }.join
  end

  def delimiter
    '    |||    '
  end

  def show_row(first_field_data, second_field_data = nil)
    puts [first_field_data, second_field_data].compact.join(delimiter)
  end
end
