# New Relic widget trio for Dashing

## Description

This is a suite of widgets to help monitor your web applications performance using New Relic.  There are a total of 3 widgets:

* **Error Rate**
* **Response Time**
* **Requests per minute (throughput)**

The widgets are all designed for maximum visibility from a distance. All the widgets contain a maximum of 60 points of data at any given time. Because there is no historical data points, it will start on the right of the chart and fill over time to be the full width of the chart.  
Neutral colors for behaving values, and high contrast yellow and red for warning and errors respectively. Two of the widgets are responsive and react to changes in the values returned.  There are three possible colors, neutral (green), yellow and red.  This h

## Dependencies

The following gem is required:
[newrelic_api](https://github.com/newrelic/newrelic_api)

Place it inside of the Dashing `Gemfile`:

```
## Gemfile
gem 'newrelic_api'
```

Then `bundle install`

## Using the New Relic widgets

These widgets are designed for quick and easy usage.  First copy the `widget`, `assets` and `job` folders into place.  The assets folder contains a background image for the widgets. 

Now copy over the `config.yml` into the root directory of your Dashing application.  Be sure to replace the following options inside of the config file with your own New Relic information:

```
:newrelic:
  :api_key: "xxxxxxxxxxxxxxx"
  :app_name: 'Your App Name'
```

These config options get loaded in each of the separate job files.

Now you only need to add the widgets into your dashboard:

* Response time widget
```html
<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
  <div data-id="newrelic-response" data-view="Newrelicresponse" data-title="Response time" ></div>
</li>
```

* Error rate widget
```html
<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
  <div data-id="newrelic-error" data-view="Newrelicerror" data-title="Error rate" ></div>
</li>
```

* RPM (throughput) widget
```html
<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
  <div data-id="newrelic-rpm" data-view="Newrelicrpm" data-title="RPM" ></div>
</li>
```

## Customize responsive (color changing) widgets

The last step would be to set the thresholds for the two responsive widgets (error rate and response time).  This is done inside the files `newrelicerror.coffee` and `newrelicresponse.coffee` inside the widgets directory.

* Change error rate threshold `newrelicerror.coffee`, update @errorRateGreen and @errorRateYellow.  Anything above @errorRateYellow will be considered red!
```coffeescript
ready: ->
  @errorRateGreen = 1
  @errorRateYellow = 3.0
```

* Change response time threshold `newrelicresponse.coffee`, update @responseGreen and @responseYellow.  Anything above @responseYellow will be considered red!
```coffeescript
ready: ->
  @responseGreen = 200
  @responseYellow = 500
```
