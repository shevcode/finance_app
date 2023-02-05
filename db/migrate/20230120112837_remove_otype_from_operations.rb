class RemoveOtypeFromOperations < ActiveRecord::Migration[7.0]
  def change
    # this migration was created mistakenly, column otype didn't exist before this migration
    #remove_column :operations, :otype, :integer
  end
end
