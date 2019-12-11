protocol Piece {
	var forme : String { get } //Permet de récuperer la forme de la piece 
	
	var couleur : String { get } //Permet de récuperer la couleur de la piece 

	var joueur : Joueur { get } //Permet de récupérer le joueur qui possede la piece

	init(forme : String, couleur : String, joueur : Joueur) //une piece est definie par un sa forme (string) et sa couleur (string)

	func setLotDePieces (j : Joueur) ->  [Piece]  //attribue a un joueur les pieces pour démarrer (deux cylindre, deux carrés, deux spheres et deux pyramides) sous forme de liste. Recupere le numéro du joueur pour savoir quelle couleur attribuer aux pieces  
}

protocol Joueur {
	var numero : Int { get } //Recupere le numéro du joueur 

	var description : String {get} //Renvoie la liste des pieces dispo pour le joueur sous forme de String

	var pieces : [Piece] { get set } //Renvoi l'ensemble des pieces non jouées par le joueur et appartenant a ce joueur. Taille maximum 8. Contient le retour de set

 	init(numero : Int) //Un joueur est definit par un numéro de joueur et un lot de pieces, la fonction init fait donc appel a SetLotDePieces. Le joueur 1 aura automatiquement les blancs et le 2 les rouges.

 	mutating func SupprimerPiece (p : Piece)  //Supprime la piece du lot de piece du joueur

 	func PossedePiece (p : Piece)  //Verifie si le joueur possede la piece
}

protocol Plateau {
	init () //Un plateau est un tableau (de taille 3)  de tableaux (de taille 3) de types Piece ou nul. Il est initialisé entierement à nul. On repere une position dans le tableau grace a une liste de 2 int, le premier donne la colonne et le deuxieme la ligne.

	func PositionsPieces () -> [(Int, Int)]  //Renvoie l'ensemble des positions où il y a une piece 

	func QuellePiece (position : (Int,Int)) -> Piece?  //Renvoie le type et la couleur de la piece pour une position donnée, renvoie nul si vide

	mutating func place (position : (Int, Int)) -> Bool //Verifie si le joueur peut placer la piece c'est a dire :les fonctions estVidePos, Pcolonne, Psection et Pligne renvoient true et la fonction PossedePiece renvoie true. Si tout ca est possible, modifie le plateau et place la piece a la position donnée. Renvoie false et ne modifie rien sinon.

	func estVidePos (position : (Int,Int)) -> Bool //Renvoie true si la position selectionée est vide

	func Pcolonne (position : (Int, Int)) -> Bool //Si il y a une piece de couleur differente et de meme forme dans la colonne renvoie false, true sinon

	func Pligne (position : (Int, Int)) -> Bool //Si il y a une piece de couleur differente et de meme forme dans la ligne renvoie false, true sinon

	func Pzone (position : (Int, Int)) -> Bool //Si il y a une piece de couleur differente et de meme forme dans la zone (il y a 4 zone, c'est un carré de 2*2) renvoie false, true sinon

	func peutJouer (j : Joueur) -> Bool //Verifie les pieces disponibles du joueur et si il peut en placer au moins une, revoie true, false sinon

	func aGagne() -> Bool //Si Gcolonne ou Gligne ou Gzone renvoient true ou peutJouer de l'adversaire renvoie false, aGagne revoie true, false sinon

	func Gcolonne (position : (Int, Int)) -> Bool //Si il ya a 4 pieces de forme differentes dans la colonne, renvoie true, false sinon

	func Gligne (position : (Int, Int)) -> Bool //Si il ya a 4 pieces de forme differentes dans la ligne, renvoie true, false sinon	

	func Gzone (position : (Int, Int)) -> Bool //Si il ya a 4 pieces de forme differentes dans la zone, renvoie true, false sinon
}