require("pry")
require_relative("../models/artists")
require_relative("../models/albums")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({'artist_name' => 'Florence and the Machine'})

artist1.save()

artist2 = Artist.new({'artist_name' => 'Paolo Nutini'})

artist2.save()

artist3 = Artist.new({'artist_name' => 'Metallica'})

artist3.save()

album1 = Album.new({
  'album_name' => 'Lungs',
  'genre' => 'Pop',
  'artist_id' => artist1.id})

  album1.save()

  album2 = Album.new({
    'album_name' => 'Candy',
    'genre' => 'Pop',
    'artist_id' => artist2.id})

    album2.save()

    album3 = Album.new({
      'album_name' => 'Master of Puppets',
      'genre' => 'metal',
      'artist_id' => artist3.id})

      album3.save()

Album.all()
Artist.all()

artist2.albums_by_artist()
album1.artist_of_album()


binding.pry
nil
