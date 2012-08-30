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
end
