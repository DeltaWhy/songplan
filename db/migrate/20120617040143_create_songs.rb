class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :slug
      t.string :author
      t.string :short_author
      t.string :copyright
      t.string :ccli_number
      t.string :original_key
      t.text :chords
      t.string :default_order
      t.boolean :two_columns
      t.string :tags
      t.text :notes

      t.timestamps
    end

    add_index :songs, :slug
  end
end
