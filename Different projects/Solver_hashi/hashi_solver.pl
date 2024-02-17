% ------------------------------------------HASHI---------------------------------------------------------
% Prédicat extraire_iles_lignes/3
% N est une entier positif correspondant au nombre de la ligne.
% Ligne est une liste qui représente les éléments qui conforment une des lignes du puzzle hashi
% Iles est une liste ordonnée (iles de gauche à droite) contenant les information pour chaque ile de la ligne. 

extraire_iles_ligne(N_L,Ligne,Iles):-
    extraire_iles_ligne_aux(N_L,Ligne,0,Iles).

extraire_iles_ligne_aux(_,[],_,[]).
% I est utilisée pour compter le numéro de la colonne, Si T == 0, espace vide, si P \= 0, alors est une ile
     
extraire_iles_ligne_aux(N_L,[T|Q],I,RAux):- T ==0, I1 is I+1,
    extraire_iles_ligne_aux(N_L,Q,I1,RAux).

extraire_iles_ligne_aux(N_L,[T|Q],I,[ile(T,(N_L,I1))|RAux]):- T\=0, I1 is I+1,
    extraire_iles_ligne_aux(N_L,Q,I1,RAux).
% --------------------------------------------------------------------------------------------------------
% iles/2 ---> iles(Puzzle,Iles) est une liste ordonées dont ses élements sont les îles du Puzzle 
iles(Puz,Iles):- iles_aux(Puz,IlesR,0),
    flatten(IlesR,Iles). % Transforme IleR (une liste de liste) dans une liste applatie
    
iles_aux([],[],_).
iles_aux([T|Q],[Ile|IleR],I):-  % On utilise I pour contabiliser le nombre de lignes
    N_L is I + 1, extraire_iles_ligne(N_L,T,Ile),iles_aux(Q,IleR,N_L).

% --------------------------------------------------------------------------------------------------------
% ile_voisine/3 --------> ile_voisine(Iles,Ile, Voisines). Voisines est une liste ordonnée contenant les
% iles voisines d une ile
% --------------------------------------------------------------------------------------------------------

ile_sur_ligne(Ligne,Ile):-
    Ile = ile(_, (L,_)), % verifie si une autre ile est sur la meme ligne
    L == Ligne.

ile_sur_colonne(Colonne,Ile):-
    Ile= ile(_, (_,C)),   % verifie si une autre ile est sur la meme colonne
    C == Colonne.

ile_meme_coordonnees(Ile, PossibleIle):-
    PossibleIle = ile(_, (Ligne,_)), ile_sur_ligne(Ligne, Ile) ; PossibleIle = ile(_, (_, Colonne)),ile_sur_colonne(Colonne,Ile).

saisir_premier([],[]).
saisir_premier([T|_],T).

saisir_last([],[]).
saisir_last(L, Dernier):-
    last(L,Dernier).
    
% Obtenir les iles placées dans la meme ligne et colonne que X ile
voisines(Iles, Ile, Vs):-
    include(ile_meme_coordonnees(Ile), Iles, Voisines1),
    findall(IleVoisines, (member(IleVoisines, Voisines1), IleVoisines \== Ile), Voisines2),
    findall(IleGauche, (member(IleGauche, Voisines2), Ile = ile(_, (_, C1)), IleGauche =  ile(_, (_, C2)), C2 < C1 ), VoisineGauche),
    findall(IleDroite, (member(IleDroite, Voisines2), Ile = ile(_, (_, C1)), IleDroite =  ile(_, (_, C2)), C2 > C1 ), VoisineDroite),
    findall(IleEnHaut, (member(IleEnHaut, Voisines2), Ile = ile(_, (L1, _)), IleEnHaut =  ile(_, (L2, _)), L2 < L1 ), VoisineEnHaut),
    findall(IleEnBas, (member(IleEnBas, Voisines2), Ile = ile(_, (L1, _)), IleEnBas =  ile(_, (L2, _)), L2 > L1 ), VoisineEnBas),
    % On obtient les iles voisines de l ile
    saisir_premier(VoisineEnBas,B),
    saisir_premier(VoisineDroite,D),
    saisir_last(VoisineEnHaut,H),
    saisir_last(VoisineGauche,G),
    flatten([[H], [G], [D], [B]], Vs).
    % On applatit une liste des listes des iles voisines.
% -------------------------------------------------------------------------------------------------------
% etat/2 ------>  etat (Iles, Etat) Etat est une liste ordonnée dont ses éléments sont des entrées par rapport à chaque ile de l liste Ile
% -------------------------------------------------------------------------------------------------------

etat(Iles, Etat):- etat_aux(Iles,Iles, Etat).

etat_aux(Iles,[H|Q],[[H,Voisines,[]] | Q1]):-  % On crée les entrées
    voisines(Iles,H,Voisines), etat_aux(Iles,Q,Q1).
etat_aux(_,[],[]).

% -------------------------------------------------------------------------------------------------------
% positions_entre/3 ------> positions_entre est une liste ordonnée de positions entre Pos1 et Pos2

positions_entre(Pos1,Pos2,Positions):-
    % Si Pos1 et Pos2 sont dans la meme colonne, et Pos1 est une ligne au-dessus que Pos2
    Pos1 = (L1,C1), Pos2 = (L2,C2), C1 == C2, L1 =< L2,
    positions_entre_lignes(Pos1, Pos2,PositionsX),
    findall(Pos, (member(Pos,PositionsX), Pos \= Pos1, Pos \= Pos2),Positions)   ;

    % Si Pos1 et Pos2 sont dans la meme colonne, et Pos1 est une ligne au-desous de Pos2
    Pos1 = (L1, C1), Pos2 = (L2, C2), C1 == C2, L1 > L2 , 
    positions_entre_lignes(Pos2, Pos1, PositionsX),
    findall(Pos, (member(Pos, PositionsX), Pos \= Pos1, Pos \= Pos2), Positions) ;

    % Si Pos1 et Pos2 sont dans la meme ligne, et Pos1 est une liigne au-dessus à Pos 2
    Pos1 = (L1, C1), Pos2 = (L2, C2), L1 == L2, C1 =< C2 , 
    positions_entre_colonnes(Pos1, Pos2, PositionsX),
    findall(Pos, (member(Pos, PositionsX), Pos \= Pos1, Pos \= Pos2), Positions);

    % Si Pos1 et Pos2 sont dans la meme ligne, et Pos1 est une ligne au-dessous à Pos2
    Pos1 = (L1, C1), Pos2 = (L2, C2), L1 == L2, C1 > C2 , 
    positions_entre_colonnes(Pos2, Pos1, PositionsX),
    findall(Pos, (member(Pos, PositionsX), Pos \= Pos1, Pos \= Pos2), Positions);
    % Si Pos1 et Pos2 ne sont pas dans la meme colonne ou ligne
    false.


positions_entre_lignes(Pos,Pos,[Pos]).
positions_entre_lignes(Pos1,Pos2,[Pos1|Q]) :-
    Pos1 = (L1,C),
    Pos2 = (L2,C),
    L1 =< L2,
    NextLigne is L1+1, positions_entre_lignes((NextLigne,_),Pos2,Q).

positions_entre_colonnes(Pos,Pos,[Pos]).
positions_entre_colonnes(Pos1,Pos2,[Pos1|Q]):-
    Pos1 = (L,C1),
    Pos2 = (L, C2),
    C1 =< C2,
    NextColonne is C1+1, positions_entre_colonnes((_,NextColonne),Pos2,Q).
% ------------------------------------------------------------------------------
% creer_pont/3 ----> creer_pont() fait un pont entre Pos1 et Pos2
% ------------------------------------------------------------------------------    

creer_pont(Pos1,Pos2,Pont):- Pos1 = (L1,_), Pos2 = (L2,_), L1 < L2, Pont = pont(Pos1,Pos2). % Cas01: Si Pos1 est à gauche de Pos2
creer_pont(Pos1,Pos2,Pont):- Pos1 = (L1,_), Pos2 = (L2,_), L1 > L2, Pont = pont(Pos1,Pos2). % Cas02: Pos1 est droite de Pos2 

creer_pont(Pos1,Pos2,Pont):- Pos1 = (_,C1), Pos2 = (_, C2), C1 =< C2,Pont = pont(Pos2,Pos1).% Cas03: Pos1 est au-dessus de Pos2    
creer_pont(Pos1,Pos2,Pont):- Pos1 = (_,C1), Pos2 = (_, C2), C1 > C2,Pont = pont(Pos2,Pos1). % Cas04: Pos1 est au-dessous de Pos2      
% ------------------------------------------------------------------------------
% chemin_livre/5 ----> chemin_livre() vérifie si l addition d un pont (Pos1,Pos2) fait que 
% deux iles laisse d être voisines   
% ------------------------------------------------------------------------------ 

chemin_livre(Pos1, Pos2, Positions,I,Vs):-
    I = ile(_,(L1,C1)),
    Vs = ile(_,(L2,C2)),
    chemin_livre_check(Pos1,Pos2,(L1,C1),(L2,C2),Positions).

chemin_livre_check(Pos1,Pos2,PosI,PosVs, _):- % Pos1 et Pos2 sont I et II 
    Pos1 == PosI,
    Pos2 == PosVs
    ;Pos1 == PosVs,
    Pos2 == PosI.

chemin_livre_check(_,_,(L1,C1),(L2,C2),Positions):-
    positions_entre((L1,C1), (L2,C2),PositionsVoisines), % verifie si un pont entre Pos1 et Pos2 n a pas aucune position en commun avec le pont I et II.
    findall(Pos, (member(Pos,Positions), member(Pos, PositionsVoisines)), PosCommun),
    length(PosCommun,Length),
    Length == 0.
    
% ------------------------------------------------------------------------------
% upgrade_voisines/5---> upgrade_voisines(Pos1,Pos2,Positions,Entree,NouvelleEntree)
% Les deux dernies arguments sont egales, à l exception de la liste des îles voisines
% ceci est mis à jour, supprimant les îles qui ne sont plus voisines, après l ajout du pont. 
% ------------------------------------------------------------------------------    

upgrade_voisines(Pos1,Pos2,Positions, [Ile,Voisines,R],NouvelleEntree):-
    include(chemin_livre(Pos1,Pos2,Positions,Ile), Voisines, VoisinesUpgrade),
    NouvelleEntree=[Ile,VoisinesUpgrade,R].

% ------------------------------------------------------------------------------
% upg_voisines_apres_pont/4
% upg_voisines_apres_pont(Etat, Pos1, Pos2, Nouveau_etat)
% Nouveau_etat est l etat obtenu après avoir fait l upgrade d Etat des iles voisines
% de chaque entrée    
% ------------------------------------------------------------------------------

upg_voisines_apres_pont(Etat, Pos1, Pos2, Nouveau_etat):-
    positions_entre(Pos1,Pos2,Positions),
    maplist(upgrade_voisines(Pos1,Pos2,Positions),Etat,Nouveau_etat).

% ------------------------------------------------------------------------------
% iles_done/2 ----> iles_done(Etat,IlesDone). IleDone est une liste des iles qui
% ont dèjà leurs ponts associés   
% ------------------------------------------------------------------------------

iles_done_ck([], []).
% Cas01: ile dejà terminé
iles_done_ck([[Ile, _, Ponts] | Q], [Ile | IlesDone]):-
    is_done(Ile, Ponts),
    iles_done_ck(Q,IlesDone).


% Cas02: ile n est pas encore complété ses ponts  
iles_done_ck([[Ile,_,Ponts]|Q],IlesDone):-
    not_done(Ile,Ponts), iles_done_ck(Q,IlesDone).

is_done(Ile,Ponts):- Ile= ile(N,_),length(Ponts,Length), N \== Length.

not_done(Ile, Ponts):-Ile=ile(N,_),length(Ponts,Length), N==Length.

iles_done(Etat,IlesDone):- iles_done_ck(Etat,IlesDone).
    
% ------------------------------------------------------------------------------
% remove_iles_done_ck/3 ----> remove_iles_done(IlesDone,Entree,NouvelleEntree)
% NouvelleEntree est le resultat d enlever les iles de IleDone
% de la liste des iles voisines d entree
% ------------------------------------------------------------------------------

remove_iles_done_ck(IlesDone, [Ile,Voisines,Ponts],NouvelleEntree):-
    % Trouver les iles communes dans Voisines et IlesDone
    findall(Ile1,(member(Ile1,Voisines),member(Ile1,IlesDone)),Icommun),
    % Enlever les voisines des iles communes
    findall(Ile2,(member(Ile2,Voisines), \+ member(Ile2,Icommun)),Voisines_removed)
    ,NouvelleEntree = [Ile,Voisines_removed,Ponts].

% Nouveau_etat est le résultat d appliquer remove_iles_done_ck à chaque entrée D Etat  
remove_iles_done(Etat, IlesDone,Nouveau_etat):-
    maplist(remove_iles_done_ck(IlesDone),Etat,Nouveau_etat).
% ------------------------------------------------------------------------------
% verifier_iles_done_ck/3 ---> verifier_ile_done_ck(IlesDones,Entree,NouvelleEntree)
% Si X ile d Entree appartient à Ilesdone, Le nombre de ponts de celle-ci est
% remplacé par la variable X, au contraire, les deux derniers Variables reste = 
% ------------------------------------------------------------------------------    

ck_ile(Ile,IleCked):-
    Ile = ile(_,(L1,C1)),
    IleCked=ile('X',(L1,C1)).

    ck_iles_done(IlesDone,Entree,NouvelleEntree):-
    Entree = [Ile,_,_],
    findall(X,(member(X,IlesDone), X == Ile),Icommun),
    length(Icommun,Length),
    Length == 0, 
    NouvelleEntree=Entree ; Entree = [Ile,Voisines,Ponts],
    findall(X,(member(X,IlesDone), X == Ile), Icommun),
    length(Icommun,Length),
    Length \== 0,
    Icommun = [IleToCk|_],
    ck_ile(IleToCk,IleCked),
    NouvelleEntree = [IleCked,Voisines,Ponts].
    % En cas d avoir des iles à marquer 

% -----------------------------------------------------------------------------
% iles_done/3 ---> iles_done(Etat, IlesDone, Nouveau_etat)
% Nouveau_etat est le résultat d appliquer le prédicat précédent ck_iles_done/3
% à chacune des entrées d Etat
% ------------------------------------------------------------------------------

iles_done(Etat, IlesDone, Nouveau_etat) :-
    maplist(ck_iles_done(IlesDone), Etat, Nouveau_etat).
   

% ------------------------------------------------------------------------------
% joint_ponts/5 ---> joint_ponts(Etat, Num_ponts, Ile1, Ile2, Nouveau_etat)
% Nouveau_etat est l état obtenu quand on ajout Num_ponts
% entre Ile1 et Ile2.
% sans = SANS et COM = avec
% ------------------------------------------------------------------------------

ajout_ponts_aux(_,_,_, [], []).

ajout_ponts_aux(Pont, Ile1, Ile2, [ Entree | R], [ [Ile1, Vs, [Pont]] | EtatAvecPont]) :-
    Entree = [Ile , Vs , _],
    Ile == Ile1,
    ajout_ponts_aux(Pont, Ile1, Ile2, R, EtatAvecPont).

ajout_ponts_aux(Pont, Ile1, Ile2, [ Entree | R], [ [Ile2, Vs, [Pont]] | EtatAvecPont]) :-
    Entree = [Ile , Vs , _],
    Ile == Ile2,
    ajout_ponts_aux(Pont, Ile1, Ile2, R, EtatAvecPont).

ajout_ponts_aux(Pont, Ile1, Ile2, [ Entree | R], EtatAvecPont) :-
    Entree = [Ile , _ , _],
    Ile \== Ile1,
    Ile \== Ile2,
    ajout_ponts_aux(Pont, Ile1, Ile2, R, EtatAvecPont).

ajout_ponts(Pont, Ile1, Ile2, Etat, EtatAvecPont) :-
    ajout_ponts_aux(Pont, Ile1, Ile2, Etat, EtatAvecPont).


changer_entrees_ponts(Etat, PontsAjoutes, EtatAvecPonts) :-
    maplist(changer_entrees_ponts_aux(PontsAjoutes), Etat, EtatAvecPonts).

changer_entrees_ponts_aux(PontsAjoutes, Entree, NouvelleEntree) :-
    Entree = [Ile, _, _],
    member([Ile, _, _], PontsAjoutes),
    findall(X, (member( X, PontsAjoutes), X = [Ile, _ , _]), NouvelleEntree).

changer_entrees_ponts_aux(PontsAjoutes, Entree, NouvelleEntree):-
    Entree = [Ile, _, _],
    \+ member([Ile, _, _], PontsAjoutes),
    NouvelleEntree = Entree.

pont_meme_ile_aux(_, [], []).

pont_meme_ile_aux(EntreeSansPont, [T | R], EntreeAvecPont):-
    EntreeSansPont = [Ile, _, _],
    member(Ile,T), pont_meme_ile_aux(EntreeSansPont, R, EntreeAvecPont).

pont_meme_ile(EntreeSansPont, EntreeAvecPonts, EntreeAvecPont) :-
    EntreeSansPont = [Ile, _, _],
    pont_meme_ile_aux(Ile, EntreeAvecPonts, EntreeAvecPont).

appel(E, P1, P2, E2) :-
    upg_voisines_apres_pont(E, P1, P2, E2).

joint_ponts(Etat, Num_ponts, Ile1, Ile2, Nouveau_etat) :-
    Ile1 = ile(_, Pos1),
    Ile2 = ile(_, Pos2),
    creer_pont(Pos1, Pos2, Pont),
    ajout_ponts(Pont, Ile1, Ile2, Etat, PontsAjoutes),
    changer_entrees_ponts(Etat, PontsAjoutes, EtatAvecPonts),
    appel(EtatAvecPonts, Pos1, Pos2, EtatActualiser),
    writeln(EtatActualiser).

% ---------------------------------------------------------------------------------------------------
% différents puzzles hashi pour tester le solver
% test01: exemple rapport
puzzle_hashi(1,Puz):- Puz =
    [[2,0,0,2,0,0,2],
     [0,3,0,0,4,0,0],
     [0,0,0,0,0,0,3],
     [0,0,0,2,0,0,0],
     [0,0,0,0,0,0,0],
     [0,3,0,4,0,0,0],
     [3,0,0,0,6,0,4]].



% ------------------------------------------------------------------------------




%-------------------------------------------------------------------------------
%                ecrire_Puzzle(Puzzle, Etat)
%-------------------------------------------------------------------------------

% ecrire_Puzzle(Puzzle, Etat) et ecrire_diferences(Etat1, Etat2)

ecrire_Puzzle(Puz, Etat):-
    findall(Ps, (member([_,_,Ps], Etat), Ps \= []), List_list_ponts),
    tirer_copies(List_list_ponts, List_ponts),
    divide_ponts(List_ponts, Ponts_horizontals, Ponts_verticals),
    maplist(positions_ponts, Ponts_horizontals, Positions_horizontals_temp),
    maplist(positions_ponts, Ponts_verticals, Positions_verticals_temp),
    append(Positions_horizontals_temp, Positions_horizontals),
    append(Positions_verticals_temp, Positions_verticals),
    process_horizontals(Puz, Positions_horizontals, Temp),
    process_verticals(Temp, Positions_verticals, N_Puz),
    ecrire_final(N_Puz).

ecrire_pont(Pont) :-
    integer(Pont), Pont > 0, !, write(' '), write(Pont), write(' ')
                                ;
     Pont == 0, !, write('   ')
                           ;
     Pont == '||', !, write(' '), write('"'), write(' ')
                      ;
    write(' '), write(Pont), write(' ').

ecrire_ligne(L) :-
    maplist(ecrire_pont, L), nl.

ecrire_final(Puz) :-
    maplist(ecrire_ligne, Puz).
    
tirer_repetitive(List_list_ponts, List_ponts) :-
    tirer_repetitive(List_list_ponts, List_ponts, []).

tirer_repetitive([], Exist, Exist) :- !.
tirer_repetitive([H | R], List_ponts, Exist) :-
    maplist(subtract_inv(H), R, N_R),
    append(Exist, H, N_Exist),
    tirer_repetitive(N_R, List_ponts, N_Exist).

subtract_inv(L1, L2, Res) :- subtract(L2, L1, Res).

pont_horizontal(pont((L,_),(L,_))).
pont_vertical(pont((_, C), (_, C))).

divide_ponts(Ponts, Ponts_horizontals, Ponts_verticals) :-
    include(pont_horizontal, Ponts, Ponts_horizontals),
    subtract(Ponts, Ponts_horizontals, Ponts_verticals).

positions_pont(pont(P1, P2), Ps) :- positions_entre(P1, P2, Ps).

process_horizontals(Puz, Positions_horizontals, N_Puz) :-
    transformer(Puz, process_horizontal, [], Positions_horizontals, N_Puz).

process_verticals(Puz, Positions_verticals, N_Puz) :-
    transformer(Puz, process_vertical, [], Positions_verticals, N_Puz).

process_horizontal(Puz, Pos, N_Puz) :-
    mat_ref(Puz, Pos, Cont),
    (Cont = 0, !, mat_change_position(Puz, Pos, '-', N_Puz) ;
     mat_change_position(Puz, Pos, '=', N_Puz)).

process_vertical(Puz, Pos, N_Puz) :-
    mat_ref(Puz, Pos, Cont),
    (Cont = 0, !, mat_change_position(Puz, Pos, '|', N_Puz)
                               ;
     mat_change_position(Puz, Pos, '||', N_Puz)).

%-----------------------------------------------------------------------------
% mat_ref(Mat, Pos, Cont):
%-----------------------------------------------------------------------------
mat_ref(Mat, (L, C), Cont) :-
    nth1(L, Mat, Ligne),
    nth1(C, Ligne, Cont).
%-----------------------------------------------------------------------------
% mat_change_position(Mat, Pos, Cont, N_Mat):
% N_Mat est le resultat de changer le contenu de position Pos
% de Mat por Cont.
% -----------------------------------------------------------------------------

mat_change_position(Mat, (L,C), Cont, N_Mat) :-
    nth1(L,Mat,Ligne),
    mat_change_ligne(Ligne,C,Cont, N_Ligne),
    mat_change_ligne(Mat,L,N_Ligne, N_Mat),!.

%-----------------------------------------------------------------------------
% mat_change_positions(Mat, List_Positions, List_Cont, N_Mat):
% N_Mat est le resultat de changer le contenu des positions de
% List_Positions de Mat par les elements correspondants de List_Cont.
%-----------------------------------------------------------------------------
mat_changer_positions(Mat, [], _, Mat) :- !.

mat_changer_positions(Mat, [Pos | R_Pos], [Cont | R_Cont], N_Mat) :-
    mat_change_position(Mat, Pos, Cont, Temp),
    mat_changer_positions(Temp, R_Pos, R_Cont, N_Mat).

%-----------------------------------------------------------------------------
% mat_change_ligne(Mat, L, N_Ligne_L, N_Mat):
% N_Mat est le resultat de remplacer la ligne L de Mat
% por N_Ligne_L.
%-----------------------------------------------------------------------------
mat_change_ligne([_|Q], 1, N_Ligne_L, [N_Ligne_L|Q]) :- !.

mat_muda_ligne([H|Q], L, N_Ligne_L, [H|R]):-
    L > 0,
    NL is L-1,
    mat_change_ligne(Q, NL, N_Ligne_L, R), !.

%-----------------------------------------------------------------------------
% transformer 
%-----------------------------------------------------------------------------
% transformer(Est, Pred, Args, Lst, N_Est).
% Pred (Est, Args, El_Lst, N_est)

transformer(Est, _, _, [], Est).

transformer(Est, Pred, Args, [P | R], N_Est) :-
    append([[Est], Args, [P, Temp]], All_args),
    On =.. [Pred | All_args],
    call(On),
    transformer(Temp, Pred, Args, R, N_Est).

%-----------------------------------------------------------------------------
% Comparaison des etats
%-----------------------------------------------------------------------------
compare_etats(Est1, Est2, Difs) :-
    length(Est1, N_Ents),
    findall([Ent1, Ent2],
            (between(1, N_Ents, I), nth1(I, Est1, Ent1), nth1(I, Est2, Ent2), Ent1 \= Ent2),
            Difs).

ecrire_diferences(Est1, Est2) :-
    compare_etats(Est1, Est2, Difs),
    maplist(ecrire_dif, Difs).

ecrire_dif([Ent1, Ent2]) :-
    writeln(Ent1),
    writeln('passer a'),
    writeln(Ent2),
    nl.
    
