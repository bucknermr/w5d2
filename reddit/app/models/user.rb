class User < ApplicationRecord
  validates :password_digest, :session_token, presence: true
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  attr_reader :password

  has_many :subs,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :Sub

  has_many :posts,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Post

  def password=(password)
    @passord = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    user && user.is_password?(password) ? user : nil
  end

  private

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end
end
