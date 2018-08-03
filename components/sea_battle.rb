# frozen_string_literal: true

# main game class
class SeaBattle
  attr_reader :user_battle_field, :opponent_battle_field

  def initialize; end

  def build_battle_fields
    mannually = Communication::Question.mannually_placement
    @user_battle_field = BattleField.new(mannually: mannually)
    @opponent_battle_field = BattleField.new
  end

  def show_fields
    system('clear')
    ShowFields.new(user_battle_field, opponent_battle_field).call
  end

  def start
    init_new_turns
    battle_end_text
  end

  def init_new_turns
    Communication::Info.your_turn
    users_turn
    opponents_turn
    show_fields
    init_new_turns unless someone_won?
  end

  private

  def users_turn
    return if someone_won?
    user_shot = Shot.new(opponent_battle_field,
                         *get_position_for_shot)
    user_shot.call
    return unless user_shot.successfull?
    show_fields
    Communication::Info.successfull_shot
    users_turn
  end

  def opponents_turn
    return if someone_won?
    opponent_shot = Shot.new(user_battle_field,
                             *get_position_for_shot(random: true))
    opponent_shot.call
    opponents_turn if opponent_shot.successfull?
  end

  def get_position_for_shot(random: false)
    return random_position_for_shot if random
    position = Communication::Question.position
    position_data = [position[:pos_letter], position[:pos_number]]
    return position_data unless already_in_fire(position_data)
    get_position_for_shot
  end

  def random_position_for_shot
    GetNewShotPosition.new(
      user_battle_field.damaged_parts_view_data,
      user_battle_field.shotted_places
    ).call
  end

  def someone_won?
    user_battle_field.destroyed? || opponent_battle_field.destroyed?
  end

  def battle_end_text
    if opponent_battle_field.destroyed?
      Communication::Info.winner
    else
      Communication::Info.loser
    end
  end

  def already_in_fire(position_data)
    CheckErrors.new(show_messages: true).already_in_fire(
      opponent_battle_field.shotted_places,
      *position_data
    )
  end
end
