module Enums
  
  @@Add = "Add"
  @@ViewDay = "View Day"
  @@FindEvent = "Find Event"
  @@DeleteEvent = "Delete Event"
  @@Help = "Help"
  @@Exit = "Exit"
  @@Options = [@@Add, @@ViewDay, @@FindEvent, @@DeleteEvent, @@Help, @@Exit]

  def self.Add
    @@Add
  end

  def self.ViewDay
    @@ViewDay
  end

  def self.FindEvent
    @@FindEvent
  end

  def self.DeleteEvent
    @@DeleteEvent
  end

  def self.Help
    @@Help
  end

  def self.Exit
    @@Exit
  end

  def self.Options
    @@Options
  end
end
