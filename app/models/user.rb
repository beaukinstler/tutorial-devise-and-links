# User class generated with the 'Devise' gem
# Each user can have 0 to many 'Bookmarks'
#  and may be an admin if the 'admin' bool value is set to 'true'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many:bookmarks
end
