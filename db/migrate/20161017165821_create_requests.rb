class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :name
      t.string :email
      t.string :department
      t.text :message
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
