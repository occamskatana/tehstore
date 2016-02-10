class Order < ActiveRecord::Base
  belongs_to :item

  before_save {self.fulfilled ||= false}
end
