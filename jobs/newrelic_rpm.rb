require 'newrelic_api'
config = YAML.load File.open("config.yml")
config = config[:newrelic]

# Newrelic API key from config.yml
key = config[:api_key]

# Set the name of your application in config.yml, you may need to escape characters
app_name = config[:app_name]

# Setup newrelic api info
NewRelicApi.api_key = key
app = NewRelicApi::Account.find(:first).applications
app_select = app.select { |i| i.name =~ /#{app_name}/ }

history = YAML.load(Sinatra::Application.settings.history['newrelic-rpm'].to_s)
unless history === false
  points = []
  points = history['data']['points'].last(60)
else
  ## One hours worth of data for, seed 60 empty points (rickshaw acts funny if you don't).
  ## Create an array to hold our data points
  points = []
  (0..59).each do |a|
    points << { 'x' => a, 'y' => 0.00 }
  end
end

## Grab the last x value
last_x = points.last['x']

## Every 1m for this
SCHEDULER.every '1m', :first_in => 0 do |job|

  ## RPM is the fourth value returned by new relic
  current_rpm = app_select[0].threshold_values[3].metric_value

  ## Drop the first point value and increment x by 1
  points.shift
  last_x += 1

  ## Push the most recent point value
  points << { 'x' => last_x, 'y' => current_rpm  }

  send_event("newrelic-rpm", { rpm: current_rpm, points: points })

end
