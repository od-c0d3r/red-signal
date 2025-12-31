class User < ApplicationRecord
  enum :role, { user: 0, admin: 1 }
  enum :approval_status, { pending: 0, approved: 1, rejected: 2 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_update_commit -> do
    broadcast_replace_to "statistics", partial: "partials/admin/online_counter", locals: { user: self }, target: "online_counter"
    broadcast_replace_to self, partial: "partials/user/user_status", locals: { user: self }, target: "user_now"
  end
end
