class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username
  has_many :sent_messages
  has_many :recieved_messages
end
