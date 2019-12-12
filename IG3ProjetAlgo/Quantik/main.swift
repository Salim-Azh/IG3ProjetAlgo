func demandePosition() -> (Int,Int) { //fonction qui demande la position à l'utilisateur
	var B : Bool = false
	var C : Bool = false
	var l : Int
	var k : Int
	while B == false {
			print ( "A quelle position en x la mettre ?") // demander la position x à laquelle placer la pièce
			if let xs = readLine() { //On recupère la valeur entrée par l'utilisateur
				if let x = Int(xs){ //On verifie que c'est bien un entier
					if (x == 1 || x == 2 || x == 3 || x == 0){ //la position doit être comprise entre 0 et 3
						B = true
						l = x
					}
				}
			}
			else { 
				print("La position entrée n'est pas valide")	
				 }	
		}
		while C == false {
			print ( "A quelle position en y la mettre ?")
			if let ys = readLine() {
				if let y = Int(ys) {
					if (y == 1 || y == 2 || y == 3 || y == 0){
						C = true
						k = y
					}
				}
			}
			else { 
				print("La position entrée n'est pas valide")	 }
		}
		return (l,k)
}
func demandeForme() -> String { // Fonction qui demande la forme de la pièce à placer à l'utilisateur
	var A : Bool = false 
	var f : String
	while A == false {
			print ("Choisir une pièce à placer entre : Cylindre, Pyramide, Carre, Sphere")
			 let forme : String? = readLine() // Le joueur rentre la pièce qu'il veut placer
			if (forme == "Cylindre" || forme == "Pyramide" || forme == "Carre" || forme == "Sphere "){ // Vérifier si la pièce existe
				A = true // Si la pièce existe on sort du while et on continue, sinon on rentre une autre pièce
				f = forme
			}	else { 
				print("La pièce entrée n'est pas valide")	 }
		}
	return f 
}

//Début main
var plateau : Plateau = Plateau() //Creation plateau 
var Joueur1 : Joueur = Joueur(numero : 1) //Création des joueurs
var Joueur2 : Joueur = Joueur(numero : 2)
var tour : Int  = 0   //Compteur pour savoir qui doit jouer
var fin : Bool = false
var gagnant : Int = 0 //Permettra de savoir quel joueur a gagné

while (fin == false) { // tant qu'il n'y a pas de gagnant
	if (tour % 2 == 0){  // si tour est pair, c'est au joueur 1 de jouer
		print(Joueur1.description) // renvoi la description des pièces du joueur1
		var piece : Piece = (demandeForme(), "blanc") // on crée la pièce que le joueur veut jouer.
		if place(position : demandePosition(), p : piece) == true { //si le joueur a pu placer sa pièce où il voulait
			Joueur1.supprimerPiece(p : piece) //on supprime sa pièce de son lot car il ne pourra plus la jouer
			if aGagne(){  //on vérifie si il a gagné le jeu
				fin = true
				gagnant = 1
			}
			tour += 1
		}
		else{
			print("Vous ne pouvez pas placer votre pièce ici") //on n'incrémente pas tour donc se sera encore au joueur1 de jouer.
		}
	}
	else{  // on refait la même chose pour le joueur 2
		print(Joueur2.description)
		var piece : Piece = (demandeForme(), "rouge")
		if place(position : demandePosition(), p : piece) == true {
			Joueur2.supprimerPiece(p : Piece)
			if aGagne(){
				fin = true
				gagnant = 2
			}
			tour += 1
		}
		else{
			print ("Vous ne pouvez pas placer votre pièce ici")
		}
	}
}

	print ("Le gagnant est le joueur ", gagnant) // affiche le joueur qui a gagné
