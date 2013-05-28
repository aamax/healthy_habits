# == Schema Information
#
# Table name: contacts
#
#  id            :integer          not null, primary key
#  email         :string(255)
#  meta_data     :hstore
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  notifications :boolean          default(TRUE)
#  ezine         :boolean          default(TRUE)
#  group         :string(255)      default("WEB")
#  lname         :string(255)
#  fname         :string(255)
#

require 'spec_helper'

describe Contact do
  it "must not save with an invalid email address" do
    contact = Contact.new
    contact.email = "foo"
    contact.fname = "bar"
    contact.lname = "baz"

    contact.save.should == false
  end

  it "must not save without an fname" do
    contact = Contact.new
    contact.email = "foo@example.com"
    contact.fname = ""
    contact.lname = "baz"

    contact.save.should == false
  end

  it "must not save without an lname" do
    contact = Contact.new
    contact.email = "foo@example.com"
    contact.fname = ""
    contact.lname = "baz"

    contact.save.should == false
  end

  it "must save with valid params" do
    contact = Contact.new
    contact.email = "foo@example.com"
    contact.fname = "bar"
    contact.lname = "baz"

    contact.save.should == true
  end


end
