class AddOtypeToOperations < ActiveRecord::Migration[7.0]
  def change
    add_reference :operations, :otype, null: false, foreign_key: true
  end
end
