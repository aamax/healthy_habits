class AddFieldsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :notifications, :boolean, :default => true
    add_column :contacts, :ezine, :boolean, :default => true
    add_column :contacts, :group, :string, :default => "WEB"
  end
end
