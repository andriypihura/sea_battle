# frozen_string_literal: true

module Communication
  # general information
  class Info
    class << self
      def show_header
        if STDIN.winsize[1] > 114
          show_text_center '                                                []                        []        []        []                  '
          show_text_center '                                                []                    [][][][][][][][][][]    []                  '
          show_text_center '     [][][][][][][]    [][][][]    [][][][][]   []          [][][][][]    []        []        []          [][][][]'
          show_text_center '   [][][]    [][][]    []          []      []   []          []      []    []        []        []          []      '
          show_text_center '   [][][]              []          []      []   [][][][][]  []      []    []        []        []          []      '
          show_text_center '     [][][][][]        [][][][]    [][][][][]   []      []  [][][][][]    []        []        []          [][][][]'
          show_text_center '           [][][][]    []          []      []   []      []  []      []    []        []        []          []      '
          show_text_center '  [][]  [][][][]       []          []      []   []      []  []      []    []        []        []          []      '
          show_text_center '   [][][][][][]        [][][][]    []      []   [][][][][]  []      []    [][][][]  [][][][]  [][][][][]  [][][][]'
        else
          show_text_center '╱╱╱╱╱╱╱╱╱╱╭╮╱╱╱╱╭╮╱╭╮╭╮    '
          show_text_center '╱╱╱╱╱╱╱╱╱╱┃┃╱╱╱╭╯╰┳╯╰┫┃    '
          show_text_center '╭━━┳━━┳━━╮┃╰━┳━┻╮╭┻╮╭┫┃╭━━╮'
          show_text_center '┃━━┫┃━┫╭╮┃┃╭╮┃╭╮┃┃╱┃┃┃┃┃┃━┫'
          show_text_center '┣━━┃┃━┫╭╮┃┃╰╯┃╭╮┃╰╮┃╰┫╰┫┃━┫'
          show_text_center '╰━━┻━━┻╯╰╯╰━━┻╯╰┻━╯╰━┻━┻━━╯'
        end
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
        puts 'Yeah! Congratulation!'.green
      end

      def loser
        puts 'You lost this game :('.red
        puts 'Mb you are not so bad in smth else! (do not play again)'
      end

      def successfull_shot
        puts 'Bang-bang mthrfckr! Yeah!'.green
        your_turn
      end

      def your_turn
        puts 'Your turn'.green
      end

      private

      def show_text_center(str)
        puts str.center(STDIN.winsize[1])
      end
    end
  end
end
