# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"
require "open-uri"

puts "cleaning database"
Bookmark.destroy_all
Movie.destroy_all
puts "creating movies"

url = "https://tmdb.lewagon.com/movie/top_rated"
data_raw = URI.open(url).read
data = JSON.parse(data_raw)

url = ""
data_raw = URI.open(url).read
data = JSON.parse(data_raw)

infos = data["results"]

infos.each do |info|
  poster_url = "https://image.tmdb.org/t/p/original/#{info["poster_path"]}"
  file = URI.open(poster_url)
  movie = Movie.new(title: info["original_title"],
                    overview: info["overview"],
                    poster_url: poster_url,
                    rating: info["vote_average"])
  movie.photo.attach(io: file, filename: "#{info["original_title"].gsub(" ", "-")}.png", content_type: "image/png")
  movie.save

  infos.each do |info|
    poster_url = "/#{info["poster_path"]}"
    file = URI.open(poster_url)
    movie = Movie.new(title: info["original_title"],
                      overview: info["overview"],
                      poster_url: poster_url,
                      rating: info["vote_average"])
    movie.photo.attach(io: file, filename: "#{info["original_title"].gsub(" ", "-")}.png", content_type: "image/png")
    movie.save
end
