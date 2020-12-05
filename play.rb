# Initialisation
require('tty-box')
require('tty-table')
require('tty-prompt')
require('./deck.rb')
require('./cards.rb')
prompt = TTY::Prompt.new

# Variables
player_hand = []
banker_hand = []
deck = []
player_value = 0
banker_value = 0
game_loop = true
banker_loop = true


# Creates Options - Hit, Stand, Exit
def play_options(prompt)
    choices = [
        {name: "Hit", value: 1},
        {name: "Stand", value: 2},
        {name: "Exit", value: 3}
    ]
    chosen_option = prompt.select("What would you like to do?", choices, help_color: :yellow, help: "(Use Keybvoard keys)", show_help: :start, filter: true)
end

# Collection of all cards (Create all Cards)
def create_deck
    all_cards = []
    # Hearts ♥
    all_cards << ace_of_hearts = Ace.new('A', 'hearts', "♥")
    all_cards << king_of_hearts = Card.new('K', 'hearts', 10, "♥")
    all_cards << queen_of_hearts = Card.new('Q', 'hearts', 10, "♥")
    all_cards << jack_of_hearts = Card.new('J', 'hearts', 10, "♥")
    all_cards << ten_of_hearts = Card.new('10', 'hearts', 10, "♥")
    all_cards << nine_of_hearts = Card.new('9', 'hearts', 9, "♥")
    all_cards << eight_of_hearts = Card.new('8', 'hearts', 8, "♥")
    all_cards << seven_of_hearts = Card.new('7', 'hearts', 7, "♥")
    all_cards << six_of_hearts = Card.new('6', 'hearts', 6, "♥")
    all_cards << five_of_hearts = Card.new('5', 'hearts', 5, "♥")
    all_cards << four_of_hearts = Card.new('4', 'hearts', 4, "♥")
    all_cards << three_of_hearts = Card.new('3', 'hearts', 3, "♥")
    all_cards << two_of_hearts = Card.new('2', 'hearts', 2, "♥")
    # Spades ♠
    all_cards << ace_of_spades = Ace.new('A', 'spades', "♠")
    all_cards << king_of_spades = Card.new('K', 'spades', 10, "♠")
    all_cards << queen_of_spades = Card.new('Q', 'spades', 10, "♠")
    all_cards << jack_of_spades = Card.new('J', 'spades', 10, "♠")
    all_cards << ten_of_spades = Card.new('10', 'spades', 10, "♠")
    all_cards << nine_of_spades = Card.new('9', 'spades', 9, "♠")
    all_cards << eight_of_spades = Card.new('8', 'spades', 8, "♠")
    all_cards << seven_of_spades = Card.new('7', 'spades', 7, "♠")
    all_cards << six_of_spades = Card.new('6', 'spades', 6, "♠")
    all_cards << five_of_spades = Card.new('5', 'spades', 5, "♠")
    all_cards << four_of_spades = Card.new('4', 'spades', 4, "♠")
    all_cards << three_of_spades = Card.new('3', 'spades', 3, "♠")
    all_cards << two_of_spades = Card.new('2', 'spades', 2, "♠")
    # Diamonds ♦
    all_cards << ace_of_diamonds = Ace.new('A', 'diamonds', "♦")
    all_cards << king_of_diamonds = Card.new('K', 'diamonds', 10, "♦")
    all_cards << queen_of_diamonds = Card.new('Q', 'diamonds', 10, "♦")
    all_cards << jack_of_diamonds = Card.new('J', 'diamonds', 10, "♦")
    all_cards << ten_of_diamonds = Card.new('10', 'diamonds', 10, "♦")
    all_cards << nine_of_diamonds = Card.new('9', 'diamonds', 9, "♦")
    all_cards << eight_of_diamonds = Card.new('8', 'diamonds', 8, "♦")
    all_cards << seven_of_diamonds = Card.new('7', 'diamonds', 7, "♦")
    all_cards << six_of_diamonds = Card.new('6', 'diamonds', 6, "♦")
    all_cards << five_of_diamonds = Card.new('5', 'diamonds', 5, "♦")
    all_cards << four_of_diamonds = Card.new('4', 'diamonds', 4, "♦")
    all_cards << three_of_diamonds = Card.new('3', 'diamonds', 3, "♦")
    all_cards << two_of_diamonds = Card.new('2', 'diamonds', 2, "♦")
    # Clubs ♣
    all_cards << ace_of_clubs = Ace.new('A', 'clubs', "♣")
    all_cards << king_of_clubs = Card.new('K', 'clubs', 10, "♣")
    all_cards << queen_of_clubs = Card.new('Q', 'clubs', 10, "♣")
    all_cards << jack_of_clubs = Card.new('J', 'clubs', 10, "♣")
    all_cards << ten_of_clubs = Card.new('10', 'clubs', 10, "♣")
    all_cards << nine_of_clubs = Card.new('9', 'clubs', 9, "♣")
    all_cards << eight_of_clubs = Card.new('8', 'clubs', 8, "♣")
    all_cards << seven_of_clubs = Card.new('7', 'clubs', 7, "♣")
    all_cards << six_of_clubs = Card.new('6', 'clubs', 6, "♣")
    all_cards << five_of_clubs = Card.new('5', 'clubs', 5, "♣")
    all_cards << four_of_clubs = Card.new('4', 'clubs', 4, "♣")
    all_cards << three_of_clubs = Card.new('3', 'clubs', 3, "♣")
    all_cards << two_of_clubs = Card.new('2', 'clubs', 2, "♣")
    all_cards
end

# Create Blank Card Viarable
blank_card = @card = TTY::Box.frame(width: 5, height: 4, align: :center, border: :thick,title: {top_left: " ? ", bottom_right: " ? "}) do "" end

# Current Deck
reset_deck = proc{
    deck = Deck.new(create_deck)
}

update_hand_values = proc{
    player_value = player_hand.reduce(0) do |sum , card|
        sum += card.value
    end
    banker_value = banker_hand.reduce(0) do |sum , card|
        sum += card.value
    end
}

# Deal Blackjack Cards
deal_blackjack = proc {
    deck.shuffle
    player_hand << deck.draw_card
    banker_hand << deck.draw_card
    player_hand << deck.draw_card
    banker_hand << deck.draw_card
}

draw_hidden_hand = proc {
    player_table = TTY::Table.new([[player_hand[0], player_hand[1], player_hand[2], player_hand[3], player_hand[4]]])
    player_multi_renderer = TTY::Table::Renderer::Basic.new(player_table, multiline: true)
    banker_table = TTY::Table.new([[blank_card, banker_hand[1], banker_hand[2], banker_hand[3], banker_hand[4]]])
    banker_multi_renderer = TTY::Table::Renderer::Basic.new(banker_table, multiline: true)
    
    # Finds Hand Values
    update_hand_values.call

    # Draw Hand
    system('clear')
    puts "Dealer's Cards"
    puts banker_value - banker_hand[0].value
    puts banker_multi_renderer.render

    puts "---------------------------"

    puts "Your Cards"
    puts player_value
    puts player_multi_renderer.render
}

draw_visible_hand = proc {
    player_table = TTY::Table.new([[player_hand[0], player_hand[1], player_hand[2], player_hand[3], player_hand[4]]])
    player_multi_renderer = TTY::Table::Renderer::Basic.new(player_table, multiline: true)
    banker_table = TTY::Table.new([[banker_hand[0], banker_hand[1], banker_hand[2], banker_hand[3], banker_hand[4]]])
    banker_multi_renderer = TTY::Table::Renderer::Basic.new(banker_table, multiline: true)
    
    # Finds Hand Values
    update_hand_values.call
    # Draw Hand
    system('clear')
    puts "Dealer's Cards"
    puts banker_value
    puts banker_multi_renderer.render

    puts "---------------------------"

    puts "Your Cards"
    puts player_value
    puts player_multi_renderer.render
}


reset_deck.call
deal_blackjack.call
draw_hidden_hand.call


# Gameplay Loop
while game_loop
    # Gives Options (Hit, Stand, Exit)
    chosen_option = play_options(prompt)

    case chosen_option
    when 1
        # Gives Player a card
        player_hand << deck.draw_card
        draw_hidden_hand.call
        
        # Check for if loss state can be avoided
        if player_value > 21
            player_hand.each_with_index do |card , index|
                if card.kind_of?(Ace) && card.value == 11    
                    card.value_change
                    draw_hidden_hand.call
                end
            end
            if player_value > 21
                draw_visible_hand.call
                game_loop = false
            end
        end

        chosen_option = 0
    when 2
        while banker_loop
            if banker_value < 17
                # Show player the hidden card and new banker value
                draw_visible_hand.call

                # Draw a new card for the banker and update the table and values
                banker_hand << deck.draw_card

                # Pause for effect!
                sleep(0.75)
            else
                banker_hand.each_with_index do |card , index|
                    if card.kind_of?(Ace) && card.value == 11    
                        card.value_change
                        update_hand_values.call
                    end
                end

                if banker_value > 21
                    banker_loop == false
                end  
            end
        end

        draw_visible_hand.call
        chosen_option = 0
        game_loop = false
    when 3
        chosen_option = 0
        break
    end
end


# Win Logic
sleep(1)
if banker_value > 21
    puts "YOU WIN!"
elsif banker_value > player_value || player_value > 21
    puts "LOSER"
else
    puts "YOU WIN!"
end