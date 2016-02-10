class Order < ActiveRecord::Base
  belongs_to :item

  enum status: [:unfulfilled, :processing, :shipped, :fulfilled]

  before_save {self.status ||= :unfulfilled}
end
