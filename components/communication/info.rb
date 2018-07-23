module Communication
  # general information
  class Info
    def self.greating
      puts 'Greating!'
    end

    def self.field_ready
      puts 'Your field ready!'
    end

    def self.cant_place
      puts 'Wow, I cant place the ship here, let\'s try again..'
    end
  end
end
