class RemoveTypeFromOperations < ActiveRecord::Migration[7.0]
  def change
    remove_column :operations, :type, :integer
  end
end
