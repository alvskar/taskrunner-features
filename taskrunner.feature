Feature: Repeating and Scheduled Event Items

  Scenario: User wants to create an event on Monday, March 3rd, 2020 from 18:00 to 20:00
    When the user adds a new event
    And the user adds a schedule to an event
    And the user sets the event to be on Monday, March 3rd, 2020 from 18:00 to 20:00
    Then the new event will exist in a list of events and reflect the schedule information
    And an instance will be generated on that date
    And the UI for a daily view will reflect the presence of this event with its time
    And the UI will show a box filled from 18:00 to 20:00 for the day
    And the UI for a daily view will color the event red if the current time for the day passes the time of the event instance
    # Use UTC time for this detection, but will reflect in local time

  Scenario: User wants to create an event that repeats every Tuesday at 14:00
    When the user adds a new event
    And the user adds a schedule to an event
    And the user adds week-based repetition on Tuesday to a schedule of an event
    Then the new event will exist in a list of events and reflect the schedule information
    And instances will be generated starting from the date of creation, for every Tuesday at 14:00 whereupon
    # Instances need to be generated quite far, enough that any given schedule the user looks at will list them,
    # but we can't exactly store infinity instances in the database, either
    And the UI for a daily view will reflect the presence of this event with its time
    And the UI for a daily view will color the event red if the current time for the day passes the time of the event instance
    
 # Distinguishing due from scheduled items?
 # I.e., say, homework _due_ every Monday, but meditation _done_ every Tuesday are not the same type of schedule
 # A meeting isn't really "due" either. A meeting will be the default event type
 # Combinational or mutually exclusive? Mostly defaulting to additive on most things but this'll probably be exclusive since
 # due items do not inherently take energy
 
 ## Due items can generate dormant energy, i.e., energy that the taskrunner notes as needing to be recored
 ## Do due items generate heavy phantom items?
 ## Did I say phantom items? Oh no.
    
 Scenario: User wants to create a due event schedule for a certain date
   When the user adds a new event
   And the user adds a due date to the event
   Then the new event will exist in a list of events and reflect the schedule information
   And an instance will be generated on the due date, with time set to the due time
   # Due time will default to noon, but can be configured
   And the UI for a daily view will reflect the presence of this event with its time
   And the UI for a daily view will color the event red if the current time for the day passes the time of the event instance
   
 Scenario: User wants to categorize certain events as habits
 # Habits are going to be used by the energy system, which is why we can't just use basic lists
   When the user adds a new event
   Then the user can classify that event as a habit
   # By means of checkbox
 
 Scenario: User wants to push off habits by a month
 # This is very rudimentary to start
 # Pushing actually only affects instances, not items, since items do not have a datetime
 # Pushing off instances that are due is not possible
 # Moving due items will be called "rescheduling" and is a different action
   When the user requests to push off all habits by a month
   Then all instances in the next month of all items tht are classified as habits are deleted
   And the UI is updated to not show the instances in the next month
   
 Scenario: User wants to see today's items
   When the user goes to a "Today" view
   Then they will see the full list of all items that have an instance for today
 
 Scenario: User wants to see the summary of the week
   When the user goes to a "Week" view
   Then they will see a week presented as 7 days, from Sunday to Saturday
   And each day will show all non-habit items for that day, in time of day order
   
