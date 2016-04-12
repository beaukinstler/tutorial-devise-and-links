# A simple clasee for saving urls and friendly names to a database
class Bookmark < ActiveRecord::Base
  belongs_to:user
  #validates :user_id, presence: true
  validates :title, length: {minimum: 10, maximum: 254}, presence: true
  validates :url, presence: true
  validates :url, format: { with: URI.regexp }, allow_blank: true
end
