# Customisable New Relic widgets for Dashing

## Description

This is a suite of widgets to help monitor your web applications performance using New Relic.  There are four included widgets but you can easily add new widgets for any metric returned by the New Relic API.

* **Error Rate**
* **Response Time**
* **Requests per minute (throughput)**
* **Apdex**

The widgets are all designed for maximum visibility from a distance. All the widgets contain a maximum of 60 points of data at any given time. The chart will start on the right of the chart and fill over time to be the full width of the widget. Historical data stored by dashing will be used if available.

Neutral colours are used for behaving values, and high contrast yellow and red for warning and errors respectively. The widgets are responsive and react to changes in the values returned. There are three possible colors, neutral (green), yellow and red.

## Dependencies

The following gems are required:
 * [newrelic_api](https://github.com/newrelic/newrelic_api)
 * [activeresource](https://github.com/rails/activeresource)

Place them inside the Dashing `Gemfile`:

```
## Gemfile
gem 'newrelic_api'
gem 'activeresource'
```

Then `bundle install`

## Using the New Relic widgets

These widgets are designed for quick and easy usage.  First copy the `widget`, `assets`, `job`, and `lib` folders into place.  The assets folder contains a background image for the widgets.

Now copy over the `config.yml` into the root directory of your Dashing application.  Be sure to replace the following options inside of the config file with your own New Relic information:

```
:newrelic:
  :api_key: "xxxxxxxxxxxxxxx"
  :app_name: 'Your App Name'
```

**IMPORTANT** If your app name has any special characters in it, you will need to escape them in the name.  For example: `'My app \(production\)'`

These config options get loaded in each of the separate job files.

Now you only need to add the widgets into your dashboard:

* **Response time widget**
```
<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
  <div id="newrelic_Response_Time" data-id="newrelic_Response_Time" data-view="Newrelic" data-title="Response time" data-green="200" data-yellow="500" ></div>
</li>
```

* **RPM (throughput) widget**
```
<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
  <div id="newrelic_Throughput" data-id="newrelic_Throughput" data-view="Newrelic" data-title="RPM" data-green="2000" data-yellow="2500" ></div>
</li>
```

* **Error rate widget**
```
<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
  <div id="newrelic_Error_Rate" data-id="newrelic_Error_Rate" data-view="Newrelic" data-title="Error rate" data-green="1" data-yellow="3"></div>
</li>
```

* **Apdex widget**
```
<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
  <div id="newrelic_Apdex" data-id="newrelic_Apdex" data-view="Newrelic" data-title="Apdex" data-green="0.9" data-yellow="0.8" ></div>
</li>
```

## Customize responsive (color changing) widgets

You can customise the thresholds for the point at which the widgets change colours. This is done by changing the `data-green` and `data-yellow` attributes of the HTML you added to the dashboard above.

Any value between `data-green` and `data-yellow` will be yellow. If `data-green` is larger than `data-yellow`, then anything above `data-green` will be green, and anything below `data-yellow` will be red, and vice-versa.

## Adding more widgets

You can easily add new widgets using any value returned by the New Relic API. Follow this example to add a 'CPU' widget:

 * Copy one of the files in the `jobs` directory to a new filename, e.g. `cp newrelic_apdex.rb newrelic_cpu.rb`
 * Edit the first line of the newly created `newrelic_cpu.rb` to say `metric = 'CPU'`
 * Copy the dashboard widget HTML, replacing 'Apdex' with 'CPU' and customising the `data-green` and `data-yellow` limits:
```
<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
  <div id="newrelic_CPU" data-id="newrelic_CPU" data-view="Newrelic" data-title="CPU" data-green="70" data-yellow="90" ></div>
</li>
```
 * You now have a CPU widget which will be green below 70%, yellow up to 90% and red above.
