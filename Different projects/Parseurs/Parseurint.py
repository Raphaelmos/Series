import xml.etree.ElementTree as ET

adjectifs = {

  "Petit": {
    "Très peu": 1,
    "Peu": 2,
    "Moyennement": 3, 
    "Assez": 4,
    "Beaucoup": 5,
    "Énormément": 6
  },

  "Grand": {
    "Très peu": 7,
    "Peu": 8,
    "Moyennement": 9,
    "Assez": 10,
    "Beaucoup": 11,  
    "Énormément": 12
  },

  "Beau": {
    "Très peu": 13,
    "Peu": 14,
    "Moyennement": 15,
    "Assez": 16,
    "Beaucoup": 17,
    "Énormément": 18  
  },

  "Rapide": {
   "Très peu": 19,
   "Peu": 20,  
   "Moyennement": 21,
   "Assez": 22,
   "Beaucoup": 23,
   "Énormément": 24
  },

  "Lent": {
    "Très peu": 25,
    "Peu": 26,
    "Moyennement": 27,
    "Assez": 28,
    "Beaucoup": 29,
    "Énormément": 30
  },

  "Cher": {
    "Très peu": 31,
    "Peu": 32,    
    "Moyennement": 33,
    "Assez": 34,
    "Beaucoup": 35,
    "Énormément": 36
  },

  "Bon": {
   "Très peu": 37,   
   "Peu": 38,
   "Moyennement": 39,
   "Assez": 40, 
   "Beaucoup": 41,
   "Énormément": 42
  }

}

tree = ET.ElementTree(ET.Element("text"))
root = tree.getroot()

current_phrase = ""
current_intensite = 0

with open("texte.txt") as f:

  for line in f:

    if line.startswith("<"):  
      current_intensite = int(line[1:-1])

    else:
    
      words = line.split()

      for word in words:
      
        if word in adjectifs:
        
          intensite = adjectifs[word][current_intensite]
          
          element = ET.Element("w", attrib={
            "word": word,
            "int": str(intensite)  
          })
          
          root.append(element)
          
      if line.endswith("."):
      
        phrase = ET.Element("p")
        phrase.text = current_phrase
        root.append(phrase)
      
        current_phrase = ""

tree.write("output.xml")