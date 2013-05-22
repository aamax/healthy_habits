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
  pending "add some examples to (or delete) #{__FILE__}"
end
