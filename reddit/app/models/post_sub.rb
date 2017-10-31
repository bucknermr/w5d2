class PostSub < ApplicationRecord
  validates :sub, :post, presence: true
  validates :post, uniqueness: { scope: :sub }

  belongs_to :sub
  belongs_to :post
end
