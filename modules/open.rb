# frozen_string_literal: true

require 'csv'
require 'json'
require 'date'
require 'rainbow'
require_relative('./date_time')
require_relative('./eventinfo')
require_relative('./view_day')

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
    puts Rainbow("#{result['q']} - #{result['a']}").lightcoral
  end
end