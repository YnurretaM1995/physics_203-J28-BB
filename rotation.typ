#set text(font: "Linux Libertine", lang: "fr", size: 12pt)
#set page(paper: "a4", margin: 2.5cm)
#set par(justify: true)

= Physique du Billard : La Mécanique du Solide
_Au-delà du simple point matériel_

Jusqu'ici, nous avons traité les objets comme des points flottants dans l'espace. Une boule de billard est plus complexe : c'est un **Solide Rigide**. Elle peut avancer, mais elle peut aussi tourner sur elle-même.

C'est cette rotation qui permet les effets (rétro, coulé, massé) et qui rend la physique du billard si riche.

== 1. Les nouvelles variables : Rotation et Inertie

Pour décrire une boule, nous avons besoin de doubler nos variables : une pour le linéaire (translation), une pour l'angulaire (rotation).

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    inset: 10pt,
    stroke: 0.5pt + gray,
    table.header([*Concept*], [*Linéaire (Avancer)*], [*Angulaire (Tourner)*]),
    
    [Vitesse], 
    [$arrow(v)$ (m/s)], 
    [$arrow(omega)$ (rad/s) \ _(Vecteur Vitesse Angulaire)_],

    [Cause du mouvement], 
    [Force $arrow(F)$ (Newton)], 
    [Couple $arrow(tau)$ (Newton-mètre) \ _(Torque)_],

    [Résistance au mouvement], 
    [Masse $m$ (kg)], 
    [Moment d'Inertie $I$ (kg·m²)]
  ),
  caption: [Analogie Translation / Rotation]
)

=== Le Moment d'Inertie ($I$)
C'est la "masse de rotation". Plus $I$ est grand, plus il est difficile de faire tourner l'objet (ou de l'arrêter de tourner).
Pour une sphère pleine (comme au billard) de rayon $R$ et de masse $m$ :
$ I = 2/5 m R^2 $

=== La Mise en mouvement (Le coup de queue)
Quand la queue frappe la boule, elle transmet une impulsion $arrow(J)$.
- Si on frappe au centre : La boule avance sans tourner (au début).
- Si on frappe au-dessus du centre (distance $h$) : On crée un **Couple** ($tau = h dot F$). La boule avance *et* se met à tourner vers l'avant (Coulé).

== 2. Le Cœur du problème : Le Point de Contact ($P$)

La boule touche le tapis en un point précis, tout en bas. Appelons ce point $P$.
La physique de la friction dépend uniquement de la vitesse de ce point $P$ *par rapport au tapis*.

La vitesse du point de contact est la somme de deux vitesses :
1.  La vitesse du centre de la boule ($v$).
2.  La vitesse due à la rotation ($Omega . R$).

#box(fill: luma(245), stroke: 1pt + red, inset: 1em, radius: 5pt, width: 100%)[
  *Vitesse de Glissement ($arrow(v)_g$)*
  
  En simplifiant en 1D (vue de profil), la vitesse du point au sol est :
  $ v_g = v - R omega $
]

Il y a alors deux cas possibles, qui dictent quel type de friction s'applique.

== 3. Phase 1 : Le Glissement (Friction Dynamique)
_Exemple : Le coup fort, ou le "Rétro"_

C'est ce qui se passe quand $v_g < 0$. Le point de contact "rape" le tapis.
- Si vous frappez fort au centre, la boule part vite ($v$ grand), mais ne tourne pas encore ($Omega = 0$). Donc $v_g$ est grand. La boule "burn" sur le tapis comme une voiture au démarrage.

*La Force de Friction Cinétique ($f_k$) :*
Le tapis n'aime pas ça. Il exerce une force constante opposée au glissement.
$ f_k = mu_k m g $
_(Où $Mu_k$ est le coefficient de friction dynamique, environ 0.2 pour du drap)._

*Le Double Effet Kiss-Cool :*
Cette force unique fait deux choses contradictoires mais nécessaires pour atteindre l'équilibre :
1.  Elle s'oppose au mouvement : elle fait *diminuer* la vitesse linéaire $v$.
2.  Elle crée un couple (au niveau du sol) : elle fait *augmenter* la vitesse de rotation $Omega$.

$ arrow(a) = - arrow(f)_k / m $ (La boule ralentit)
$ arrow(alpha) = (R times arrow(f)_k) / I $ (La boule se met à tourner)

Au fil du temps, $v$ diminue et $Omega$ augmente... jusqu'à ce qu'ils se rencontrent.

== 4. Phase 2 : Le Roulement (Friction Statique / Résistance)
_L'état d'équilibre naturel_

C'est ce qui se passe quand $v_g = 0$.
Mathématiquement : $v = R omega$.

À cet instant précis, le point de contact touche le tapis mais ne glisse pas (comme une chenille de tank ou un pneu de voiture sur l'autoroute). Le glissement s'arrête.

*La Résistance au Roulement ($mu_r$) :*
Techniquement, s'il n'y avait aucune perte d'énergie, la boule roulerait à l'infini.
En réalité, la boule s'écrase un tout petit peu dans le tapis. Cela crée une très faible force qui la ralentit doucement.
C'est souvent modélisé comme une friction très faible (10 à 50 fois plus faible que le glissement).

== 5. Résumé de la vie d'une boule

Prenons l'exemple d'un coup "Rétro" (Backspin) :

1.  *Impact :* On tape bas. La boule part vers l'avant ($v > 0$), mais tourne à l'envers ($Omega < 0$).
2.  *Glissement violent :* Au sol, la boule frotte vers l'avant (car elle tourne à l'envers).
3.  *Action de la Friction :*
    - La friction du tapis pousse vers l'arrière (freine la boule).
    - La friction force la rotation à ralentir, s'arrêter, puis repartir dans le bon sens.
4.  *Transition :* À un moment, la rotation "rattrape" la vitesse. $v = R omega$.
5.  *Roulement :* La friction de glissement disparaît. La boule roule "naturellement" jusqu'à l'arrêt complet dû à la résistance au roulement.