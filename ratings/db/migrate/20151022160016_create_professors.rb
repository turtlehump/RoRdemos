class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.string :first
      t.string :last
      t.string :university

      t.timestamps null: false
    end
  end
end
