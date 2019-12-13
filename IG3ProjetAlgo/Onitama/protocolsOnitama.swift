//Type Abstrait : Board

protocol Board {
    //init : -> Board
    // initialise le plateau de jeu et la partie
    // création du deck, des joueurs de leurs pions et distribution des cartes au joueur
    init ()

    // redTemple : Board -> Temple
    // retourne le temple rouge
    var redTemple : Temple { get }

    // blueTemple : Board -> Temple
    // retourne le temple bleu
    var blueTemple : Temple{ get }

    // currentPlayer : Board -> Player
    // retourne le joueur qui est en train de jouer
    // Precondition : pour le set, le player ne doit pas etre vide et peux prendre ses valeurs entre currentPlayer et offPlayer
    var currentPlayer : Player { get set }

    // offPlayer : Board -> Player
    // retourne le joueur qui n'est pas en train de jouer
    // Precondition : pour le set, le player ne doit pas etre vide et peux prendre ses valeurs entre offPlayer et currentPlayer
    var offPlayer : Player { get set }
    
    // standByCard : Board -> Card
    // retourne la carte en attente d'échange
    // Precondition : pour le set, la carte ne doit pas être vide et peux prendre ses valeurs parmi les cartes de currentPlayer ou de offPlayer 
    var standbyCard : Card { get set }

    //selectedPiece : Board -> Piece
    //renvoi le pion selectionné par l'utilisateur 
    // Precondition : pour le set, contient la piece selectionnee par le joueur, sa valeur doit etre parmi les pieces du joueur 
    var selectedPiece : Piece { get set }
    
    //selctedCard : Board -> Card
    //renvoi la carte sélectionnée par l'utilisateur 
    // Precondition : pour le set, contient la carte selectionnee par le joueur, sa valeur doit etre parmi les cartes du joueur
    var selectedCard : Card { get set }

    // endGame : Board -> Bool
    // Pre : prend un Board 
    // Post : renvoi vrai si l'un des deux joueurs de ce plateau a isWinner à vrai sinon faux
    func endGame() -> Bool 

    // switchCard : Board x Card x Card -> Board
    // échange 2 cartes dans une partie
    mutating func switchCard (carte1 : Card, carte2 : Card) 

    // movePiece : Board x Piece x (Int x Int) -> Board
    // Pre : pour un pion du plateau et une collection de couple entier relatif (x,y) avec x et y ]-5,5[
    // Post : modifie les positions x1 et y1 du pion sur le plateau par x1 = x1+x et
    //y1 =y1+y
    mutating func movePiece (pion : Piece, moves: (Int,Int))

    // possibleMoves : Card x Piece -> [(Int x Int)]
    // retourne les possibilités de déplacement valide qu'offre une carte à la pièce :
    //déplacement impossible :  si un de nos pions se trouve dessus / si en dehors des
    //limites du plateau
    func possibleMoves (pion : Piece, card : Card) -> [(Int , Int)]

    //countPossibleMoves : Board x Piece x Card -> Int
    // compte le nombre de déplacements possibles
    // Pre : prend une piece et une carte du Board
    // Post : compte le nombre de deplacements dans possibleMoves et renvoi ce nombre entier
    func countPossibleMoves(pion : Piece, card : Card) -> Int

}


//Type Abstrait : Piece

protocol Piece {
    // init : -> Piece
    // initialise une pièce : 
    // - sa coordonnée x
    // - sa coordonnée y
    // - sa classe : si il est roi ou pas
    init(x: Int, y: Int , isMaster : Bool, player : Player)

    // x : Piece -> Int
    // la position x de la pièce donnée
    // Precondition : x est entier positif ou nul. x compris entre 0 et 4 inclus
    var x : Int { get set }

    // y : Piece -> Int
    // la position y de la pièce donnée
    // Precondition : y est entier positif ou nul. y compris entre 0 et 4
    var y : Int { get set }

    // isMaster : Piece -> Bool
    // booleen qui prend vrai si la pièce donnée est le maitre
    //faux sinon
    var isMaster : Bool { get }

    // position : Piece -> (Int x Int)
    // renvoi le couple (x,y) entier de position pour une pièce donnée
    // Précondition : x et y appartiennent à [0,4] et sont entier
    var position : (Int , Int) { get }
	
	
	// player : Piece -> Player
	// retourne le joueur auquel le pion appartient
	// facilite les verifications dans la fonction possibleMoves du Board   
	var player : Player { get }

    // comparePosition : Piece x Piece -> Bool
    // compare la position de la pièce donnée avec une autre pièce nommée piece2
    // Precondition : les coordonnées des 2 pièces appartiennent à [0,4]
    func comparePosition (piece2 : Piece) -> Bool

    //permet de test si pion est attaque un de ceux de l'adversaire
    //Pre : prend une collection de pions
    // Post : retourne vrai si vrai si le pion est sur la meme position x et y qu'un autre
    // pion de la collection sinon faux
    func attack(p : [Piece]) -> Bool

    //capture: Piece x [Piece] -> [Piece]
    // supprime la piece p de pions attaqué et retourne la nouvelle collection
    // Pre : prend une collection du plateau
    func capture(pions : [Piece]) ->[Piece]

}


//Type Abstrait : Card

protocol Card {

    // init : -> Card
    // initialise une carte, son nom, sa couleur (bleu ou rouge), ces déplacements. Les déplacements d'une
    // carte sont représenter par une collection de (IntxInt). Pour tous couples de la
    // collection (x,y) x et y sont des entiers relatif ]-5,5[.
	//Taille de moves compris entre 2 et 4.
    init(name : String, color : String, moves : [(Int, Int)])

    // name : Card -> Text
    // retourne le nom de la carte donnée en String
    var name : String { get }

    // color : Card -> Text
    // retourne la couleur de la carte donnée en String
    var color : String { get }

    // moves : Card -> [(Int x Int)] 
    // renvoie l'ensemble des déplacements possibles qu'offre la carte donnée dans une
    // collection de (Int x Int) qui represente le déplacement sur x et sur y
    // pour tous couples (x,y), x et y sont des entiers relatifs compris entre ]-5,5[ 
    var moves : [(Int , Int)] { get }

}


//Type Abstrait : Player

protocol Player {
    // init : String x [Piece] x [Card]-> Player
    // initialise un joueur : 
    // - sa couleur : bleu ou rouge, 
    // - ses pions : un joueur possede une collection de pions,
    // - ses cartes : un joueur possede une collection de cartes,
    // isWinner initialisé a false
    init (color : String, pieces : [Piece], cards : [Card])

    // color : Player -> Text
    // retourne la couleur d'un joueur donné dans le jeu en rouge et bleu
    var color : String { get }

    // pieces : Player -> [Piece]
    // collection de pions du joueur contenant 4 pions et 1 pion Maître toujours placé en tête de la collection (premier élément) au cours de la partie sa taille varie entre [1,5]
    // Precondition : pour le set, la taille de pieces doit etre comprise entre 0 et 5 et peut contenir soit 1 soit aucun pion avec la propriete isMaster a vraie   
    var pieces : [Piece] { get set }

    // cards : Player -> [Card]
    // collection de type Card contenant les cartes du joueur 
    //Precondition : pour le set, la taille de cards doit etre egale a 2 et peut contenir uniquement 2 cartes parmi les 5 tirees lors de l'initialisation du Board
    var cards : [Card] { get set}

    // isKingKilled : Player -> Bool
    // verifie si le pion Maître du joueur n'a pas été capturé par le joueur adverse
    // pre : pour un joueur 
    // post : retourne vrai si le pions Maître n'est pas dans la collection pieces du
    // joueur sinon retourne faux
    func isKingKilled () -> Bool

    // isWinner : Player -> Bool
    // permet de tester si le joueur a gagne
    // vrai si son pion Maitre est sur le Temple de la couleur opposée ou si isKingKilled
    // du joueur adverse sinon faux
    // Precondition : pour le set, peut prend soit vrai soit faux d'apres le fonctionnement decrit ci-dessus
    var isWinner : Bool { get set }
}

//Type Abstrait : Deck

protocol Deck {
    // init : [Card] -> Deck
    // initialise un paquet de 16 cartes
    init ()

    // cards : Deck -> [Card] 
    // retourne les cartes du deck  
    var cards : [Card] { get }

    //schuffle : Deck -> Deck
    // mélange les cartes aléatoirement
    mutating func shuffle ()

    // pick : Deck -> Deck x Card
    // pre : prend un deck non vide
    // post : tire une carte du paquet au hasard, la supprime du deck et la retourne
    mutating func pick () -> Card 

}

//Type Abstrait : Temple

protocol Temple {
    // init : -> Temple
    // initialise un temple
    // pre : prend une couleur c : rouge ou bleu
    // post : créer le temple de couleur c. Si c = rouge alors x = 0, y = 2
    // sinon x = 4 et y = 2
    init (color : String)

    // x : Temple -> Int
    // retourne la position x du temple donné
    var x : Int { get }
    
    // y : Temple -> Int
    // retourne la position y du temple donné
    var y : Int { get }
    
    // color : Temple -> Text
    // renvoie la couleur d'un temple
    var color : String { get }

    // isOpponentKingOnTemple : Temple x Player -> Bool
    // renvoie pour un joueur si le pion roi de son adversaire est sur son temple
    func isOpponentKingOnTemple (j : Player) -> Bool
}
