// Type PIECE
// Specification fonctionnelle du type PIECE
protocol Piece {
    
    //Permet de récuperer la forme de la piece
    var forme : String { get }
    
    //Permet de récuperer la couleur de la piece
    var couleur : String { get }
    
    //une piece est definie par un sa forme (string) et sa couleur (string)
    init(forme : String, couleur : String)
}


// Structure de donnees du type PIECE
struct Piece : Piece{
    
    // declaration de la propriete forme pour un pion
    private(set) var forme : String
    
    // declaration de la propriete couleur pour un pion
    private(set) var couleur : String
    
    // initialisation d'un pion qui a une forme et une couleur
    init(forme : String, couleur : String) {
        self.forme = forme
        self.couleur = couleur
    }
}

// Type JOUEUR
// Specification fonctionnelle du type JOUEUR
protocol Joueur {
    
    //Recupere le numéro du joueur
    var numero : Int { get }
    
    //Renvoie la liste des pieces dispo pour le joueur sous forme de String
    var description : String { get }
    
    //Renvoie la liste des pieces dispo pour le joueur sous forme de tableau
    var pieces : [Piece] { get set }
    
    //Un joueur est definit par un numéro de joueur et un lot de pieces, la fonction init fait donc appel a SetLotDePieces. Le joueur 1 aura automatiquement les blancs et le 2 les rouges.
    init(numero : Int ,description : String, pieces : [Piece])
    
    //Supprime la piece du lot de piece du joueur
    mutating func SupprimerPiece (p : Piece)
    
    //Verifie si le joueur possede la piece
    func PossedePiece (p : Piece) -> Bool
    
    //attribue a un joueur les pieces pour démarrer (deux cylindre, deux carrés, deux spheres et deux pyramides) sous forme de liste. Recupere le numéro du joueur pour savoir quelle couleur attribuer aux pieces
    func setLotDePieces () ->  [Piece]
}

// Structure de donnees du type JOUEUR
struct Joueur : Joueur {
    private(set) var numero : Int  // declaration de la propriete numero pour un joueur
    private(set) var description : String  // declaration de la propriete description pour un pion
    private(set) var pieces : [Piece]  // declaration de la propriete pieces pour un pion
    
    
    init(numero : Int,description : String){ // initialisation d'un joueur qui a un numero et une description
        self.numero = numero
        self.description = description
        self.pieces = pieces
    }

    private func getIndex (pieces : [Piece], p : Piece){
        // fonction utilitaire pour la fonction SupprimerPiece()
        // permet d'obtenir l'indice de la piece a supprimer
        if (nbOccurence (pieces : pieces, p : p)) > 0 {
            for (i in 0..< pieces.count){
                if pieces[i] == p {
                    return i
                }
            }
        }
    }
    
    mutating func SupprimerPiece (p : Piece){
        if self.PossedePiece(p : p) {
            self.pieces = self.pieces.remove(at : getIndex (pieces : self.pieces, p : p) )
        }
    }
    
    
    
    private func nbOccurence (pieces : [Piece], p : Piece) -> Int {
        //fonction utilitaire pour la fonction PossedePiece()
        // compte le nombre d'occurences de la piece passee en parametre dans l'ensemble des pieces
        var resultat : Int = 0
        for (i in 0..< pieces.count){
            if pieces[i] == piece {
                resultat = resultat + 1
            }
        }
        return resultat
    }
    
    func PossedePiece (p : Piece) {
        return (nbOccurence (pieces : self.pieces, p : p)) > 0
    }
    
    func setLotDePieces () ->  [Piece]{
      //attribue a un joueur les pieces pour démarrer (deux cylindre, deux carrés, deux spheres et deux pyramides) sous forme de liste. Recupere le numéro du joueur pour savoir quelle couleur attribuer aux pieces
        if self.numero == 1 {
            self.pieces = self.pieces.append(Piece(forme : "Cylindre", couleur : "blanc") )
            self.pieces = self.pieces.append(Piece(forme : "Cylindre", couleur : "blanc"))
            self.pieces = self.pieces.append(Piece(forme : "Carre", couleur : "blanc"))
            self.pieces = self.pieces.append(Piece(forme : "Carre", couleur : "blanc"))
            self.pieces = self.pieces.append(Piece(forme : "Sphere", couleur : "blanc"))
            self.pieces = self.pieces.append(Piece(forme : "Sphere", couleur : "blanc"))
            self.pieces = self.pieces.append(Piece(forme : "Pyramide", couleur : "blanc"))
            self.pieces = self.pieces.append(Piece(forme : "Pyramide", couleur : "blanc"))
            
        } else if self.numero == 2 {
            self.pieces = self.pieces.append(Piece(forme : "Cylindre", couleur : "rouge") )
            self.pieces = self.pieces.append(Piece(forme : "Cylindre", couleur : "rouge"))
            self.pieces = self.pieces.append(Piece(forme : "Carre", couleur : "rouge"))
            self.pieces = self.pieces.append(Piece(forme : "Carre", couleur : "rouge"))
            self.pieces = self.pieces.append(Piece(forme : "Sphere", couleur : "rouge"))
            self.pieces = self.pieces.append(Piece(forme : "Sphere", couleur : "rouge"))
            self.pieces = self.pieces.append(Piece(forme : "Pyramide", couleur : "rouge"))
            self.pieces = self.pieces.append(Piece(forme : "Pyramide", couleur : "rouge"))
            
        }
        
        return self.pieces
    }
    
}
//Type PLATEAU
// Specification fonctionnelle du type PLATEAU
protocol Plateau {
    
    //Un plateau est un tableau (de taille 3  /NON : 4) de tableaux (de taille 3 /NON: 4) de types Piece ou nul.
    //Il est initialisé entierement à nul. On repere une position dans le tableau grace a une
    //liste de 2 int, le premier donne la colonne et le deuxieme la ligne.
    init ()
    
    //Renvoie l'ensemble des positions où il y a une piece
    func PositionsPieces () -> [(Int, Int)]
    
    //Renvoie le type et la couleur de la piece pour une position donnée, renvoie nul si vide
    func QuellePiece (position : (Int,Int)) -> Piece?
    
    //Verifie si le joueur peut placer la piece c'est a dire :les fonctions estVidePos, Pcolonne, Psection et Pligne
    // renvoient true et la fonction PossedePiece renvoie true. Si tout ca est possible, modifie le plateau et place
    // la piece a la position donnée. Renvoie false et ne modifie rien sinon.
    mutating func place (position : (Int, Int), piece : Piece, joueur : Joueur) -> Bool
    
    //Renvoie true si la position selectionée est vide
    func estVidePos (position : (Int,Int)) -> Bool
    
    //Si il y a une piece de couleur differente et de meme forme dans
    //la colonne renvoie false, true sinon
    func Pcolonne (position : (Int, Int), p : Piece) -> Bool
    
    //Si il y a une piece de couleur differente et de meme forme dans la ligne
    //renvoie false, true sinon
    func Pligne (position : (Int, Int), p : Piece) -> Bool
    
    //Si il y a une piece de couleur differente et de meme forme dans la zone
    //(il y a 4 zone, c'est un carré de 2*2) renvoie false, true sinon
    func Pzone (position : (Int, Int), p : Piece) -> Bool
    
    //Verifie les pieces disponibles du joueur et si il peut en placer
    //au moins une, revoie true, false sinon
    func peutJouer (j : Joueur) -> Bool
    
    //Si Gcolonne ou Gligne ou Gzone renvoient true ou peutJouer de
    //l'adversaire renvoie false, aGagne revoie true, false sinon
    func aGagne(j_adverse : Joueur) -> Bool
    
    //Si il ya a 4 pieces de forme differentes dans la colonne, renvoie
    //true, false sinon
    func Gcolonne (position : (Int, Int), p : Piece) -> Bool
    
    //Si il ya a 4 pieces de forme differentes dans la ligne,
    //renvoie true, false sinon
    func Gligne (position : (Int, Int), p : Piece) -> Bool
    
    //Si il ya a 4 pieces de forme differentes dans la zone,
    //renvoie true, false sinon
    func Gzone (position : (Int, Int), p : Piece) -> Bool
}

struct Plateau : Plateau {
    
    private var grid : [[Piece?]]
    
    init() {
        // tableau de taille 4 pas de taille 3 On peut faire comme on veut il ne faut pas imposer un tableau
        self.grid = [Piece?](repeating : [Piece?](repeating : nil, count : 4), count : 4)
    }
    
    func PositionsPieces () -> [(Int,Int)] {
        var posPieces : [(Int,Int)] = []
        for i in 0 ..< 4 {
            for j in 0 ..< 4 {
                if !estVidePos(position : (i,j)) {
                    posPieces.append((i,j))
                }
            }
        }
        return posPieces
    }
    
    //Selon votre sepcification ont doit renvoyer une Piece ou nul mais en commentaire vous dites qu'il faut renvoyer la couleur et le type. On a choisit de renvoyer la piece
    // Faut choisir
    // Ne sert a rien jamais utilisee
    func QuellePiece(position : (Int,Int)) -> Piece? {
        if estVidePos(position : position) {
            return nil
        }
        else {
            return self.grid[position.0][position.1]
        }
    }
    
        //Peutjouer() ou place() il faut choisir ou faire la verification. Ca ne sert a rien de faire 2 fois
    mutating func place (position : (Int, Int), piece : Piece, joueur : Joueur) -> Bool {
        if estVidePos(position : position) && Pzone(position : position) && Pligne(postion : position) && Pcolonne(position : position) && j.PossedePiece(p : piece) {
            self.grid[postion.0][position.1] = piece
            return true
        }
        else {
            return false
        }
    }
        
    
    func estVidePos(position : (Int,Int)) -> Bool {
        return self.grid[position.0][position.1] == nil
    }
    
    func Pcolonne (position : (Int, Int), p : Piece) -> Bool {
        var ok : Bool = true
        let c : Int = position.1
        let pforme : String = p.forme
        let pcolor : String = p.couleur
        for i in 0 ..< 4 {
            if !estVidePos(position : position) {
                if self.grid[i][c].couleur == pcolor && self.grid[i][c].forme == pforme {
                    ok = false
                }
            }
        }
        return ok
    }
    
    func Pligne (position : (Int, Int), p : Piece) -> Bool{
        var ok : Bool = true
        let l : Int = position.0
        let pforme : String = p.forme
        let pcolor : String = p.couleur
        for j in 0 ..< 4 {
            if !estVidePos(position : position)  {
                if (self.grid[l][j].couleur == pcolor && self.grid[l][j].forme == pforme){
                    ok = false
                }
            }
        }
        return ok
    }
    
    func Pzone (position : (Int, Int), p : Piece) -> Bool {
        
    }
    //Verifie les pieces disponibles du joueur et si il peut en placer
    //au moins une, revoie true, false sinon
    func peutJouer (j : Joueur) -> Bool {
    
    }
    
    func aGagne() -> Bool {
        return (Gzone() && Gligne() && Gzone()) || !peutJouer()
    }
    
    func Gcolonne(position : (Int,Int)) -> Bool {
        
    }
    
    func Gligne(position : (Int,Int), p : Piece) -> Bool {
        var ok : Bool = true
        let l : Int = position.0
        var d : [String: Int] = ["Carre": 0,"Cylindre": 0 , "Sphere": 0,"Pyramide": 0]
        for j in 0 ..< 4 {
            if !estVidePos(position : (l,j)) {
                var f : String = self.grid[l][j].forme
                d[f] = d[f] + 1
            }
        }
        
        for (k,v) in d {
            if (v != 1){
                ok = false
            }
        }
        
        return ok
    }
    
    
    func Gzone(position : (Int,Int)) -> Bool {
        var ok : Bool = true
        var x : Int = position.0
        var y : Int = position.1
        x = x - x%2
        y = y - y%2
        
        let endX : Int = x + 2
        let endY : Int = y + 2
        
        var d : [String: Int] = ["Carre": 0,"Cylindre": 0 , "Sphere": 0,"Pyramide": 0]
        
        for i in x ..< endX {
            for j in y ..< endY {
                if !estVidePos(position : (i,j)) {
                    var f : String = self.grid[i][j].forme
                    d[f] = d[f] + 1
                }
            }
        }
        for (k,v) in d {
            if (v != 1){
                ok = false
            }
        }
        return ok
    }
}
