# == Schema Information
#
# Table name: contacts
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  email         :string(255)
#  meta_data     :hstore
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  notifications :boolean          default(TRUE)
#  ezine         :boolean          default(TRUE)
#  group         :string(255)      default("WEB")
#

class Contact < ActiveRecord::Base
  attr_accessible :email, :name, :meta_data, :ezine, :group, :notifications

  # TODO don't allow duplicates
  # TODO after create: send welcome email if group="WEB"
  # TODO      else - prompt to send welcome email
end
