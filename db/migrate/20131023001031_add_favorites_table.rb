class AddFavoritesTable < ActiveRecord::Migration
 def up
    create_table :favorites do |t|
    t.string :address
    t.datetime "created_at"
    t.datetime "updated_at"
   t.references :favorable, :polymorphic => true
    end
    add_reference :favorites, :user
  end

  def down
    drop_table :favorites
    end
end
