require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('pry')
also_reload('lib/**/*.rb')

get('/') do
  @albums = Album.sorted
  erb(:albums)
end

get('/albums') do
  @albums = Album.sorted
  erb(:albums)
end

post('/albums') do
  name = params[:album_name]
  artist = params[:album_artist]
  year = params[:album_year]
  genre = params[:album_genre]

  album = Album.new(name, artist, year, genre, nil)
  album.save()
  @albums = Album.sorted
  erb(:albums)
end

get('/albums/new') do
  erb(:new_album)
end

get('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  erb(:album)
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:album_name], params[:album_artist], params[:album_year], params[:album_genre])



  @albums = Album.sorted
  erb(:albums)
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.sorted
  erb(:albums)
end

get('/search') do
  @search = params[:query]
  @albums = Album.search(params[:query])
  erb(:search)
end
