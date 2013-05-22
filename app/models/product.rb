# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  amount      :float
#  product_id  :string(255)
#  active      :boolean
#  partial     :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ActiveRecord::Base
  attr_accessible :active, :amount, :description, :name, :partial, :product_id
end
