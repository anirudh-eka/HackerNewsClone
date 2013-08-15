class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  validates_uniqueness_of :username
  validates_presence_of :password_hash
    # users.password_hash in the database is a :string
  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
