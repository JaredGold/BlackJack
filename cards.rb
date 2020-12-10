class Card
    attr_reader :name, :value ,:suit, :emoji
    def initialize(name, suit, value, emoji)
        @name = name
        @suit = suit
        @value = value
        @emoji = emoji

        @card = TTY::Box.frame(width: 5, height: 4, align: :center, border: :thick,title: {top_left: " #{@emoji} ", bottom_right: " #{@emoji} "}) do "#{@name}" end
    end

    def inspect
        puts "#{@name.capitalize} of #{suit} #{@emoji} - Value : #{value} and it looks like: "
        puts "#{@card}"
    end

    def to_s
        @card
    end

end

class Ace < Card
    def initialize(name, suit, emoji)
        super(name, suit, 11, emoji)
    end

    def value_change
        @value = @value == 1 ? 11 : 1
    end
end