class User < ApplicationRecord
  after_update_commit -> do
    broadcast_replace_to "admin_statistics", partial: "partials/admin/online_counter", target: "online_counter"
    broadcast_replace_to "admin_statistics", partial: "partials/admin/map",
                                       locals: {
                                        online_users_with_long_lat: User.online.located,
                                        events: Event.pluck(:longitude, :latitude, :title)
                                       },
                                       target: "map"
    broadcast_replace_to self, partial: "partials/user/user_status", locals: { user: self }, target: "user_now"
  end

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  enum :role, { user: 0, admin: 1 }
  enum :approval_status, { pending: 0, approved: 1, rejected: 2 }

  scope :online, -> { where(is_online: true) }
  scope :pending, -> { where(approval_status: :pending) }
  scope :approved, -> { where(approval_status: :approved) }
  scope :located, -> { where.not(latitude: nil, longitude: nil) }

  reverse_geocoded_by :latitude, :longitude
end
