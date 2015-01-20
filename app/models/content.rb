class Content < ActiveRecord::Base
  has_many :galleries, dependent: :destroy
end
