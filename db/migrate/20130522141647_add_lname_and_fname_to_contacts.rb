class AddLnameAndFnameToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :lname, :string, :required=>true
    add_column :contacts, :fname, :string, :required=>true

    remove_column :contacts, :name
  end
end
