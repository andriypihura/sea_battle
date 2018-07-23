require './services/place_ship'
require './services/check_errors'
require './services/show_fields'
require './components/ship'
require './components/battle_field'
require './components/communication/question'
require './components/communication/info'

Communication::Info.greating
mannually = Communication::Question.mannually_placement
battle_field = BattleField.new(mannually: mannually)
ShowFields.new(battle_field).call
