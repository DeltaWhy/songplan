class Song < ActiveRecord::Base
  VALID_KEYS = ['Ab', 'A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'F#', 'Gb', 'G']
  attr_accessible :author, :ccli_number, :chords, :copyright, :default_order, :notes, :original_key, :short_author, :slug, :tags, :title, :two_columns

  validates_presence_of :author, :chords, :original_key, :slug, :title
  validates_uniqueness_of :slug
  validates :original_key, :inclusion => { :in => VALID_KEYS }

  default_scope :order => 'title ASC'

  def get_short_author
    self.short_author.present? ? self.short_author : self.author
  end

  def transpose(key)
    note_numbers = {'Ab'=>0, 'A'=>1, 'A#'=>2, 'Bb'=>2, 'B'=>3, 'C'=>4,
        'C#'=>5, 'Db'=>5, 'D'=>6, 'D#'=>7, 'Eb'=>7, 'E'=>8, 'F'=>9,
        'F#'=>10, 'Gb'=>10, 'G'=>11, 'G#'=>0}
    if ['G','D','A','E','B','F#'].include?(key)
      number_notes = {0=>'G#', 1=>'A', 2=>'A#', 3=>'B', 4=>'C', 5=>'C#',
          6=>'D', 7=>'D#', 8=>'E', 9=>'F', 10=>'F#', 11=>'G'}
    else
      number_notes = {0=>'Ab', 1=>'A', 2=>'Bb', 3=>'B', 4=>'C', 5=>'Db',
          6=>'D', 7=>'Eb', 8=>'E', 9=>'F', 10=>'Gb', 11=>'G'}
    end

    transpose_factor = note_numbers[key] - note_numbers[original_key]
    new_chords = ""
    chords.lines.each do |line|
      line.rstrip!
      unless line =~ /^[\s]*([A-G][\w#+-\/]*[\s]*)*$/
        new_chords += line + "\n"
        next
      end

      if line =~ /(?i)(chorus|bridge|because|forever)/
        new_chords += line + "\n"
        next
      end

      line.gsub!(/(^|[\s]|\/|-)([A-G][#b]?)/) do |match|
        $1 + number_notes[(note_numbers[$2]+transpose_factor)%12]
      end
      new_chords += line + "\n"
    end

    return new_chords
  end

  def self.is_header(line)
    line =~ /(?i)^[\s(\[]*(intro|tag|ending|chorus|verse|bridge|pre[-]?chorus)[\s]*[\d]*[)\]:]*[\s]*(\(.*\))?[\s]*$/
  end
end
