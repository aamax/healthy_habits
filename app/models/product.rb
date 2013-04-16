class Product < ActiveRecord::Base
  attr_accessible :active, :amount, :description, :name, :partial, :product_id
end
