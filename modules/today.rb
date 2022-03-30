require 'json'
require 'date'
require_relative('./view')

# Unique to opening up the app
module Today
  def self.prog_open
    today = Time.now.strftime('%d %m %y')
    today_date = Date.parse(today).to_s
    View.list_events_day(today_date)
  end

  def self.proverb
    response = HTTParty.get('https://zenquotes.io/api/random')
    result = JSON.parse(response.body)[0]
    Rainbow("#{result['q']} - #{result['a']}").lightcoral
  end
end
