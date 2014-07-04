metric = 'Response Time'

newrelic = Newrelic.new({metric: metric})
points = newrelic.points
last_x = points.last[:x]

SCHEDULER.every '1m', :first_in => 0 do |job|

  current = newrelic.get_value

  ## Drop the first point value and increment x by 1
  points.shift
  last_x += 1

  ## Push the most recent point value
  points << { x: last_x, y: current }

  send_event(newrelic.stored_name, { current: current, points: points })

end
