class AddBodyToCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :categories, :body, :text
  end
end
