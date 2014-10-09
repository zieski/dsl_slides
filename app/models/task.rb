class Task < ActiveRecord::Base
  PRIORITIES = [URGENT = "urgent", HIGH = "high", NORMAL = "normal", LOW = "low"]
  belongs_to :user

  validates :priority, inclusion: { in: PRIORITIES }
  PRIORITIES.each do |p|
    scope p.to_sym, ->{ where(priority: p) }
  end

  def user_name
    user.try(:name) or "Not Assigned."
  end

  def short_description
    if description.length < 25
      description
    else
      "#{description[0...22]}..."
    end
  end
end

