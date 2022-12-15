class UserSerializer < ActiveModel::Serializer
  attributes :id, :username
  has_many :posts, dependent: :destroy
end
