#import "@preview/theorion:0.4.1": *
#import cosmos.rainbow: *
#show: show-theorion

#set document(
  author: ("Richard Rispoli"),
  title: [Physique du Billard : Mécanique du Solide]
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
    "Physics 203-j28-BB - " + context document.author.at(0),
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
  Une boule de billard est un *Solide Rigide*. Elle possède une masse $m$ mais aussi une répartition de cette masse autour de son centre, appelée *Moment d'Inertie* $I$.
  
  Pour une sphère pleine de rayon $R$ :
  $ I = 2/5 m R^2 $
]

#definition-box(title: "1. L'Impact (Le coup de queue)")[
  C'est l'instant initial ($t=0$). La queue transmet une quantité de mouvement instantanée appelée *Impulsion* ($J$).
  
  La manière dont la boule va réagir dépend de deux paramètres :
  1. La force de la frappe (Magnitude de l'impulsion $J$).
  2. La hauteur de la frappe par rapport au centre ($h$).
  
  *A. Vitesse Linéaire Initiale ($v_0$)*
  La queue pousse la boule vers l'avant. La vitesse résultante dépend uniquement de l'impulsion et de la masse. Peu importe où l'on tape, la boule partira à la même vitesse linéaire.
  
  $ v_0 = J / m $
  
  *B. Vitesse Angulaire Initiale ($omega_0$)*
  Si on tape décalé du centre ($h lt 0$), on crée un *bras de levier*. Cela génère un couple instantané qui met la boule en rotation.
  
  $ omega_0 = (h dot J) / I $
  
  En remplaçant $I$ par sa formule ($2/5 m R^2$), on obtient la formule pratique :
  
  $ omega_0 = (5 h J) / (2 m R^2) = (5 h v_0) / (2 R^2) $
]

#example[
  *Interprétation du paramètre $h$ :*
  
  - *Centre ($h = 0$)* : $omega_0 = 0$. La boule part en glissant sans tourner (le "Carreau" parfait).
  - *Haut ($h > 0$)* : $omega_0 > 0$. Rotation avant ("Coulé").
  - *Bas ($h < 0$)* : $omega_0 < 0$. Rotation arrière ("Rétro").
]

#important-box(title: "2. Le Point de Contact (P)")[
  Une fois la boule lancée, tout dépend de ce qui se passe au point de contact avec le tapis.
  
  La vitesse de ce point ($v_p$) par rapport au sol est la combinaison de la translation et de la rotation :
  
  $ v_p = v - R omega $
  
  C'est cette valeur qui détermine s'il y a friction ou non.
]

#definition-box(title: "Phase 3 : Friction et Glissement")[
  Tant que $v_p lt 0$, la boule glisse. Le tapis exerce une force de friction opposée au mouvement du point de contact.
  
  *Force de Friction ($f_k$)* :
  $ f_k = mu_k m g $
  (où $mu_k$ est le coefficient de friction dynamique du tapis).
  
  Cette force a deux effets simultanés qui travaillent à rétablir l'équilibre :
  
  1. *Freinage Linéaire :* Elle réduit la vitesse $v$.
     $ a = - f_k / m = - mu_k g $
     
  2. *Accélération Angulaire :* Elle modifie la rotation $omega$ (car la force au sol crée un couple).
     $ alpha = (R f_k) / I = (5 mu_k g) / (2 R) $
     
  *Conséquence :* $v$ change et $omega$ change jusqu'à ce que $v = R omega$.
]

#tip-box(title: "Phase 4 : Le Roulement (Rolling)")[
  Quand la condition $v = R omega$ est atteinte, le point de contact devient immobile par rapport au sol ($v_p = 0$).
  
  Le glissement s'arrête. La friction dynamique $mu_k$ disparaît.
  La boule continue de rouler avec une très faible décélération due à la résistance au roulement ($mu_r$).
]