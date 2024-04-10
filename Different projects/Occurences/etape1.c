/* 

Etape 2 Projet ADS2 Compilé et executé

Etape 2 à 8 ( code ) 9 à 12 explications

*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <setjmp.h>

int main() {

// Etape 2

char tableau[4000];

// Remplissage du tableau
strcpy(tableau, "LTAELTAETATLALEATTAELTTATTEALETAELAATTLAATEATELALAEATTLETATETTLAETALTTEALTA");

// Motif 1 : LA+EA*T+
int occ1[100][2]; // Tableau pour stocker les occurrences
int nocc1 = 0; // Nombre d'occurrences du motif 1

// Parcourir le tableau et chercher les occurrences
int i;
for(i=0; i<4000; i++) {

// Vérifier si début d'occurrence
if(tableau[i]=='L' && tableau[i+1]=='A') {

  // Vérification du reste de l'occurrence
  int j=i+2;
  int score=2; 
  while(j<4000 && (tableau[j]=='E' || tableau[j]=='A' || tableau[j]=='T')) {

    if(tableau[j]=='E') score++;
    if(tableau[j]=='A') score++; 
    if(tableau[j]=='T') break;
    
    j++;
  }

  // Si fin bonne, ajouter l'occurrence
  if(tableau[j]=='T') {
    occ1[nocc1][0] = i; // Position
    occ1[nocc1][1] = score; // Score
    nocc1++; 
  }

}

}

// Affichage résultats étape 2
printf("Occurrences du motif 1:\n");
printf("Occ [pos pts]\n");

for(i=0;i<nocc1;i++) {
 printf("%d-%d [%d %d]\n",i+1,nocc1,occ1[i][0],occ1[i][1]);
}

 printf("\n");
 return 0;

}

/*

Trace d'éxecution : 

Occurrences du motif 1:
Occ [pos pts]
1-4 [33 3]
2-4 [38 3]
3-4 [48 4]
4-4 [62 3]


*/
