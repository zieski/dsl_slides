class User < ActiveRecord::Base
  has_many :tasks, dependent: :nullify

  def current_task
    tasks.first
  end

  def current_task_name
    current_task.try(:name) or "NO TASKS"
  end
end

