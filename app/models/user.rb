class User < ApplicationRecord
  has_many :posts

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}

  has_secure_password

  attr_reader :remember_token

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    set_token
    update_attribute(:remember_digest, Digest::SHA1.hexdigest(remember_token.to_s))
  end

  def forget
    self.remember_digest = nil
  end

  private
    attr_writer :remember_token

    def set_token
      self.remember_token = User.new_token
    end
end
