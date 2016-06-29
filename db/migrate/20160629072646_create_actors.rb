class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :name
      t.text :biography
      t.string :gender

      t.timestamps null: false
    end
  end
end
