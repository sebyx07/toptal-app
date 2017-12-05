class CreateJoggingTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :jogging_times do |t|
      t.float :distance
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
