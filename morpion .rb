############################################################
# class : Plateau de jeu #
# Group : Groupe qui possede toutes les cases du plateau
# Verification des valeurs du groupe pour les conditions de victoire
class Board
  attr_accessor :group_of_case

  # Initialize le groupe (ne possede pas de case)
  #on créé un tableau 
   def initialize(initialize_case = [])
    @group_of_case = initialize_case
  end

  # Ajoute une case au groupe
  def add_case(new_case)
    @group_of_case.push(new_case)
  end

  # Affichage des cases
  def display_board
    #pour chaque case du groupe de case
    #on va regarder la valeur de chacune des cases (my_case.value)
    #selon on va afficher X ou O ou rien selon l'id

    @group_of_case.each do |my_case|
      case my_case.value
      when 1
        #si ma case est un multiple de 3, alors modul 3 = 0
        #je vérifie si cest le cas ou pas
        # print n'ajoute pas de ligne après mon signe
        # puts ajoute une ligne après mon signe seulement pour les multiples de 3
        (my_case.id % 3).zero? ? (puts 'O') : (print 'O')
      when 2
        (my_case.id % 3).zero? ? (puts 'X') : (print 'X')
      else
        (my_case.id % 3).zero? ? (puts ' ') : (print ' ')
      end
      #on met la barre du coté sauf si la case est un multiple de 3
      (print ' | ') unless (my_case.id % 3).zero?
      #on met la barre du coté en sautant une ligne si la case est un multiple de 3
      #sauf pour la case 9
      (puts '----------') if (my_case.id % 3).zero? && my_case.id != 9
    end
  end

  # Verifie si la case est vide, si non change la valeur de la case
  # La valeur de la case peut prendre 1 ou 2 selon quel joueur joue
  def check_case_value(my_case_id, my_player)
    #on fait tourner les diffrentes cases
    @group_of_case.map! do |my_case|
      #quand on tombe sur mon numéro de case
      if my_case.id == my_case_id
        #on regarde si la valeure de la case est nulle
        if my_case.value.zero?
          #et si cest le cas
          #si il s'agit du jouer 1 alors on met la valeur de case à 1 
          #si il sagit du joueur 2 on met la valeur de case à 2
          my_player == 1 ? (my_case.value = 1) : (my_case.value = 2)
        else
          #sinon on lui dit que la case est deja prise
          p 'La case est deja prise!'
          return false
        end
      end
      #on retourne un array avec un id de case et une value
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
  #evidemment @name va changer selon si on appelle player1.call_player ou player_2.call_player
  def call_player
    print "C'est à #{@name} de jouer : Choisissez une case à jouer entre 1 et 9 "
    gets.chomp.to_i
    #on stock ce chiffre dans la variable #my_choice
  end
end
############################################################

############################################################
# class : partie du jeu #
class Game
  attr_accessor :nb_tour

  # On initialise la partie en affichant les consignes
  def initialize
     p '########################################################################################'
    p '########################################################################################'
    p 'Bienvenue dans le Morpion !'
    p ''
    p 'Voici le plateau sur lequel le jeu va se dérouler:'
    p '                1 | 2 | 3 '
    p '                ----------'
    p '                4 | 5 | 6 '
    p '                ----------'
    p '                7 | 8 | 9 '
    p ''
    p 'A chaque tour, un des joueurs doit séléctionner la case dans laquelle il souhaite jouer.'
    p 'Le premier joueur joue avec les ronds, le second avec les croix.'
    p 'Le jeu commence quand chaque joueur a inscrit son prénom'
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


  #pour chaque tour de 1 à 5

  1.upto(5) do |game_turn|

    # Joueur 1

    #on va appeler la méthode player_turn
    #et si elle renvoie vraie
    #avec comme argument la board et le joueur on s'arrete

    break if player_turn(player1, board) == true
    #cest la condition de victoire qui est définit dans la méthode player_turn
    #on s'arrete si on la rencontre
    
    # sinon on applique la méthode check_end_game de la classe game avec pour argument game turn
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
  #on a en entrée le joueur 1 ou 2 et my_board qui est le nom de la partie
  #on initialise une variable avec false
  check_the_case = false
  while check_the_case == false
    #tant que cest faux on lance une boucle
    #on initialise une variable a 0
    my_choice = 0
    while my_choice < 1 || my_choice > 9
      #tant que le choix est inférieur a 1 OU supérieur a 9
      #on créer une nouvelle variable en appelant la méthode call_player de player
      #on note que player est ici un argument qui va être soit player 1, soit player 2
      #cette méthode va inviter l'un des deux joueurs à joueur et lui demander un chiffre
      #on stock ce chiffre dans la variable my_choice

       my_choice = player.call_player

      if my_choice < 1 || my_choice > 9
        p "Ce n'est pas une commande valide!"
      end
    end

    check_the_case = board.check_case_value(my_choice, player.number)
    #apres la boucle on applique la méthode check_case_value de la classe board 
    #avec comme argument le choix du joueur et le numéro du joueur
    #player.number va etre différent selon player1.number et player2.number 
    #player.number n'appelle pas de méthode car c'est un argument de la classe player
    #attr_accessor :number sert à éviter justement d'avoir a définir une méthode number
    #check case value me retourner un array avec le num du joueur et la case

  end
  #a la fin du tour on affiche le plateau une fois qu'on a obtenu le 
  board.display_board
  #si on a une condition de victoire on affiche un message et on retour true
  if board.check_victory(my_choice) == true
    p "#{player.name} a gagné!"
    return true
  end
end

# Fonction MAIN a appeler pour lancer une partie #
def main
  # Creation partie : on créer une instance dans la classe Game
  # Cette instance va appeler la méthode .new qui est équivalente à la méthode .initialize 
  # (par défaut .new = .initialize)
  my_game = Game.new

  # Creation du plateau en créant une instance de la classe Board
  my_board = Board.new

  # Creation des cases du jeu (vide)
  #on va appeler la méthode add case de la classe myboard 
  #et on va lui appliquer en argument une nouvelle instance de la classe boardcass
  #par défaut boardcase va nous mettre notre valeur de case à 0
  #boardcase va nommer notre case en fonction de sa position en lui attribuant un id
  #cet id est stocké dans my_case.id
  1.upto(9) { |id| my_board.add_case(BoardCase.new(id)) }
   # On se retrouve avec un tableau de 9 cases vide non dessinées

  # Creation des joueurs 
  #en créant une nouvelle instance de la classe player
  #on passe en argument son nom et le numéro du joueur 
  print 'Nom du joueur 1 : '
  player1 = Player.new(gets.chomp.to_s, 1)

  #en créant une nouvelle instance de la classe player
  #on passe en argument son nom et le numéro du joueur 
  print 'Nom du joueur 2 : '
  player2 = Player.new(gets.chomp.to_s, 2)


  #on affiche le tableau en appelant la méthode display_board de la classe my_board
  my_board.display_board


  # On rentre dans le jeu en appelant la méthode game_turn de la classe Game
  # avec 4 arguments
  #my_game qui va servir a regarder si on a deja gagné ou pas
  #player 1 qui va m'indiquer les parametres du joueurs 1
  #player 2 qui va m'indiquer les parametres du joueurs 2
  #my_board qui va m'indiquer les paramètres du tableau

      game_turn(my_game, player1, player2, my_board)
end

# Lance la partie !
main