class Ability
  # Add in CanCan's ability definition DSL
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    can :read, Vehicle

    return unless user.present? # additional permissions for logged in users (they can read their own posts)

    can :create, Reservation, user: user
    can :delete, Reservation, user: user
    can :create, Vehicle, user: user
    can :delete, Vehicle, user: user

    return unless user.admin? # additional permissions for administrators

    can :manage, :all
  end
end
