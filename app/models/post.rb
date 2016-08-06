class Post < ActiveRecord::Base
  validates :title, :content, :sub_id, :user_id, presence: true

  belongs_to :sub, foreign_key: :sub_id, class_name: "Sub"
  belongs_to :author, foreign_key: :user_id, class_name: "User"

end
