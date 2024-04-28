# scrapmovie.py


"""

  details['title'] = soup.find('h1').text

  release_date = soup.find('p', class_="meta-body-item meta-body-info").text
  details['release_date'] = release_date.split('|')[0].strip()

  runtime = release_date.split('|')[1].strip()
  details['runtime'] = runtime

  genre = release_date.split('|')[2].strip()
  details['genre'] = genre

  synopsis = soup.find('div', class_="synopsis").text
  details['synopsis'] = synopsis

  critics_review = soup.find('div', class_="content-txt review-card-content")
  details['critics_review'] = critics_review
  required_fields = ['titre', 'date_sortie']

  if all(field in details for field in required_fields):
    movies.append(details)

if __name__ == '__main__':
  get_movie_details()

"""































