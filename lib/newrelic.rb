require 'yaml'
require 'newrelic_api'

class Newrelic

  attr_reader :metric, :points

  def initialize(options)
    @metric  = options[:metric]
    @points  = points
  end

  def points
    unless history === false
      history['data']['points'].map{|a| Hash[a.map{|k,v| [k.to_sym,v] }] }
    else
      (0..59).map{|a| { x: a, y: 0 } }
    end
  end

  def history
    YAML.load Sinatra::Application.settings.history[stored_name].to_s
  end

  def get_value
    app_select[0].threshold_values.select{|v| v.name.eql? @metric}[0].metric_value
  end

  def stored_name
    "newrelic_#{@metric.gsub(/ /,'_')}"
  end

  private

  def newrelic_app
    NewRelicApi.api_key = api_key
    NewRelicApi::Account.find(:first).applications
  end

  def app_select
    newrelic_app.select { |i| i.name =~ /#{app_name}/ }
  end

  def app_name
    get_config[:app_name]
  end

  def api_key
    get_config[:api_key]
  end

  def get_config
    config = YAML.load File.open("config.yml")
    config[:newrelic]
  end

end
