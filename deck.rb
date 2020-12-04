class Deck
    def initialize(cards)
        @cards = cards
    end
    def shuffle
        @cards.shuffle!
    end
    def to_s
        @cards.each do |x|
            x.print_card
        end
    end
    def draw_card
        @cards.shift
    end
end