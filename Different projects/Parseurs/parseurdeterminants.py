

# Parser le texte et mettre des balises autour des phrases  puis parcours les phrases et essaye d'identifier le contexte et cherche les differents mots dans une boucle 

import re

with open('miserables.txt.txt', encoding='utf-8') as f:
  text = f.read()
  
phrases = re.split(r'[.?]', text)

for phrase in phrases:
  nb_l = len(re.findall(r"l'", text))
  mots = re.split(r'\s+', phrase)
  
  for i, mot in enumerate(mots):
    
    if mot in ['le', 'la', 'l', 'les', ]:
      
      article = mot
      
      mot_precedent = mots[i-1]
      
      if mot_precedent in ['je', 'tu', 'il', 'elle', 'nous', 'vous', 'ils', 'elles']:
        type_precedent = "Pronom personnel"  
        
      elif mot_precedent in ['chez', 'dans', 'de', 'entre', 'jusque', 'hors', 'par', 'pour',  
                      'sans', 'vers', 'après', 'avec', 'contre', 'malgré','outre','sous','suivant','durant', 'jusqu’à', 'moyennant', 'nonobstant','pendant','quoique','suivant','touchant' ]:
        type_precedent = "Article défini"
        
      elif mot_precedent.endswith('s') or mot_precedent.endswith('nt'):
        type_precedent = "Verbe"
        
      else:
        type_precedent = "Autre cas"
      
     

       
      print(f"Phrase: <p>{phrase}</p>")
      print(f"{type_precedent} : {mot_precedent}, Déterminant : {article}")
   # A modifier pour avoir les déterminants intégré dans des balises aussi 
print(f"Nombre d'occurrences de 'l': {nb_l}") 

        
    article = re.search(r'(\w+\s+)([lela]?[^\s]+)', phrase).group(2)    
    results[article] = type
    
print(results)
