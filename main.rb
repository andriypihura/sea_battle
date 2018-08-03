# frozen_string_literal: true

require 'colorize'
require 'io/console'
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
require './components/sea_battle'

system('clear')
Communication::Info.show_header
Communication::Info.greating
sea_battle = SeaBattle.new
sea_battle.build_battle_fields
sea_battle.show_fields
sea_battle.start
