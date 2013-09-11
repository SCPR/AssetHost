module AssetHostCore
  class Permission < ActiveRecord::Base
    ABILITIES = [
      :read,
      :write
    ]

    attr_accessible :resource, :ability

    belongs_to :user, polymorphic: true

    validates :resource, :ability, :user_id, presence: true
  end
end
