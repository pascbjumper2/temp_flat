class AddPhotoToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :image_file_name, :string
    add_column :galleries, :image_content_type, :string
    add_column :galleries, :image_file_size, :integer
    add_column :galleries, :image_updated_at, :datetime
  end
end
