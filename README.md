# Hachi - Terminal Daily Planner - T1A3
Hachi is a daily planner within the terminal. This application allows you to add, view, find, and delete events. You only need to have the events details to enter and you are done!
## Repository
Github: https://github.com/nik-mak/hachi
Project Board: https://github.com/users/nik-mak/projects/1
## Style Guide
Rubocop: https://github.com/rubocop/ruby-style-guide
## Features
### Add
This allows you to add new events to your planner. The on-screen instructions will prompt you to provide a date, time, and title for the event. It will then get you to confirm the details before saving.
### View Day
This allows you to view your events for a given day.

### Find Event
This allows you to find the events with a given title.
### Delete
This allows you to delete an event. It will prompt you provide a day and it will list the events you have on that day. You will then need to provide the title for the event and confirm you want to delete it.
### Proverb
The proverb is sourced from a http API (https://zenquotes.io/api/random) which will provide a random quote every time the app is run.
## How to run the app
1. Download the .zip file from this repository.
2. Unzip the file in your desired directory.
3. run the .sh file in the terminal with `./run_app.sh`
This will automatically install all dependencies for the application and begin the program.

### Command line arguments
If you choose to run the app with the command `ruby planner.rb` you have to option of using command line arguments:
- `-h` or `--help` will display the help documentation of the application.
- `-v` or `--version` will display the current version of the application. 

## Dependencies
These are the gems required to run this application:
```ruby
gem "rspec", "~> 3.11"
gem "httparty", "~> 0.20.0"
gem "tty-prompt", "~> 0.6.0"
gem "tty-font", "~> 0.5.0"
```
