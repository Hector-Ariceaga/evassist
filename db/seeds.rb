user1 = User.new(username: 's_user1', password: '123')
user2 = User.new(username: 's_user2', password: '456')
user3 = User.new(username: 's_users3', password: '789')
user1.save
user2.save
user3.save

event1 = Event.create(
    name: "Michael's Wedding", 
    datetime: "Monday, October 12th", 
    description: "Michael is getting married!", 
    user_id: 1)
event2 = Event.create(
    name: "Pauline's family shoot", 
    datetime: "Wednesday, Feb 9th", 
    description: "The family and there dog will be at 9th street park.", 
    user_id: 2)
event3 = Event.create(
    name: "Andy's graduation",
    datetime: "Friday, Dec 12th",
    description: "Andy is graduating from high school. His family wants portrait style shots.",
    user_id: 1)

task1 = Task.create(
    name: "Sign in", 
    description: "Sign the guest book first thing", 
    completed: true, 
    event_id: 1, 
    user_id: 1)
task2 = Task.create(
    name: "Introductions", 
    description: "Meet the bride and groom and review the plan.", 
    completed: false, 
    event_id: 1, 
    user_id: 1)
task3 = Task.create(
    name: "Set up equipment", 
    description: "Unload equipment from car and set up in location.", 
    completed: false, 
    event_id: 2, 
    user_id: 2 )
task4 = Task.create(
    name: "Review contract", 
    description: "Review with family the contract and timelines prior to wrapping up.", 
    completed: false, 
    event_id: 2, 
    user_id: 2)
task5 = Task.create(
    name: "Get location shots", 
    description: "Scout outdoors and church location, obtain shots prior to the ceremony.", 
    completed: true, 
    event_id: 1, 
    user_id: 1)