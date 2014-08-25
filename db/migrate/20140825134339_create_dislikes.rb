class CreateDislikes < ActiveRecord::Migration
  def change
    create_table :dislikes do |t|

      t.timestamps
    end
  end
end
