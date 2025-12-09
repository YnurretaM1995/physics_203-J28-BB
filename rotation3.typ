#import "@preview/theorion:0.4.1": *
#import cosmos.rainbow: *
#show: show-theorion

#set document(
  author: ("Richard Rispoli"),
  title: [Physique de la Rotation : Mécanique du Solide]
)

#show title: set align(right)
#show title: set block(below: 1.2em)
#show title: set text(
  weight: "bold", 
  size: 1em, 
  fill: rgb("#406372")
)

#set page(
  paper: "us-letter",
  margin: 2cm,
  header: align(
    right + horizon,
    "Physics 203-j28-Rotation - " + context document.author.at(0),
  ),
)

#set text(
  font: "Georgia",
  lang: "fr",
  size: 12pt
)

#show heading: set text(
  weight: "bold", 
  size: 1em, 
  fill: rgb("#005F87")
)

// --- DÉBUT DU DOCUMENT ---

#title()

#tip-box(title: "Introduction")[
  Jusqu'à présent, nous avons simulé des *points* qui se déplacent ($x, y, z$).
  Mais une boule de billard, une caisse ou une voiture sont des *Solides Rigides*.
  
  Ils ne font pas que se déplacer (Translation), ils tournent sur eux-mêmes (Rotation).
  
  La bonne nouvelle : *Toutes* les lois de la translation ont un équivalent exact en rotation. C'est le même code, avec des noms différents.
]

#definition-box(title: "1. Le Dictionnaire de Traduction")[
  Pour passer de la physique linéaire à la physique angulaire, il suffit de remplacer les variables :

  #table(
    columns: (1fr, 1fr, 1fr),
    inset: 10pt,
    align: center + horizon,
    stroke: 0.5pt + gray,
    table.header([*Concept*], [*Translation (Linéaire)*], [*Rotation (Angulaire)*]),
    
    [Position], 
    [Vecteur Position $arrow(p)$ \ (x, y, z)], 
    [Quaternion $q$ ou Angle $theta$ \ (Orientation)],

    [Vitesse], 
    [Vitesse $arrow(v)$ \ (m/s)], 
    [Vitesse Angulaire $arrow(omega)$ \ (rad/s)],

    [Résistance], 
    [Masse $m$ \ (kg)], 
    [Moment d'Inertie $I$ \ (kg·m²)],

    [Cause], 
    [Force $arrow(F)$ \ (Newton)], 
    [Couple $arrow(tau)$ \ (N·m)],

    [*Loi de Newton*], 
    [$arrow(F) = m arrow(a)$], 
    [$arrow(tau) = I arrow(alpha)$]
  )
]

#definition-box(title: "2. La Vitesse Angulaire (omega)")[
  En 3D, la rotation est définie par un vecteur $arrow(omega)$ (Omega).
  
  - *La Direction* de $arrow(omega)$ indique l'Axe de Rotation.
  - *La Longueur* ($||arrow(omega)||$) indique la vitesse de rotation (en radians par seconde).
  
  *Lien fondamental (Vitesse d'un point) :*
  Si une boule tourne sur place, quelle est la vitesse linéaire d'un point $P$ à la surface (situé à un rayon $arrow(r)$ du centre) ?
  
  $ arrow(v)_P = arrow(omega) times arrow(r) $
  _(Produit Vectoriel)_
]

#important-box(title: "3. Le Moment de Force (Couple / Torque)")[
  Pour faire avancer un objet, on pousse (Force).
  Pour faire *tourner* un objet, il faut pousser *avec un levier*.
  
  C'est le **Couple** ($arrow(tau)$ - Tau).
  
  $ arrow(tau) = arrow(r) times arrow(F) $
  
  - $arrow(r)$ : Le bras de levier (Vecteur du centre de masse vers le point d'impact).
  - $arrow(F)$ : La force appliquée.
  
  *Exemple :*
  - Pousser une porte près des gonds ($r approx 0$) : Ça ne tourne pas.
  - Pousser près de la poignée ($r$ grand) : Ça tourne facilement.
]

#definition(title: "4. L'Inertie et le Tenseur d'Inertie")[
  En translation, la résistance est simple : c'est la masse $m$. C'est un simple nombre (scalaire).
  
  En rotation, la résistance dépend de la *forme* de l'objet et de l'*axe* autour duquel on veut tourner.
  
  *A. Le Moment d'Inertie (I)*
  C'est la somme de toutes les masses multipliées par leur distance au carré de l'axe.
  Pour une Sphère pleine : $I = 2/5 m R^2$.
  
  *B. Le Tenseur d'Inertie (La Matrice)*
  Imaginez un stylo.
  - Le faire rouler entre les doigts (axe long) est très facile (Inertie faible).
  - Le faire tourner comme une hélice (axe court) est difficile (Inertie forte).
  
  Comme l'inertie change selon l'axe, on utilise une Matrice 3x3 appelée **Tenseur d'Inertie**.
  
  $ I_"tensor" = mat(I_x, 0, 0; 0, I_y, 0; 0, 0, I_z) $
  
  *Note pour le Billard :* Une sphère est symétrique partout. Son tenseur est simple : c'est juste un nombre $I$ (scalaire). On échappe à la complexité matricielle !
]

#definition-box(title: "5. Algorithme d'Intégration (Euler Rotation)")[
  Voici comment mettre à jour la physique de rotation dans le code :
  
  1. *Calculer le Couple total :*
     $ arrow(tau) = arrow(r)_1 times arrow(F)_1 + arrow(r)_2 times arrow(F)_2 + ... $
     
  2. *Newton Angulaire (Trouver l'accélération) :*
     $ arrow(alpha) = arrow(tau) / I $
     
  3. *Mettre à jour la Vitesse Angulaire :*
     $ arrow(omega)_"new" = arrow(omega) + arrow(alpha) dot d t $
     
  4. *Mettre à jour l'Orientation (Quaternion) :*
     On tourne l'objet de l'angle $||arrow(omega)|| dot d t$ autour de l'axe $arrow(omega)$.
]

#example[
  *Application : Le "Coup de Queue"*
  
  Si on tape la boule blanche au-dessus du centre (distance $h$) avec une force $F$ vers l'avant :
  
  1. *Force :* $F$ fait avancer la boule ($a = F/m$).
  2. *Bras de levier :* $r = h$ (vers le haut).
  3. *Couple :* $tau = r times F$. Comme $r$ est vertical et $F$ horizontal, le couple est horizontal (axe gauche/droite).
  4. *Résultat :* La boule avance ET se met à rouler vers l'avant (Topspin).
]