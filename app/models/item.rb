class Item < ActiveRecord::Base
  belongs_to :user

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://placehold.it/200x200"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  
end