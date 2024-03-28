# Scraper / Crawler 

import scrapy 
import json
import csv

# Take infos to know if a game is worth it with multiple infos : Price / Player base / editor / ratings / studio ( Metacritic / Steam / Howlongtobeat.com )


  def parse(self, response):

    # Get links to browse pages
    for page_num in range(1, 601):
      browse_url = f'{self.start_urls[0]}?page={page_num}'  
      yield response.follow(browse_url, self.parse_browse_page)

  def parse_browse_page(self, response):

    # Extract movie listing tiles 
    for movie in response.css('div.title'):  

      # Yield request to individual movie page 
      movie_url = movie.css('a::attr(href)').get()  
      yield response.follow(movie_url, self.parse_movie)
      
      # Yield movie data from listing
      yield {

      }

 def parse_movie(self, response):
   yield {

   }

if __name__ == '__main__':
   process = CrawlerProcess()
   process.crawl(sSpider)
   process.start()

