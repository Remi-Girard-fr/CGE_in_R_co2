# CGE_in_R, fork : une taxe carbone recyclée dans une maquette ThreeME

Ce dépôt est un fork de [ThreeME-org/CGE_in_R](https://github.com/ThreeME-org/CGE_in_R), la version pédagogique open source du modèle macroéconomique multisectoriel [ThreeME](https://www.threeme.org/) (OFCE / Ademe), résolue entièrement en R avec le solveur [tresthor](https://github.com/OFCE/tresthor) de l'OFCE. Tout le cœur du dépôt (compilateur, fonctions, modèles de formation) est le travail de l'équipe ThreeME.

Ce fork ajoute une extension et une analyse : la simulation d'une taxe carbone recyclée dans le modèle néo-keynésien en économie ouverte de la maquette, en écho à la modélisation utilisée par le STATEC pour le PNEC luxembourgeois (le modèle ThreeME y est couplé à Modux et NEAM pour les projections à l'horizon 2050 et l'évaluation de la taxe CO2).

Le rapport complet est consultable ici : https://remi-girard-fr.github.io/CGE_in_R/

## Apports de ce fork par rapport au dépôt d'origine

- `src/model/training/05.1-eq_co2_open.mdl` : le modèle 03.2 (néo-keynésien ouvert complet) augmenté d'un bloc carbone. Trois équations nouvelles (émissions EMS proportionnelles à la production, recette REV_CO2, transfert de compensation TR_CO2) et quatre équations modifiées (prix notionnel de production, profits, revenu des ménages, épargne publique).
- `src/model/training/05.1-calib_co2_add.mdl` : calibration additionnelle du bloc (taxe nulle en base, donc état stationnaire de référence inchangé ; 50 % de la recette recyclée vers les ménages, la règle luxembourgeoise).
- `configuration/scenarii_calib/2_calib_shock_co2.R` : scénario de choc, taxe fixée pour générer ex ante une recette de 1 % du PIB nominal à partir de 2021 (format du scénario standard ct1 de l'équipe ThreeME).
- `configuration/config_input_MODEL.R` : configuration de l'exercice (modèle 05.1, calibration 03.1-calib_exception_open + 05.1, scénarios g et co2, solveur R).
- `src/setup.R` : correctif mineur, le package CRAN qs est remplacé par son successeur qs2.
- `analysis/` : le document Quarto de la mini-analyse et les résultats de simulation (france_co2.rds) permettant de le rendre sans relancer le modèle.
- `docs/` : le rapport HTML publié via GitHub Pages.

## Reproduire les simulations

1. Cloner ce dépôt et ouvrir `CGE_in_R.Rproj` dans RStudio (R >= 4.3.1, Rtools sous Windows).
2. Installer les dépendances, dont quatre packages GitHub :

```r
install.packages("pak")
pak::pak(c("OFCE/ofce", "mslegrand/pegr", "OFCE/tresthor", "ThreeME-org/ermeeth"))
source("src/package_installation.R")   # packages CRAN restants
```

3. Lancer `Main.R`. Le script compile le modèle (dynamo), calibre la baseline stationnaire et les deux chocs, traduit le modèle pour tresthor, résout année par année 2016-2050 et écrit `data/output/france_co2.rds`.
4. Rendre le rapport : `quarto render analysis/ThreeME_mini_analyse.qmd`.

## Résultats principaux

Une taxe carbone de 1 % du PIB, recyclée à 50 % vers les ménages, creuse l'activité à court terme (PIB -0,7 % au maximum en 2025) puis l'écart se referme presque entièrement (-0,13 % en 2050), la consommation des ménages devenant positive dès 2030. La perte de compétitivité (exportations -1 %) est en revanche persistante en l'absence d'ajustement aux frontières. Le choc symétrique de dépenses publiques présente le profil temporel inverse : fort à l'impact, évanescent ensuite.

## Références et crédits

- Équipe ThreeME (OFCE, Ademe) : [dépôt d'origine](https://github.com/ThreeME-org/CGE_in_R), [documentation du modèle](https://www.threeme.org/documentation), solveur [tresthor](https://github.com/OFCE/tresthor).
- Gouvernement du Grand-Duché de Luxembourg (2024), [PNEC, mise à jour 2024](https://energie.public.lu/fr/politique-energetique/plan-national-energie-climat.html).
- STATEC (2024), Modèles utilisés et scénarios simulés pour le PNEC, note du département Conjoncture, Modélisations et Prévisions, juillet 2024.
- Callonnec G., Cancé R. (2022), Évaluation macroéconomique de la SNBC 2 avec le modèle ThreeME, Ademe-CGDD.

Auteur du fork et de l'analyse : Rémi Girard. Présentation et contexte : [lien vers la page du site à ajouter].
