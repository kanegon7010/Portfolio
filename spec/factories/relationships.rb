# == Schema Information
#
# Table name: relationships
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  follower_id  :bigint
#  following_id :bigint
#
# Indexes
#
#  index_relationships_on_follower_id                   (follower_id)
#  index_relationships_on_follower_id_and_following_id  (follower_id,following_id) UNIQUE
#  index_relationships_on_following_id                  (following_id)
#
# Foreign Keys
#
#  fk_rails_...  (follower_id => users.id)
#  fk_rails_...  (following_id => users.id)
#
FactoryBot.define do
  factory :relationship do
    follower
    following

    # 上記は、userのfactoryにて、エイリアスをつけたことにより省略して記載している。
    # 省略しない場合は、下記の通りとなる。
    # association :follower, factory: :user

    # associationは、関連するデータを一緒に作成してくれるメソッド。

  end
end
