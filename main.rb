require './services/place_ship'
require './services/check_errors'
require './services/show_fields'
require './services/shot'
require './components/ship'
require './components/ship_part'
require './components/battle_field'
require './components/communication/question'
require './components/communication/info'

Communication::Info.greating
mannually = Communication::Question.mannually_placement
user_battle_field = BattleField.new(mannually: mannually)
opponent_battle_field = BattleField.new
ShowFields.new(user_battle_field, opponent_battle_field).call
loop do
  position = Communication::Question.position
  Shot.new(
    opponent_battle_field,
    position[:pos_letter],
    position[:pos_number]).call
  break if user_battle_field.destroyed? || opponent_battle_field.destroyed?
  # Shot.new(user_battle_field).call
  ShowFields.new(user_battle_field, opponent_battle_field).call
end
puts 'finish'
