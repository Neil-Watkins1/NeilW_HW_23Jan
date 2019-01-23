require_relative('../db/sql_runner')

class Album

  attr_accessor :album_name, :genre, :artist_id
  attr_reader :id

  def initialize(options)
    @album_name = options['album_name']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
    @id = options['id'].to_i if options['id']

  end


  def save()
    sql = "INSERT INTO Albums
    (
      album_name,
      genre,
      artist_id
      ) VALUES
      ($1, $2, $3)
      RETURNING id"
      values = [@album_name, @genre, @artist_id]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i

    end

    def self.delete_all()
      sql = "DELETE FROM albums"
      SqlRunner.run(sql)

    end

    def self.all()
      sql = "SELECT * FROM albums"
      albums = SqlRunner.run(sql)
      result =  albums.map { |album| Album.new(album)}
      return result
    end

    def artist_of_album
      sql = "SELECT * FROM albums where id = $1"
      values = [@id]
      results = SqlRunner.run(sql, values)
      artist = results.map { |artist| Artist.new(artist)}
      return artist

    end


    def update
        sql = "UPDATE albums SET album_name = $1, genre = $2, artist_id = $3 WHERE id = $4"
        values = [@album_name, @genre, @artist_id, @id]
        SqlRunner.run(sql, values)
      end

      def delete()
        sql = "DELETE FROM albums where id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
      end

      def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    album = Album.new(result.first)
    return album
  end

end
