class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :description
      t.boolean :posts_visible_to_all

      t.timestamps
    end
  end
end
