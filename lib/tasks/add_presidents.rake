task :add_presidents => :environment do |t|
  User.create(name: 'George Washington', age: 1789-1732)
  User.create(name: 'John Adams', age: 1797-1735)
  User.create(name: 'Thomas Jefferson', age: 1801-1743)
  User.create(name: 'James Madison', age: 1809-1751)
  User.create(name: 'James Monroe', age: 1817-1758)
end

task :assign_busywork => :environment do |t|
  user_ids = [nil] + User.pluck(:id)
  100.times do
    Task.create({
      priority: Task::PRIORITIES.sample,
      user_id: user_ids.sample,
      name: "#{common_words.sample} #{common_words.sample}",
      description: lorem_ipsum
    })
  end
end

def common_words
  %w(about after again air all along also an and another any are around as at away back be because been before below between both but by came can come could day did different do does don't down each end even every few find first for found from get give go good great had has have he help her here him his home house how I if in into is it its just know large last left like line little long look made make man many may me men might more most Mr.  must my name never new next no not now number of off old on one only or other our out over own part people place put read right said same saw say see she should show small so some something sound still such take tell than that the them then there these they thing think this those thought three through time to together too two under up us use very want water way we well went were what when where which while who why will with word work world would write year you your was)
end

def lorem_ipsum
  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
end


