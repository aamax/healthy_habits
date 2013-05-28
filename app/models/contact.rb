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

class Contact < ActiveRecord::Base
  attr_accessible :email, :fname, :lname, :meta_data, :ezine, :group, :notifications

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates   :fname, :presence => true

  validates   :lname, :presence => true

  validates   :email,
              :presence => true,
              :format => { :with => email_regex },
              :uniqueness => { :case_sensitive => false }
end
