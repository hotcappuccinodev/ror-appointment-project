# frozen_string_literal: true

class Ability
  # Add in CanCan's ability definition DSL
  include CanCan::Ability

  def initialize(user)
    return unless user.present? # additional permissions for logged in users (they can read their own posts)

    
    
    return unless user.admin? # additional permissions for administrators

    
  end
end
