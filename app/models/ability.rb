class Ability
  include CanCan::Ability

  def initialize(user)

    if user.admin?
        can :manage, :all
    else
        if user.roles.include? :clients
            can [:read, :create], Client
            if user.roles.include? :update
                can :update, Client
            end
            if user.roles.include? :destroy
                can :destroy, Client
            end
        end
        if user.roles.include? :opportunities
            can [:read, :create], Opportunity
            if user.roles.include? :update
                can :update, Opportunity
            end
            if user.roles.include? :destroy
                can :destroy, Opportunity
            end
        end
        if user.roles.include? :products
            can [:read, :create], Product
            if user.roles.include? :update
                can :update, Product
            end
            if user.roles.include? :destroy
                can :destroy, Product
            end
        end
        if user.roles.include? :requirements
            can [:read, :create], Requirement
            if user.roles.include? :update
                can :update, Requirement
            end
            if user.roles.include? :destroy
                can :destroy, Requirement
            end
        end
        if user.roles.include? :suppliers
            can [:read, :create], Supplier
            if user.roles.include? :update
                can :update, Supplier
            end
            if user.roles.include? :destroy
                can :destroy, Supplier
            end
        end
        if user.roles.include? :purchase_orders
            can [:read, :create], PurchaseOrder
            if user.roles.include? :update
                can :update, PurchaseOrder
            end
            if user.roles.include? :destroy
                can :destroy, PurchaseOrder
            end
        end
        if user.roles.include? :shipping_addresses
            can [:read, :create], ShippingAddress
            if user.roles.include? :update
                can :update, ShippingAddress
            end
            if user.roles.include? :destroy
                can :destroy, ShippingAddress
            end
        end
        if user.roles.include? :users
            can [:read, :create], User
            if user.roles.include? :update
                can :update, User
            end
            if user.roles.include? :destroy
                can :destroy, User
            end
        end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
