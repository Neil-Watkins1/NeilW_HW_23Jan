require_relative('../db/sql_runner')

class Artist

  attr_accessor :artist_name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @artist_name = options['artist_name']

  end

  def save
    sql = "INSERT INTO artists
    (artist_name)
    VALUES ($1) RETURNING id;"
    values = [@artist_name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i

  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map {|artist| Artist.new(artist)}

  end


  def albums_by_artist()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    albums = results.map { |album| Album.new(album) }
    return albums
  end

  def update()
    sql = "UPDATE artists SET artist_name = $1 WHERE id = $2"
    values = [@artist_name, @id]
    sqlRunner.run(sql, values)

  end

  def delete()
    sql = "DELETE FROM artists where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    artist = Artist.new(result.first)
    return artist

  end
end

  
