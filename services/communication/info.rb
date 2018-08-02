# frozen_string_literal: true

require 'colorize'

module Communication
  # general information
  class Info
    class << self
      def show_header
        puts '╱╱╱╱╱╱╱╱╱╱╭╮╱╱╱╱╭╮╱╭╮╭╮'
        puts '╱╱╱╱╱╱╱╱╱╱┃┃╱╱╱╭╯╰┳╯╰┫┃'
        puts '╭━━┳━━┳━━╮┃╰━┳━┻╮╭┻╮╭┫┃╭━━╮'
        puts '┃━━┫┃━┫╭╮┃┃╭╮┃╭╮┃┃╱┃┃┃┃┃┃━┫'
        puts '┣━━┃┃━┫╭╮┃┃╰╯┃╭╮┃╰╮┃╰┫╰┫┃━┫'
        puts '╰━━┻━━┻╯╰╯╰━━┻╯╰┻━╯╰━┻━┻━━╯'
        puts
      end

      def greating
        puts 'Greating!'.green
      end

      def field_ready
        puts 'Your field ready!'
      end

      def ship_size_details(size)
        puts "Please, place somewhere ship with size: #{size}"
      end

      def cant_place
        puts 'Wow, I cant place the ship here, let\'s try again..'
      end

      def winner
        puts 'Yeah! Congrads'
      end

      def loser
        puts 'Oh noo!'
      end
    end
  end
end
