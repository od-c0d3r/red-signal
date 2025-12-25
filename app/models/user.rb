class User < ApplicationRecord
  enum :role, { user: 0, admin: 1 }
  enum :approval_status, { pending: 0, approved: 1, rejected: 2 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
