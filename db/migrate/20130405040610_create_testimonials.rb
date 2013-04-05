class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.string :name
      t.text :comment
      t.date :date

      t.timestamps
    end
  end
end
