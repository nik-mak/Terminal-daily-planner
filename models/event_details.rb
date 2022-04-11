class EventDetails
  attr_reader :date, :time, :title

  def initialize(date, time, title)
    @time = time
    @title = title
    @date = date
  end

  def new_event
    array = [@date, @time, @title]
    return array
  end
end