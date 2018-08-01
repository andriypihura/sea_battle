# frozen_string_literal: true

require './services/place_ship'
require './services/check_errors'
require './services/show_fields'
require './services/shot'
require './services/get_new_shot_position'
require './services/communication/question'
require './services/communication/info'
require './components/ship'
require './components/ship_part'
require './components/battle_field'

system('clear')
Communication::Info.greating
mannually = Communication::Question.mannually_placement
user_battle_field = BattleField.new(mannually: mannually)
opponent_battle_field = BattleField.new
error_checker = CheckErrors.new(show_messages: true)
ShowFields.new(user_battle_field, opponent_battle_field).call
loop do
  loop do
    position = Communication::Question.position
    unless error_checker.already_in_fire(
      opponent_battle_field.shotted_places,
      position[:pos_letter],
      position[:pos_number]
    )
      Shot.new(
        opponent_battle_field,
        position[:pos_letter],
        position[:pos_number]
      ).call
      break
    end
  end
  Shot.new(
    user_battle_field,
    *GetNewShotPosition.new(
      user_battle_field.damaged_parts_view_data,
      user_battle_field.shotted_places
    ).call
  ).call
  ShowFields.new(user_battle_field, opponent_battle_field).call
  break if user_battle_field.destroyed? || opponent_battle_field.destroyed?
end

if opponent_battle_field.destroyed?
  Communication::Info.winner
else
  Communication::Info.loser
end
