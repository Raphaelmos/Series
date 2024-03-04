

# Parser le texte et mettre des balises autour des phrases  puis parcours les phrases et essaye d'identifier le contexte et cherche les differents mots dans une boucle 

import re

results = {}

with open('miserables.txt') as f:
    texte = f.read()
    
phrases = re.split(r'[.?]', texte)
texte_parse = ''
for phrase in phrases:
    texte_parse += '<phrase>' + phrase + '</phrase>'
    
for phrase in re.findall(r'<phrase>(.*?)</phrase>', texte_parse):

    mot_avant = re.search(r'(\w+\s+)([lela]?[^\s]+)', phrase).group(1)

    if mot_avant in ['je', 'tu', 'il', 'elle', 'nous', 'vous', 'ils', 'elles']:
        type = "Pronom personnel"
    elif mot_avant in ['chez', 'dans', 'de', 'entre', 'jusque', 'hors', 'par', 'pour',  
                      'sans', 'vers']: 
        type = "Article défini"
    elif mot_avant.endswith('s') or mot_avant.endswith('nt'):
        type = "Verbe"
    else:
        type = "Autre cas"
        
    article = re.search(r'(\w+\s+)([lela]?[^\s]+)', phrase).group(2)    
    results[article] = type
    
print(results)