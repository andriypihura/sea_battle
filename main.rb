require './services/place_ship'
require './components/ship'
require './components/battle_field'
require './components/communication/question'
require './components/communication/info'
require './components/error_handler'

Communication::Info.greating
mannually = Communication::Question.mannually_placement
battle_field = BattleField.new(mannually: mannually)
battle_field.show_field
