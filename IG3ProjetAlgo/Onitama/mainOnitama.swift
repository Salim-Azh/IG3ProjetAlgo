//Programme principal

private func printBoard(game : Board){
    print("Joueur " + game.currentPlayer.color + " a vous de jouer !")
    print("Voici toutes les informations sur le plateau : ")

    /*PIONS*/

    // Affichage des pions de currentPlayer

    print("--- Vos pions : ---")
    var p : [Piece] = game.currentPlayer.pieces
    for i in 0 ..< p.count {
        if i == 0 {
            print(">(\(i))pion Maître en position : \(p[i].position)")
        }
        else {
            print(">(\(i))pion en position \(p[i].position)")
        }
    }
    // Affichage des pions de offPlayer
    print("--- Pions adverses : ---")
    p = game.offPlayer.pieces
    for i in 0 ..< p.count {
        if i == 0{
            print("pion Maître adverse en position : \(p[i].position)")

        }
        else{
            print("pion adverse en position \(p[i].position)")
        }
    }

    /*CARTES*/

    // Affichage les cartes de currentPlayer 

    print("\n--- Vos cartes : ---")
    var c : [Card] = game.currentPlayer.cards
    for i in 0 ..< c.count {
        print( ">(\(i))Carte " + c[i].name + ":")
        var cmoves : [(Int,Int)] = c[i].moves 
        for j in 0 ..< cmoves.count {
            print (cmoves[j])
        }
    }

    // Affichage des cartes de l'adversaire

    print("--- Cartes adverses : ---")
    c = game.offPlayer.cards
    for i in 0 ..< c.count {
        print( "Carte " + c[i].name + ":")
        var cmoves : [(Int,Int)] = c[i].moves 
        for j in 0 ..< cmoves.count {
            print (cmoves[j])
        }
    }

    // Affichage de la carte en StandBy

    var sc : Card = game.standbyCard
    print("\nLa carte en attente est " + sc.name + ", ses déplacements sont : ")
    var scMoves : [(Int,Int)] = sc.moves 
    for j in 0 ..< scMoves.count {
        print(scMoves[j])
    }
}

private func printPossibleMoves(game : Board, pion : Piece, carte : Card){
    var pm : [(Int,Int)] = game.possibleMoves(pion: pion, card: carte)
    var i : Int = 0
    print("Mouvement(s) possible(s) : ")
    for elt in pm {
        print(">\(i) : \(elt)")
        i = i + 1
    }
}


private func inputCardIndex() -> Int{
	while true{
		print("Choisissez une carte. Entrez le numéro entre parenthèses")
		print("ex : >(1)Carte Dragon : ...\n Pour choisir cette carte entrez 1")
        //le joueur renseigne l'indice de la carte qu'il souhaite utiliser dans sa collection de cartes "cards"
        guard let inputCard = readLine(), let c = Int(inputCard), c < 2 && c >= 0 
            else {
            	print("Invalid input")
                continue
            }
        return c
	}
}


private func inputPieceIndex() -> Int{
	while true{
		print("Choisissez un pion : ")
        print("Entrez le numéro entre parenthèses ex : >(3)pion en position (3,2)\nPour choisir ce pion entrez 3")
        //le joueur renseigne l'indice du pion qu'il souhaite deplacer dans sa collection de pion "pieces"
        guard let inputPiece = readLine(), let p = Int(inputPiece), p < 5 && p >= 0 
            else {
            	print("Invalid input")
                continue
            }
         return p
	}
}


private func inputDeplacementIndex(possibleMoves : [(Int,Int)]) -> Int{
	while true{
		print("Choisissez un déplacement :")
		print("Entrez le numéro entre parenthèses ex : >(1) : (2,1)\nPour choisir ce déplacement entrez 1")
        //le joueur renseigne l'indice du deplacement qu'il souhaite utiliser parmi ceux possibles
        //nombre de deplacements possibles
        guard let inputDepl = readLine(), let d = Int(inputDepl), d < possibleMoves.count && d >= 0 
        else {
            print("Invalid input")
            continue
        }
        return d
	}
}

func main(){

    var game : Board = Board() // initialisation du plateau de jeu

    while !game.endGame() {
        /* Interface utilisateur */
        printBoard(game : game) //Affiche le plateau de jeu a l'utilisateur

        /*Choix du pion*/
        var p : Int = inputPieceIndex()

        /*Choix de la carte*/
        var c : Int = inputCardIndex()

        //Recuperation des positions qui peuvent etre atteinte par le pion selectedPiece avec la carte selectedCard 
        game.selectedCard = game.currentPlayer.cards[c]
        game.selectedPiece = game.currentPlayer.pieces[p]

        //Interface utilisateur
        printPossibleMoves(game : game, pion : game.selectedPiece, carte : game.selectedCard)

        /*Choix du deplacement*/
        var possibleMoves : [(Int,Int)] = game.possibleMoves(pion: game.selectedPiece, card: game.selectedCard)
        var d : Int  = inputDeplacementIndex(possibleMoves : possibleMoves) 

        // collection contenant les deplacements possibles
        var mv : (Int,Int) = possibleMoves[d] //le mouvement choisit
        /*Deplacement*/
        game.movePiece(pion: game.selectedPiece, moves: mv) //modification de x et y de selectedPiece par mv 
        /*Attaque*/
        if game.selectedPiece.attack(p: game.offPlayer.pieces) { //vrai si le pion selectedPiece est sur la meme case qu'un pion adverse, ce qui signifie que selectedPiece attaque
            game.offPlayer.pieces = game.selectedPiece.capture(pions: game.offPlayer.pieces)
        }
        /*Changement de carte*/
        game.switchCard(carte1: game.currentPlayer.cards[c], carte2: game.standbyCard)
        /*Fin du tour*/
        if game.offPlayer.isKingKilled() {
            game.currentPlayer.isWinner = true
        }
        else if game.redTemple.isOpponentKingOnTemple(j : currentPlayer) && game.currentPlayer.color == "blue" {
            game.currentPlayer.isWinner = true
        }
        else if game.blueTemple.isOpponentKingOnTemple(j : currentPlayer) && game.currentPlayer.color == "red" {
            game.currentPlayer.isWinner = true
        }

        else{
            var tmp : Player = game.currentPlayer
            game.currentPlayer = game.offPlayer
            game.offPlayer = tmp
        }
    }

    /*Test de fin de partie*/
    if game.currentPlayer.isWinner {
        print("Joueur " + game.currentPlayer.color + " a gagne !")
        print("Fin de partie")
        return
    }
    // si on est sortir du while sans que currentPlayer est gagne alors il s'est produit une erreur
    else{
        print("Erreur")
        return
    }
}