

import random
liste_de_mots = ["lapin","girafe","coq","chat","lion","vache","tigre","ours","rat","cheval"]


def main():
    print(""" 
===============================================
            Jeu du pendu
===============================================
""")
if __name__ == "__main__":
    main()



def get_mot():
    option= input("Choisir votre type du jeu :  \n1 -> saisir mot \n2 -> Mot aléatoire d'une prédéfini \n3 -> Mot aléatoire d'un fichier \n choix:")
    if option == "1":
        mot = input("Saisissez un mot !:")
        if mot.isalpha() == True:
            return mot
        else :
            print("Ecrivez les mots uniquement avec des lettres !")
            get_mot()
    elif option == "2":
        return random.choices(liste_de_mots)[0]
    else:
        "F"



def pendu_run(mot):
    réponse = ["_"]*len(mot)
    essais = 10
    print(f"Le mot a trouvé possède {len(mot)} lettres")
    print(f"vous avez 10 essais.")



    while essais != 0 and "".join(réponse) != mot:
        print(f"Mot a deviné : {print_mot(mot, réponse)}")
        lettre = input("Deviner une lettre ou le mot en entier: ")
        if lettre == mot:
            for i in range(len(mot)):
                réponse[i] = mot[i]
        if (lettre in mot) == True and (lettre in réponse) == True:
            print("Cette lettre à déjà été utiliseé !")
        elif (lettre in mot) == True:
            for i in range(len(mot)):
                if lettre == mot[i]:
                     réponse[i] = lettre              
        else:
          essais-=1
        print(f"Il n'y a pas de {lettre} . Essais restants {essais}")
    if "".join(réponse) == mot :
        print(f"Bien joué vous avez réussi ! : {mot}")
    else:
        print(f"Perdu... Le mot était : {mot}...")



    print("Envie de rejouer ?")
    if input("oui ou non ?") == "oui":
        main()
        pendu_run(get_mot())


def print_mot(mot, lettres_devinees):
    return "".join(lettres_devinees)

pendu_run(get_mot())

