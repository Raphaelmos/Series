#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
//taille des differents tableaux et chaines de charactères
#define Max_matricule 6
#define Max_loc 10
#define Max_nom 20

//structure principale 
typedef struct Rental {
    char nom[Max_nom];
    char p_base;
    int nmbr_jours;
    char matricule[Max_matricule];
    float kilometres;
} Rental;
Rental R;

int calculer_semaines(int jours);
int get_a_number();
char confirm_letter();
Rental saisie ();
void affichage(const Rental *l);
Rental *supprimer_element(const char *nom, const char *mat, Rental Rs[], int *length);
float calculer_prix(const char *nom, const char *mat, Rental Rs[], int *length);
void charger_menu(void);


//fonction pour calculer le nombre de semaines afin d'établir le prix pour la base location C
int calculer_semaines(int jours){
    int semaines;
    semaines = ( jours % 365) / 7;
    return semaines;
}
//fonction pour obtenir un nombre entre 1 et le maximum de locations possibles(10)
int get_a_number(){
    int number;
    printf("\nCombien de voitures voulez-vous louer (un maximum de 10 voitures)?: ");
    scanf(" %d", &number);
    while(!((number > 0) && (number < Max_loc))){
        printf("\n[ERREUR] SVP choisissez un nombre entre 1 et 10!");
        scanf(" %d", &number);
    }
    return number;
}
//fonction pour confirmer le type de plan
char confirm_letter(){
    char letters[4]= {'A','B','C','\0'};
    char input;
    printf("\nCategories: A (Plan de base), B (Plan journalier), C (Plan hebdomadaire)\n");
    printf("Votre choix: "); 
    scanf(" %c", &input);
    while(!(input == letters[0] || input ==letters[1] || input ==letters[2]))
    {
        printf("\n[ERREUR] SVP choisissez entre le plan base A, B ou C: ");
        scanf(" %c", &input);
    }
    return input;
}
//fonction pour saisir les données du tableau des structures 
Rental saisie (){
    char base; 
    printf("\nEntrez SVP les spécifications de votre location voiture:\n");
    printf("\nNom:"); 
    scanf(" %s", R.nom);
    base = confirm_letter();
    R.p_base = base;
    printf("\nNombre de jours de location:"); 
    scanf(" %d", &R.nmbr_jours);
    printf("\nMatricule de la voiture:"); 
    scanf(" %s",R.matricule);
    printf("\nKilométres parcourus:"); 
    scanf(" %f",&R.kilometres);
    system("clear");
    return R;
}
//fonction qui affiche les données du tableau des structures (à corrégir....faire un boucle pour la parcourir)
void affichage(const Rental *l){
    printf("\nNom: %s \nBase: %c \nJours: %d \nMatricule: %s \nKilométres: %f\n", l->nom, l->p_base, l->nmbr_jours, l->matricule, l->kilometres); 
}

Rental *supprimer_element(const char *nom, const char *mat, Rental Rs[], int *length)
{
    Rental Reset[1] = {{"\0",' ',0,"\0",0.0}};
    int taille = *length;
    for (int i =0; i < taille; i++ ){
        if ( strcmp( nom, Rs[i].nom) == 0 && strcmp(mat, Rs[i].matricule) == 0) {
            Rs[i] = Reset[1];
        }
    }
    return Rs;
}

float calculer_prix(const char *nom, const char *mat, Rental Rs[], int *length){
    int taille = *length;
    float prix, quotc;
    
    for(int i=0;i < taille; i++) {
        if ( strcmp( nom, Rs[i].nom) == 0 && strcmp(mat, Rs[i].matricule) == 0){
            switch (Rs[i].p_base) {
                case 'A': printf("Votre plan base est: %c \n", Rs[i].p_base);
                    printf("Nombre de kilomètres parcourus: %f\n", Rs[i].kilometres);
                    printf("Nombre de jours: %d\n", Rs[i].nmbr_jours);
                    prix = Rs[i].kilometres * 0.15 + 25 * Rs[i].nmbr_jours;
                    break;
                case 'B': printf("Votre plan base est: %c \n", Rs[i].p_base);
                    printf("Nombre de kilomètres parcourus: %f\n", Rs[i].kilometres);
                    printf("Nombre de jours: %d\n", Rs[i].nmbr_jours);
                    // Les frais kilométriques
                    float extra = 0;
                    // Les kilomètres qu'il reste à contabiliser
                    float remaining_km = Rs[i].kilometres - 100*Rs[i].nmbr_jours;
                    // Le taux
                    float rate = 0.15f;
                    // Tant qu'il nous reste des kilomètres
                    for (; remaining_km > 0 ; rate += 0.10f, remaining_km -= 100) {
                        // Combien de kilomètres pour cette tranche
                        if (remaining_km > 100) {
                        extra += 100*rate;
                        } else {
                        extra += remaining_km * rate;
                        }
                    }

                    prix = extra + 35 * Rs[i].nmbr_jours;
                    break;

                case 'C':printf("Votre plan base est: %c \n", Rs[i].p_base);
                    printf("Nombre de kilomètres parcourus: %f\n", Rs[i].kilometres);
                    quotc = calculer_semaines(Rs[i].nmbr_jours);
                    printf("Nombre de semaine ou fraction de semaine: %f\n", quotc);
                    // Prix de base
                    float prix_base_c = 120 * quotc;
                    float frais_kilometriques = 0;
                    // Frais kilometriques
                    // Si le nombre de kilometres dépasse  les seuils par semaine
                    if (Rs[i].kilometres > 1500 * quotc) {
                    frais_kilometriques = 130 * quotc + (Rs[i].kilometres - 1500) * 0.15;
                    } else if (Rs[i].kilometres > 900 * quotc) {
                    frais_kilometriques = 60 * quotc;
                    }
                    prix= prix_base_c + frais_kilometriques;
                    break;
            }
        } 
    }
    return prix;
        
} 
    
Rental *afficher(const char *nom, const char *mat, Rental Rs[], int *length){
    
    int taille = *length;
    for(int i=0;i < taille; i++) {
        if ( strcmp( nom, Rs[i].nom) == 0 && strcmp(mat, Rs[i].matricule) == 0){
            printf("\nLocation(s) sous ce nom et numéro de immatriculation:\n");
            affichage(&Rs[i]);
        } else if ( strcmp( nom, Rs[i].nom) == 0){
            printf("\nLocation(s) sous ce nom:\n");
            affichage(&Rs[i]);
        } else if (strcmp(mat, Rs[i].matricule) == 0) {
            printf("\nLocation(s) sous ce numéro d'immatriculation:\n");
            affichage(&Rs[i]);
        } 
    }
    return NULL;
    } 

void charger_menu(void) {
    int choix;
    int input_number=0;
    char input_nom[Max_nom];
    char input_imma[Max_matricule];
	do 
	{
        printf("-----------------------------------Menu-----------------------------------\n");
        printf("--------------------------------------------------------------------------\n");
        printf("\t1. Saisir des nouvelles informations sur la location.\n");
		printf("\t2. Afficher des locations.\n");
        printf("\t3. Calculer le prix de votre location.\n");
        printf("\t4. Suppression des données de location.\n");
        printf("\t5. Arret du programme.\n\n");
        printf("--------------------------------------------------------------------------\n");
        printf("Votre choix:");
		scanf(" %d",&choix);

    		switch(choix) {
            
            case 1: system("clear"); 
                input_number = get_a_number();
                Rental *R01 = malloc(input_number * sizeof(Rental));
                for (int i=0;i < input_number;i++){
                    R01[i]=saisie(R01);
                }
				break;
            case 2: printf("\nSVP entrez votre nom et / ou le numéro d'immatriculation pour voir le détail de votre location voiture:\n");
                printf("\nNom: ");
                scanf(" %s", input_nom);
                printf("\nNuméro d'immatriculation: ");
                scanf(" %s", input_imma);
                Rental *trouve = afficher(input_nom,input_imma,R01, &input_number);
                if (trouve){
                    printf("\nVoici les details de votre / vos location(s):\n");
                }
                break;
            case 3: printf("\nSVP entrez votre nom et le numéro d'immatriculation pour calculer le prix à regler de votre location voiture:\n");
                printf("\nNom: ");
                scanf(" %s", input_nom);
                printf("\nNuméro d'immatriculation: ");
                scanf(" %s", input_imma);
                float Rprix = calculer_prix(input_nom,input_imma,R01, &input_number);
                if (Rprix){
                    printf("Voici le montant à regler %f\n", Rprix);
                }
                break; 
            case 4: printf("\nSVP entrez votre nom et le numéro d'immatriculation pour supprimer les détails de votre location voiture:\n");
                printf("\nNom: ");
                scanf(" %s", input_nom);
                printf("\nNuméro d'immatriculation:");
                scanf(" %s", input_imma);
                Rental *supprime = supprimer_element(input_nom,input_imma,R01, &input_number);
                if (supprime){
                    printf("\nLes données de votre location ont été suppimées avec succès!");
                }
                else {
                    printf("\nAucune location sous votre nom\n");
                }
				break;
            case 5: printf("Programme fermé!\n");
                exit(0);
			default: system("clear"); 
                printf("Saisie incorrecte!:\n");
				break;
		}
	} while (choix != 4);

}
int main(void){
    charger_menu();
    //int length = 0, 
    //length= sizeof(R01)/sizeof R01[0];  calculer la taille du tableau des structures
    //int jours = 14;
    return 0;
}


/*
char isLetter(char c)
{
    int asciiLetter = c;
    if (asciiLetter >= 65 && asciiLetter <= 90)
        return 1;

    return 0;
}

int isDigit(char c)
{
    int asciiLetter = c;
    if (asciiLetter >= 48 && asciiLetter <= 57)
        return 1;

    return 0;
}

char isCorrectImmat(const char *testString)
{
    int isCorrect = 0;

    if (strlen(testString) == 7)
    {
        int countLetter = 0;
        for (int i = 0; i < 3; i++)
        {
            if (isLetter(testString[i]))
            {
                countLetter++;
            }
        }

        int countNumber = 0;
        for (int i = 3; i < 7; i++)
        {
            if (isDigit(testString[i]))
            {
                countNumber++;
            }
        }

        if (countLetter == 3 && countNumber == 4)
        {
            isCorrect = 1;
        }
    }

    return isCorrect;
}


// fonction qui voulait s'utiliser pour l'implémentation d'un fichier .txt pour assigner le numéro de matriculation

int *matricule_from_file (const char *nom_fichier){
    
    FILE *nf;
    size_t length;
    size_t random_line=0; 
    char mat_selectionne[8];
    char ligne[8];
       
    mat_selectionne[0] = '\0';
    
    nf = fopen(nom_fichier, "r");
    
    if (!nf) {
        fprintf(stderr, "Le fichier %s n'a pas pu être ouvert!", nom_fichier);
        perror("NULL");
        exit(1); }
    
    while ( fgets(ligne, sizeof(ligne), nf)) {
        if (drand48() < 1.0 / ++random_line){
            strcpy(mat_selectionne, ligne);
        }
    }

    fclose(nf);
    
    length = strlen(mat_selectionne);
    if (length > 0 && mat_selectionne[length-1] == '\n') {
        mat_selectionne[length-1] = '\0';
    }

    return strdup(mat_selectionne);
}*/