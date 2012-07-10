class Song < ActiveRecord::Base
  attr_accessible :author, :ccli_number, :chords, :copyright, :default_order, :notes, :original_key, :short_author, :slug, :tags, :title, :two_columns

  validates_presence_of :author, :chords, :original_key, :slug, :title
  validates_uniqueness_of :ccli_number, :slug
  validates :original_key, :inclusion => { :in => ['Ab', 'A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'F#', 'Gb', 'G'] }
end
