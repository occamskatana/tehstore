class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   before_save {self.email = email.downcase}
   before_save {self.role ||= :user}


   enum role: [:user, :fulfiller, :admin]

   has_many :items, dependent: :destroy
   has_many :favorites, dependent: :destroy

   def favorite_for(item)
   	favorites.where(item_id: item.id).first
   end
end
