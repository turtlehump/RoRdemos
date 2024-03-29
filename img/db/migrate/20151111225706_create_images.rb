class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name    , default: "Pic"
      t.string :filename
      t.boolean :private
      t.references :user,  index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
