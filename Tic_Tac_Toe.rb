# tic_tac_toe

# Ajout de la Gem awesome_print qui permet d'ajouter des couleurs à un élément affiché.
require 'awesome_print'

class Board
  # Ici redéclare ici l'array pour pouvoir l'utiliser dans cette class.
  def initialize
    # (le 0 permet de considérer la première case comme l'élément 1 de l'array).
    @@array = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
  end

  # Cette méthode permet d'afficher le plateau initial.
  def initial_board
    puts top_top = '     |     |     '
    puts top_middle = "  #{@@array[1]}  |  #{@@array[2]}  |  #{@@array[3]}  "
    puts top_bottom = '_____|_____|_____'
    puts middle_top = '     |     |     '
    puts middle_middle = "  #{@@array[4]}  |  #{@@array[5]}  |  #{@@array[6]}  "
    puts middle_bottom = '_____|_____|_____'
    puts bottom_top = '     |     |     '
    puts bottom_middle = "  #{@@array[7]}  |  #{@@array[8]}  |  #{@@array[9]}  "
    puts bottom_bottom = '     |     |     '
  end
end

class Player
  attr_accessor :name, :player_value
  attr_writer :win

  def initialize(name, player_value)
    @name = name.capitalize
    @player_value = player_value
    @win = win = false
  end
end

class Game < Board
  # On déclare l'array qui contient les numéros de case du tic tac toe.
  def initialize
    # (le 0 permet de considérer la première case comme l'élément 1 de l'array).
    @@array = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
  end

  def go
    # Création de joueurs via les instances @player1 et @player2.
    puts 'Joueur 1 écrit ton nom'
    print '> '
    @player1 = Player.new(gets.chomp, 'X'.blue)
    # Affiche les noms des joueurs et leur symbole.
    puts "#{@player1.name} Tu joue la #{@player1.player_value}"
    puts 'Joueur 2 écrit ton nom'
    print '> '
    @player2 = Player.new(gets.chomp, 'O'.red)
    puts "#{@player2.name} Tu joue le #{@player2.player_value}"
  end

  # La méthode win_condition contient toutes les conditions de victoire.
  def win_condition
    return true if @@array[1] == @@array[2] && @@array[2] == @@array[3]
    return true if @@array[4] == @@array[5] && @@array[5] == @@array[6]
    return true if @@array[7] == @@array[8] && @@array[8] == @@array[9]
    return true if @@array[1] == @@array[4] && @@array[4] == @@array[7]
    return true if @@array[2] == @@array[5] && @@array[5] == @@array[8]
    return true if @@array[3] == @@array[6] && @@array[6] == @@array[9]
    return true if @@array[1] == @@array[5] && @@array[5] == @@array[9]
    return true if @@array[3] == @@array[5] && @@array[5] == @@array[7]
  end

  # C'est ici que tout se passe.
  def turn
    i = 0
    # On demande au joueur 1 de choisir une case.
    puts "#{@player1.name} c'est ton tour de jouer, choisi une case :"
    print '> '

    # Le "gets.chomp" récupère le choix et la ligne suivante applique le choix sur la string.
    i = gets.chomp
    @@array[i.to_i] = 'X'.blue

    puts top_top = '     |     |     '
    puts top_middle = "  #{@@array[1]}  |  #{@@array[2]}  |  #{@@array[3]}  "
    puts top_bottom = '_____|_____|_____'
    puts middle_top = '     |     |     '
    puts middle_middle = "  #{@@array[4]}  |  #{@@array[5]}  |  #{@@array[6]}  "
    puts middle_bottom = '_____|_____|_____'
    puts bottom_top = '     |     |     '
    puts bottom_middle = "  #{@@array[7]}  |  #{@@array[8]}  |  #{@@array[9]}  "
    puts bottom_bottom = '     |     |     '

    # Appelle la fonction win_condition pour vérifier si le tour est gagnant.
    return puts "#{@player1.name} à gagné ! 🎉" if win_condition == true

    i = 0
    # On demande au joueur 2 de choisir une case.
    puts "#{@player2.name} c'est ton tour de jouer, choisi une case :"
    print '> '

    i = gets.chomp
    @@array[i.to_i] = 'O'.red

    puts top_top = '     |     |     '
    puts top_middle = "  #{@@array[1]}  |  #{@@array[2]}  |  #{@@array[3]}  "
    puts top_bottom = '_____|_____|_____'
    puts middle_top = '     |     |     '
    puts middle_middle = "  #{@@array[4]}  |  #{@@array[5]}  |  #{@@array[6]}  "
    puts middle_bottom = '_____|_____|_____'
    puts bottom_top = '     |     |     '
    puts bottom_middle = "  #{@@array[7]}  |  #{@@array[8]}  |  #{@@array[9]}  "
    puts bottom_bottom = '     |     |     '

    return puts "#{@player2.name} à gagné ! 🎉" if win_condition == true

    turn
  end
end

# La méthode perform permet de lancer le programme dans un ordre précis.
def perform
  game = Game.new
  game.go
  Board.new.initial_board
  game.turn
  puts 'voulez-vous rejouer ? (oui/non)'
  return perform if gets.chomp == 'oui'
end

perform
