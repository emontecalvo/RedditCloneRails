class Sub < ActiveRecord::Base

  validates :title, :description, :user_id, presence: true

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

    # has_many :post_subs, inverse_of: :sub, dependent: :destroy
    # has_many :posts, through: :post_subs, source: :post


    has_many :posts


end
