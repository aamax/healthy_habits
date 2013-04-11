class AddThumbnailToTestimonials < ActiveRecord::Migration
  def self.up
    add_attachment :testimonials, :thumbnail
  end

  def self.down
    remove_attachment :testimonials, :thumbnail
  end
end
