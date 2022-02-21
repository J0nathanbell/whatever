require 'nokogiri'
require 'open-uri'

url = "https://www.imdb.com/search/title/?count=100&groups=top_1000&sort=user_rating"
html = Nokogiri::HTML(URI.open(url).read, nil, "utf-8")

html.search(".lister-item-content").each do |element|
  title = element.search("h3 a").text.strip
  year = element.search(".lister-item-year").text.strip
  year = year[1..4].to_i
  movie = Movie.new(title: title, year: year)
  element.search(".genre").text.strip.split(', ').each do |sub_genre|
    genre = Genre.find_or_create_by(name: sub_genre)
    MovieGenre.create(movie: movie, genre: genre)
  end
end

Food.create!(dish: 'Kinder Bueno', image: 'https://tastyk-4ec7.kxcdn.com/wp-content/uploads/2017/07/square.jpg')
Food.create(dish: 'Snickers', image: 'https://www.addictedtodates.com/wp-content/uploads/2018/05/vegan-snickers-bars-e1618072898213.jpg')
