class CreateReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews do |t|
      t.text :non_spoiler_text, null: false
      t.text :spoiler_text
      t.text :foreshadowing
      t.integer :rating, null: false
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.timestamps
    end

    add_index :books, :title
    add_index :reviews, :rating
  end
end
