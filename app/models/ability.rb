# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :create, :read, :update, :delete, to: :crud

    can :crud, Meal do |m|
      user == m.user
    end

    can :crud, Review do |r|
      user == r.user
    end
  end
end
