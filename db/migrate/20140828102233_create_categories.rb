class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :tags

      t.timestamps
    end
  end
end
