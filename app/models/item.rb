class Item < ActiveRecord::Base
  has_many :orders

	acts_as_taggable
	ActsAsTaggableOn.force_lowercase = true

  belongs_to :user
  has_many :favorites, dependent: :destroy

  has_attached_file :avatar, styles: { large: "450x450>", medium: "300x300>", thumb: "100x100>" }, default_url: "http://placehold.it/100x100"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  default_scope {order('created_at DESC')}

  def self.search(search)
  	where("title LIKE :search OR country LIKE :search", search: "%#{search}%")  
  end
  
  self.per_page = 10
end
