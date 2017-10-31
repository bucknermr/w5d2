class Post < ApplicationRecord
  validates :title, :subs, presence: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  has_many :post_subs, dependent: :destroy

  has_many :subs,
    through: :post_subs,
    source: :sub

  def author_username
    author.username
  end
end
