class ChangeTimesAndUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :jogging_times, :time, :integer
    add_column :jogging_times, :average_speed, :float
    add_column :users, :role, :integer, limit: 2, default: 0
  end
end
