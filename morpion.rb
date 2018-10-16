require "pry"

# class : Plateau de jeu #
# Group : Groupe qui possede toutes les cases du plateau
# Verification des valeurs du groupe pour les conditions de victoire
class Board
  attr_accessor :group_of_case

  # Initialize le groupe (ne possede pas de case)
  def initialize(initialize_case = [])
    @group_of_case = initialize_case
  end

  # Ajoute une case au groupe
  def add_case(new_case)
    @group_of_case.push(new_case)
  end

  # Affichage des cases
  def display_board
    # On observe chaque case du groupe de case
    # L'utilisateur rentre une id de case, print ou put la valeur selon l'id
    # X ou O selon la case.value qui a etait modifie dans check_case_value
    @group_of_case.each do |my_case|
      case my_case.value
      when 1
        (my_case.id % 3).zero? ? (puts 'O') : (print 'O')
      when 2
        (my_case.id % 3).zero? ? (puts 'X') : (print 'X')
      else
        (my_case.id % 3).zero? ? (puts ' ') : (print ' ')
      end
      (print ' | ') unless (my_case.id % 3).zero?
      (puts '----------') if (my_case.id % 3).zero? && my_case.id != 9
    end
  end

  # Verifie si la case est vide, si non change la valeur de la case
  # La valeur de la case peut prendre 1 ou 2 selon quel joueur joue
  def check_case_value(my_case_id, my_player)
    @group_of_case.map! do |my_case|
      if my_case.id == my_case_id
        if my_case.value.zero?
          my_player == 1 ? (my_case.value = 1) : (my_case.value = 2)
        else
          p 'La case est deja prise!'
          return false
        end
      end
      my_case
    end
  end

  # Pour la comparaison des cases, offset positif (pour l'id)
  def select_positive(my_case_to_check, offset)
    (@group_of_case.select { |my_case| my_case.id == my_case_to_check + offset })[0].value
  end

  # Pour la comparaison des cases, offset negatif (pour l'id)
  def select_negative(my_case_to_check, offset)
    (@group_of_case.select { |my_case| my_case.id == my_case_to_check - offset })[0].value
  end

  # Verifie si il y a une victoire
  def check_victory(my_case_to_check)
    result = 0
    my_case_check_id = (@group_of_case.select { |my_case| my_case.id == my_case_to_check})[0].value

    # Verification des lignes
    # case 1 / 4 / 7
    comparaison_array = [1, 4, 7]
    if comparaison_array.include?(my_case_to_check)
      if my_case_check_id == select_positive(my_case_to_check, 1) && my_case_check_id == select_positive(my_case_to_check, 2)
        result += 2
      end
    end
    # Case 2 / 5 / 8
    comparaison_array = [2, 5, 8]
    if comparaison_array.include?(my_case_to_check)
      if my_case_check_id == select_negative(my_case_to_check, 1) && my_case_check_id == select_positive(my_case_to_check, 1)
        result += 2
      end
    end
    # Case 3 / 6 / 9
    comparaison_array = [3, 6, 9]
    if comparaison_array.include?(my_case_to_check)
      if my_case_check_id == select_negative(my_case_to_check, 1) && my_case_check_id == select_negative(my_case_to_check, 2)
        result += 2
      end
    end
    return true if result == 2
    result = 0

    # Verification des colonnes
    # case 1 / 2 / 3
    comparaison_array = [1, 2, 3]
    if comparaison_array.include?(my_case_to_check)
      if my_case_check_id == select_positive(my_case_to_check, 3) && my_case_check_id == select_positive(my_case_to_check, 6)
        result += 2
      end
    end
    # Case 4 / 5 / 6
    comparaison_array = [4, 5, 6]
    if comparaison_array.include?(my_case_to_check)
      if my_case_check_id == select_negative(my_case_to_check, 3) && my_case_check_id == select_positive(my_case_to_check, 3)
        result += 2
      end
    end
    # Case 7 / 8 / 9
    comparaison_array = [7, 8, 9]
    if comparaison_array.include?(my_case_to_check)
      if my_case_check_id == select_negative(my_case_to_check, 3) && my_case_check_id == select_negative(my_case_to_check, 6)
        result += 2
      end
    end
    return true if result == 2
    result = 0

    # Verification diagonale 159
    # Case 1
    if my_case_to_check == 1
      if my_case_check_id == select_positive(my_case_to_check, 4) && my_case_check_id == select_positive(my_case_to_check, 8)
        result += 2
      end
    end
    # Case 5
    if my_case_to_check == 5
      if my_case_check_id == select_negative(my_case_to_check, 4) && my_case_check_id == select_positive(my_case_to_check, 4)
        result += 2
      end
    end
    # Case 9
    if my_case_to_check == 9
      if my_case_check_id == select_negative(my_case_to_check, 4) && my_case_check_id == select_negative(my_case_to_check, 8)
        result += 2
      end
    end
    return true if result == 2
    result = 0

    # Verification diagonale 357
    # Case 3
    if my_case_to_check == 3
      if my_case_check_id == select_positive(my_case_to_check, 2) && my_case_check_id == select_positive(my_case_to_check, 4)
        result += 2
      end
    end
    # Case 5
    if my_case_to_check == 5
      if my_case_check_id == select_negative(my_case_to_check, 2) && my_case_check_id == select_positive(my_case_to_check, 2)
        result += 2
      end
    end
    # Case 7
    if my_case_to_check == 7
      if my_case_check_id == select_negative(my_case_to_check, 2) && my_case_check_id == select_negative(my_case_to_check, 4)
        result += 2
      end
    end

    true if result == 2
  end
end
############################################################

############################################################
# class : Case de jeu #
class BoardCase
  attr_accessor :value, :id

  # Initialization valeur de case : 0 => vide, 1 => rond, 2 => croix
  def initialize(my_case_id)
    @value = 0
    @id = my_case_id
  end
end
############################################################

############################################################
# class : joueur #
class Player
  attr_accessor :name, :number

  # Initialization joueur et victoire
  def initialize(name, player_number)
    @name = name.capitalize
    @number = player_number
  end

  # On appel le joueur a jouer
  def call_player
    print "C'est à #{@name} de jouer : Choisissez une case à jouer entre 1 et 9 "
    gets.chomp.to_i
  end
end
############################################################

############################################################
# class : partie du jeu #
class Game
  attr_accessor :nb_tour

  # On initialize la partie
  def initialize_game
    p '########################################################################################'
    p '########################################################################################'
    p 'Bienvenu dans le Tic-Tac-Toe !'
    p 'Le plateau se décrit de la manière suivante :'
    p '                1 | 2 | 3 '
    p '                ----------'
    p '                4 | 5 | 6 '
    p '                ----------'
    p '                7 | 8 | 9 '
    p 'A chaque tour, un des joueurs doit séléctionner la case ou il veut rentrer son symbole.'
    p 'Le premier joueur est les ronds, le second est les croix.'
    p 'Le jeu commence une fois que chaque joueur a inscrit son prénom.'
    p '########################################################################################'
    p '########################################################################################'
    @nb_tour = 1
  end

  # On verifie si c'est la fin du jeu en fonction de : Numero de tour == 5
  def check_end_game(number_game_turn)
    true if number_game_turn == 5
  end
end
############################################################

############################################################
# Methode #
# Defini un tour de jeu complet
def game_turn(game, player1, player2, board)
  1.upto(5) do |game_turn|
    # Joueur 1
    break if player_turn(player1, board) == true
    # On check la fin du game
    if game.check_end_game(game_turn) == true
      p 'Egalité !'
      break
    end
    # Joueur2
    break if player_turn(player2, board) == true
  end
  p 'Le jeu est fini!'
end

# Defini le tour d'un joueur
def player_turn(player, board)
  check_the_case = false
  while check_the_case == false
    my_choice = 0
    while my_choice < 1 || my_choice > 9
      my_choice = player.call_player
      if my_choice < 1 || my_choice > 9
        p "Ce n'est pas une commande valide!"
      end
    end
    check_the_case = board.check_case_value(my_choice, player.number)
  end
  board.display_board
  if board.check_victory(my_choice) == true
    p "#{player.name} a gagné!"
    return true
  end
end

# Fonction MAIN a appeler pour lancer une partie #
def main
  # Creation partie
  my_game = Game.new

  # Creation du board
  my_board = Board.new

  # Creation des cases du jeu (vide)
  1.upto(9) { |id| my_board.add_case(BoardCase.new(id)) }

  # Creation des joueurs
  print 'Nom du joueur 1 : '
  player1 = Player.new(gets.chomp.to_s, 1)
  print 'Nom du joueur 2 : '
  player2 = Player.new(gets.chomp.to_s, 2)
  my_board.display_board
  # Boucle du jeu
  game_turn(my_game, player1, player2, my_board)
end

# Lance la partie !
main