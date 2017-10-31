class Sub < ApplicationRecord
  validates :description, presence: true
  validates :title, presence: true, uniqueness: true

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :moderator_id,
    class_name: :User

  has_many :post_subs, dependent: :destroy

  has_many :posts,
    through: :post_subs,
    source: :post
end
