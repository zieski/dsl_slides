require "#{Rails.root}/app/tasks/custom_task"

task :add_presidents => :environment do |t|
  User.create(name: 'George Washington', age: 1789-1732)
  User.create(name: 'John Adams', age: 1797-1735)
  User.create(name: 'Thomas Jefferson', age: 1801-1743)
  User.create(name: 'James Madison', age: 1809-1751)
  User.create(name: 'James Monroe', age: 1817-1758)
end

custom_task :assign_busywork, n_tasks: 10

