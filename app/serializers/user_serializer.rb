# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)
#  session_key     :string(255)
#  activation_key  :string(255)
#  bio             :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  full_name       :string(255)
#
# Indexes
#
#  index_users_on_session_key  (session_key)
#

class UserSerializer < ActiveModel::Serializer
  attributes :id, :bio, :email, :full_name, :gravatar_url

end
