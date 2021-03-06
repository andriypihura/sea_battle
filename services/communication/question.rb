# frozen_string_literal: true

module Communication
  # questions to user
  class Question
    class << self
      def direction
        puts 'Enter direction (v - vertical | h - horizontal):'
        input_str = gets.chomp
        allow_answers(input_str, 'v', 'h')
        Ship::DIRECTIONS[input_str.casecmp('v').zero? ? :vertical : :horizontal]
      end

      def mannually_placement
        puts 'Do you wanna to place your ships mannually? (y/n)'
        input_str = gets.chomp
        allow_answers(input_str, 'y', 'n')
        input_str.casecmp('y').zero?
      end

      def position
        {
          pos_letter: ask_about_position_letter,
          pos_number: ask_about_position_number
        }
      end

      def ask_about_position_letter
        puts 'Enter letter position (from A to K):'
        input_str = allow_answers(gets.chomp.downcase,
                                  *Ship::POS_LETTERS.keys.map(&:to_s))
        Ship::POS_LETTERS[input_str.to_sym]
      end

      def ask_about_position_number
        puts 'Enter number position (from 0 to 9):'
        input_str = gets.chomp
        allow_answers(input_str, *(0..9).map(&:to_s))
        input_str.to_i
      end

      def allow_answers(input_str, *args)
        return input_str if args.include?(input_str)
        puts "Hm, please, try again (available options #{args}):"
        allow_answers(gets.chomp.downcase, *args)
      end
    end
  end
end
