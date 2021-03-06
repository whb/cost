class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.is_valid?
      can :show, :home 
      can [:profile, :update_self_password], User
      can [:read, :query], Expense 
      can [:read, :query, :query_expenses], Reimbursement
    end
    can :manage, [User, Category, Period, Organization] if user.is? :admin
    if user.is? :staff
      can [:create, :generate_sn, :update, :destroy], Expense
      can [:create, :generate_sn, :update, :destroy], Reimbursement
    end
    if user.is? :department_manager
      can :manage, Expense
      can [:read, :current], Period 
      can :report, :cost
    end
    if user.is? :vice_manager
      can :manage, Approval
      can [:read, :current], Period 
      can :report, :cost
    end
    if user.is? :general_manager
      can :manage, Approval
      can [:read, :current], Period 
      can :report, :cost
    end
    if user.is? :financial_officer
      can [:list_verify, :commit, :verify], Reimbursement
      can [:read, :current], Period 
      can :report, :cost
    end
     
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
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
