class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, TodoList, user_id: user.id
      can :manage, Task do |task|
        task.todo_list.user_id == user.id
      end
      can :manage, Comment do |comment|
        comment.task.todo_list.user_id == user.id
      end
      can :manage, FileStorage do |file|
        file.comment.task.todo_list.user_id == user.id
      end
    end
  end
end
