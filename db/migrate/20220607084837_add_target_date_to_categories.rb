class AddTargetDateToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :target_date, :datetime
  end
end
