# frozen_string_literal: true

module Communication
  # general information
  class Info
    def self.greating
      puts 'Greating!'
    end

    def self.field_ready
      puts 'Your field ready!'
    end

    def self.ship_size_details(size)
      puts "Please, place somewhere ship with size: #{size}"
    end

    def self.cant_place
      puts 'Wow, I cant place the ship here, let\'s try again..'
    end

    def self.winner
      puts 'Yeah! Congrads'
    end

    def self.loser
      puts 'Oh noo!'
    end
  end
end
