# == Schema Information
#
# Table name: testimonials
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  comment                :text
#  date                   :date
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  thumbnail_file_name    :string(255)
#  thumbnail_content_type :string(255)
#  thumbnail_file_size    :integer
#  thumbnail_updated_at   :datetime
#

class Testimonial < ActiveRecord::Base
  attr_accessible :comment, :date, :name, :thumbnail

  has_attached_file :thumbnail, :styles => {:thumb => "100x100>" }
end
