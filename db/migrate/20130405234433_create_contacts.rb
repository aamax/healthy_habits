
class CreateContacts < ActiveRecord::Migration

  def change

    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.hstore :meta_data

      t.timestamps
    end
  end
end

