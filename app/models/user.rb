class User
  include MongoMapper::Document
  many :albums
  devise :registerable, :authenticatable, :recoverable, :rememberable, :trackable, :validatable

end
