# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  meta_data  :hstore
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contact < ActiveRecord::Base
  attr_accessible :email, :name, :meta_data

  # TODO don't allow duplicates
  # TODO after create: send welcome email if group="WEB"
  # TODO      else - prompt to send welcome email
end
