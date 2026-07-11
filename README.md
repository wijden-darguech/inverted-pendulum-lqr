Pendule inversé sur chariot — LQR et swing-up énergétique

Modélisation et commande d'un pendule inversé actionné par un moteur pas-à-pas, depuis les
équations de Lagrange jusqu'à un contrôleur hybride swing-up + LQR capable de stabiliser
le système depuis n'importe quelle position de départ — y compris φ(0) ≈ π (pendule au repos,
tête en bas).

Le même problème mathématique (stabilisation d'un état instable et sous-actionné par retour
d'état complet) se retrouve dans la commande d'attitude d'un drone.

Contexte

Le système : un chariot motorisé par un moteur pas-à-pas se déplace sur un rail horizontal
(course ±0,4 m) ; un pendule articulé sans jeu ni frottement pivote librement à sa base ; un
capteur angulaire (résolution 1600 points/tour) mesure l'angle φ par rapport à la verticale.

Deux objectifs de commande simultanés :


maintenir le pendule vertical (φ → 0)
recentrer le chariot au milieu du rail (x → 0)


en respectant la course physique du rail et les limites réalistes de l'actionneur.

Méthode


Modélisation — équations du mouvement dérivées par la formulation de Lagrange (L = T − V),
avec l'hypothèse d'un moteur pas-à-pas (accélération imposée, indépendante de la charge)
Linéarisation autour de l'équilibre instable φ = 0
Représentation d'état avec X = [x, ẋ, φ, φ̇]ᵀ
Synthèse LQR — calcul du gain K par résolution de l'équation de Riccati (lqr() MATLAB),
validé analytiquement (valeurs propres de A−BK) avant toute simulation Simulink
Modèle Simulink non-linéaire, fidèle aux contraintes réelles : seul φ est mesuré
(capteur quantifié à 2π/1600 rad), φ̇ est dérivée (filtrée), x et ẋ sont reconstruits par
double intégration de la commande — pas de capteur de position dédié
Extension swing-up — loi de commande basée sur le bilan énergétique du pendule pour
amener le système dans le domaine de validité du LQR depuis un grand angle initial, avec
bascule automatique entre les deux lois de commande


Résultats

Stabilisation réussie depuis φ(0) ≈ π : le contrôleur pompe progressivement de l'énergie dans
le pendule (oscillations d'amplitude croissante), bascule vers le LQR dès l'entrée dans la
zone de capture, puis stabilise conjointement φ et x vers 0 — sans jamais dépasser la
contrainte de course du rail (±0,4 m).

Voir docs/Pendule_inverse_LQR_swingup.pdf pour le
rapport complet (équations, architecture Simulink, courbes).
