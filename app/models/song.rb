class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def genre_name=(name)
    self.genre = Genre.find_by(name: name)
  end

  def genre_name
    self.genre ? self.genre.name : nil
  end

  def note_contents=(contents)
    contents.each do |note|
      if note.to_s != "" 
        self.notes << Note.create(content: note)
      end
    end
  end

  def note_contents
    self.notes.map(&:content) if self.notes.any?
  end
end
