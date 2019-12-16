// Type PIECE

// Specification fonctionnelle du type PIECE

protocol TPiece {
    
    
    
    //Permet de récuperer la forme de la piece
    
    var forme : String { get }
    
    
    
    //Permet de récuperer la couleur de la piece
    
    var couleur : String { get }
    
    
    
    //une piece est definie par un sa forme (string) et sa couleur (string)
    
    init(forme : String, couleur : String)
    
}


// Structure de donnees du type PIECE

struct Piece : TPiece{
    
    
    
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

protocol TJoueur {
    
    
    
    //Recupere le numéro du joueur
    
    var numero : Int { get }
    
    
    
    //Renvoie la liste des pieces dispo pour le joueur sous forme de String
    
    //var description : String { get }
    
    
    
    //Renvoie la liste des pieces dispo pour le joueur sous forme de tableau
    
    var pieces : [Piece] { get set }
    
    
    
    //Un joueur est definit par un numéro de joueur et un lot de pieces, la fonction init fait donc appel a SetLotDePieces. Le joueur 1 aura automatiquement les blancs et le 2 les rouges.
    
    init(numero : Int)
    
    
    
    //Supprime la piece du lot de piece du joueur
    
    mutating func SupprimerPiece (p : Piece)
    
    
    
    //Verifie si le joueur possede la piece
    
    func PossedePiece (p : Piece) -> Bool
    
    
    
    //attribue a un joueur les pieces pour démarrer (deux cylindre, deux carrés, deux spheres et deux pyramides) sous forme de liste. Recupere le numéro du joueur pour savoir quelle couleur attribuer aux pieces
    
    func setLotDePieces () -> [Piece]
    
}


// Structure de donnees du type JOUEUR

struct Joueur : TJoueur {
    
    
    
    private(set) var numero : Int  // declaration de la propriete numero pour un joueur
    
    //private(set) var description : String  // declaration de la propriete description pour un pion
    
    var pieces : [Piece]  // declaration de la propriete pieces pour un pion
    
    
    
    
    
    init(numero : Int){ // initialisation d'un joueur qui a un numero et une description
        
        self.numero = numero
        
        
        
        self.pieces = []
        
        if self.numero == 1 {
            
            self.pieces.append(Piece(forme : "Cylindre", couleur : "blanc") )
            
            self.pieces.append(Piece(forme : "Cylindre", couleur : "blanc"))
            
            self.pieces.append(Piece(forme : "Carre", couleur : "blanc"))
            
            self.pieces.append(Piece(forme : "Carre", couleur : "blanc"))
            
            self.pieces.append(Piece(forme : "Sphere", couleur : "blanc"))
            
            self.pieces.append(Piece(forme : "Sphere", couleur : "blanc"))
            
            self.pieces.append(Piece(forme : "Pyramide", couleur : "blanc"))
            
            self.pieces.append(Piece(forme : "Pyramide", couleur : "blanc"))
            
            
            
        } else if self.numero == 2 {
            
            self.pieces.append(Piece(forme : "Cylindre", couleur : "rouge") )
            
            self.pieces.append(Piece(forme : "Cylindre", couleur : "rouge"))
            
            self.pieces.append(Piece(forme : "Carre", couleur : "rouge"))
            
            self.pieces.append(Piece(forme : "Carre", couleur : "rouge"))
            
            self.pieces.append(Piece(forme : "Sphere", couleur : "rouge"))
            
            self.pieces.append(Piece(forme : "Sphere", couleur : "rouge"))
            
            self.pieces.append(Piece(forme : "Pyramide", couleur : "rouge"))
            
            self.pieces.append(Piece(forme : "Pyramide", couleur : "rouge"))
            
            
            
        }
        
    }
    
    
    
    mutating func SupprimerPiece (p : Piece){
        
        if !self.pieces.isEmpty{
            
            if self.PossedePiece(p : p) {
                
                var newlotdePiece : [Piece] = self.pieces
                
                var index : Int = 0
                
                var suppr = false
                
                while index < self.pieces.count && suppr == false {
                    
                    if self.pieces[index].forme == p.forme && self.pieces[index].couleur == p.couleur{
                        
                        self.pieces.remove(at: index)
                        
                        suppr = true
                        
                    }
                    
                    index = index + 1
                    
                }
                
            }
            
        }
        
    }
    
    
    
    
    
    func PossedePiece (p : Piece) -> Bool {
        
        var ok : Bool = false
        
        if !self.pieces.isEmpty {
            
            var i : Int = 0
            
            while i < self.pieces.count && ok == false{
                
                if p.couleur == self.pieces[i].couleur && p.forme == self.pieces[i].forme {
                    
                    ok = true
                    
                }
                
                i = i + 1
                
            }
            
        }
        
        return ok
        
    }
    
    
    
    // Fonction initialement dans Piece mais deplacee dans Joueur car on doit pouvoir ajouter des pieces au joueur. De plus
    
    // modifie le joueur donc concerne le joueur il est donc plu logique de la placer ici.
    
    func setLotDePieces () -> [Piece] {
        
        //attribue a un joueur les pieces pour démarrer (deux cylindre, deux carrés, deux spheres et deux pyramides) sous forme de liste. Recupere le numéro du joueur pour savoir quelle couleur attribuer aux pieces
        
        var lotdePiece : [Piece] = []
        
        if self.numero == 1 {
            
            lotdePiece.append(Piece(forme : "Cylindre", couleur : "blanc") )
            
            lotdePiece.append(Piece(forme : "Cylindre", couleur : "blanc"))
            
            lotdePiece.append(Piece(forme : "Carre", couleur : "blanc"))
            
            lotdePiece.append(Piece(forme : "Carre", couleur : "blanc"))
            
            lotdePiece.append(Piece(forme : "Sphere", couleur : "blanc"))
            
            lotdePiece.append(Piece(forme : "Sphere", couleur : "blanc"))
            
            lotdePiece.append(Piece(forme : "Pyramide", couleur : "blanc"))
            
            lotdePiece.append(Piece(forme : "Pyramide", couleur : "blanc"))
            
            
            
        } else if self.numero == 2 {
            
            lotdePiece.append(Piece(forme : "Cylindre", couleur : "rouge") )
            
            lotdePiece.append(Piece(forme : "Cylindre", couleur : "rouge"))
            
            lotdePiece.append(Piece(forme : "Carre", couleur : "rouge"))
            
            lotdePiece.append(Piece(forme : "Carre", couleur : "rouge"))
            
            lotdePiece.append(Piece(forme : "Sphere", couleur : "rouge"))
            
            lotdePiece.append(Piece(forme : "Sphere", couleur : "rouge"))
            
            lotdePiece.append(Piece(forme : "Pyramide", couleur : "rouge"))
            
            lotdePiece.append(Piece(forme : "Pyramide", couleur : "rouge"))
            
            
            
        }
        
        return lotdePiece
        
    }
    
    
    
}

//Type PLATEAU

// Specification fonctionnelle du type PLATEAU

protocol TPlateau {
    
    
    
    //Un plateau est un tableau (de taille 3) de tableaux (de taille 3) de types Piece ou nul.
    
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
    
    func aGagne(position : (Int,Int), j_adverse : Joueur) -> Bool
    
    
    
    //Si il ya a 4 pieces de forme differentes dans la colonne, renvoie
    
    //true, false sinon
    
    func Gcolonne (position : (Int, Int)) -> Bool
    
    
    
    //Si il ya a 4 pieces de forme differentes dans la ligne,
    
    //renvoie true, false sinon
    
    func Gligne (position : (Int, Int)) -> Bool
    
    
    
    //Si il ya a 4 pieces de forme differentes dans la zone,
    
    //renvoie true, false sinon
    
    func Gzone (position : (Int, Int)) -> Bool
    
}


struct Plateau : TPlateau {
    
    
    
    private var grid : [[Piece?]]
    
    
    
    init() {
        
        // tableau de taille 4 pas de taille 3 On peut faire comme on veut il ne faut pas imposer un tableau.
        
        // Specification modifiee pour la taille du plateau de 3 a 4
        
        self.grid = [[Piece?]](repeating: [Piece?](repeating: nil, count: 4), count: 4)
        
    }
    
    
    
    // On a choisit de renvoyer un tableau vide si le plateau ne contient aucune Piece
    
    // Warning : jamais utilisee
    
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
    
    // Warning : jamais utilisee
    
    func QuellePiece(position : (Int,Int)) -> Piece? {
        
        if estVidePos(position : position) {
            
            return nil
            
        }
            
        else {
            
            return self.grid[position.0][position.1]
            
        }
        
    }
    
    
    
    mutating func place (position : (Int, Int), piece : Piece, joueur : Joueur) -> Bool {
        
        if estVidePos(position : position) && Pzone(position : position, p: piece) && Pligne(position : position, p : piece) && Pcolonne(position : position, p : piece) && joueur.PossedePiece(p : piece) {
            
            self.grid[position.0][position.1] = piece
            
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
        
        // colonne testee
        
        let c : Int = position.1
        
        // Forme et couleur de la piece testee
        
        let pforme : String = p.forme
        
        let pcolor : String = p.couleur
        
        for i in 0 ..< 4 {
            
            if let x = self.grid[i][c], x != nil {
                
                if x.couleur != pcolor && x.forme == pforme {
                    
                    ok = false
                    
                }
                
            }
            
            //DEMANDER AU PROF
            
            //if !self.estVidePos(position : position) {
            
            
            
            //}
            
        }
        
        // Si la couleur et la forme de la piece sont les memes que celle d'une autre piece dans la colonne retourne false
        
        return ok
        
    }
    
    
    
    func Pligne (position : (Int, Int), p : Piece) -> Bool{
        
        var ok : Bool = true
        
        // ligne testee
        
        let l : Int = position.0
        
        // forme et couleur de la piece testee
        
        let pforme : String = p.forme
        
        let pcolor : String = p.couleur
        
        for j in 0 ..< 4 {
            
            if let x = self.grid[l][j], x != nil {
                
                if x.couleur != pcolor && x.forme == pforme {
                    
                    ok = false
                    
                }
                
            }
            
            //if !self.estVidePos(position : position)  {
            
            //}
            
        }
        
        // Si la couleur et la forme de la piece sont les memes que celle d'une autre piece dans la ligne retourne false
        
        return ok
        
    }
    
    
    
    func Pzone (position : (Int, Int), p : Piece) -> Bool {
        
        var ok : Bool = true
        
        var x : Int = position.0
        
        var y : Int = position.1
        
        x = x - x%2 //on se place a l'abscisse de debut de zone
        
        y = y - y%2 // on se place a l'ordonnee de debut de zone
        
        // forme et couleur de la piece teste
        
        let pforme : String = p.forme
        
        let pcolor : String = p.couleur
        
        // abscisse et ordonnee de fin de parcour de la zone
        
        let endX : Int = x + 2
        
        let endY : Int = y + 2
        
        
        
        for i in x ..< endX {
            
            for j in y ..< endY {
                
                if let x = self.grid[i][j], x != nil {
                    
                    if x.couleur != pcolor && x.forme == pforme {
                        
                        ok = false
                        
                    }
                    
                }
                
                //if !self.estVidePos(position : (i,j)) {
                
                
                
                //}
                
            }
            
        }
        
        // Si la couleur et la forme de la piece sont les memes que celle d'une autre piece dans la zone retourne false
        
        return ok
        
    }
    
    
    
    func peutJouer (j : Joueur) -> Bool {
        
        var ok : Bool = false
        
        while ok == false{
            
            for pion in j.pieces {
                
                for x in 0 ..< 4{
                    
                    for y in 0 ..< 4{
                        
                        if Pligne (position : (x, y), p : pion) && Pcolonne (position : (x, y), p : pion) && Pzone (position : (x, y), p : pion) {
                            
                            ok = true
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        return ok
        
    }
    
    
    
    // Ajout de position car sinon il nous manque le parmaetre position pour les fonctions Gzone
    
    // Gligne et Gcolonne.
    
    // Ajout de j_adverse sinon on peut pas tester si le joueur adverse ne peut pas jouer.
    
    func aGagne(position : (Int,Int), j_adverse : Joueur) -> Bool {
        
        // Si le joueur gagne sur une ligne ou colonne ou zone ou que son adversaire ne peut plus jouer alorson retourne vrai
        
        return Gzone(position : position) || Gligne(position : position) || Gzone(position : position) || !peutJouer(j : j_adverse)
        
    }
    
    
    
    // si tous on a la valeur 1 pour chaque cle du dictionnaire declare ci-dessous alors on retourne vrai sinon faux
    
    func Gcolonne(position : (Int,Int)) -> Bool {
        
        var ok : Bool = true
        
        let c : Int = position.1
        
        // d va contenir les occurences des formes dans la colonne
        
        var d : [String : Int] = ["Carre" : 0,"Cylindre" : 0 , "Sphere" : 0,"Pyramide" : 0]
        
        for i in 0 ..< 4 {
            
            if let x = self.grid[i][c], x != nil {
                
                var f : String = x.forme
                
                if let z = d[f], type(of: z) == Int.self {
                    
                    var u : Int = z + 1
                    
                    d[f] = u
                    
                }
                
            }
            
            //if !self.estVidePos(position : (i,c)) {
            
            //DEMANDER AU PROF
            
            //}
            
        }
        
        for (k,v) in d {
            
            if (v != 1){
                
                ok = false
                
            }
            
        }
        
        return ok
        
    }
    
    
    
    func Gligne(position : (Int,Int)) -> Bool {
        
        var ok : Bool = true
        
        let l : Int = position.0
        
        var d : [String : Int] = ["Carre": 0,"Cylindre": 0 , "Sphere": 0,"Pyramide": 0]
        
        for j in 0 ..< 4 {
            
            if let x = self.grid[l][j], x != nil {
                
                var f : String = x.forme
                
                if let z = d[f], type(of: z) == Int.self {
                    
                    var u : Int = z + 1
                    
                    d[f] = u
                    
                }
                
            }
            
            //if !self.estVidePos(position : (l,j)) {
            
            //var f : String = self.grid[l][j].forme
            
            //d[f] = d[f] + 1
            
            //}
            
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
        
        x = x - x%2 //on se place a l'abscisse de debut de zone
        
        y = y - y%2 // on se place a l'ordonnee de debut de zone
        
        // abscisse et ordonnee de fin de parcour de la zone
        
        let endX : Int = x + 2
        
        let endY : Int = y + 2
        
        
        
        var d : [String : Int] = ["Carre": 0,"Cylindre": 0 , "Sphere": 0,"Pyramide": 0]
        
        
        
        for i in x ..< endX {
            
            for j in y ..< endY {
                
                if let x = self.grid[i][j], x != nil {
                    
                    var f : String = x.forme
                    
                    if let z = d[f], type(of: z) == Int.self {
                        
                        var u : Int = z + 1
                        
                        d[f] = u
                        
                    }
                    
                }
                
                //if !self.estVidePos(position : (i,j)) {
                
                //var f : String = self.grid[i][j].forme
                
                //d[f] = d[f] + 1
                
                //}
                
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

