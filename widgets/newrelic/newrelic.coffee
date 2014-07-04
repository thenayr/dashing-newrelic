class Dashing.Newrelic extends Dashing.Widget
  @accessor 'current', Dashing.AnimatedValue

  ready: ->
    @graph = new Rickshaw.Graph(
      element: document.querySelector("#" + this.id + " .newrelic-graph")
      renderer: 'area'
      height: 180
      width: 300
      series: [
        {
          color: "#fff",
          data: [{ x:0, y:0}]
        }
      ]
    )
    @graph.series[0].data = @get('points') if @get('points')
    @graph.render()

  onData: (data) ->

    @responseGreen = document.getElementById(this.id).getAttribute('data-green')
    @responseYellow = document.getElementById(this.id).getAttribute('data-yellow')

    val = data.current
    if (
      ((@responseGreen < @responseYellow) && (val <= @responseGreen)) ||
      ((@responseGreen > @responseYellow) && (val >= @responseGreen))
    )
      $('#' + this.id + '.widget-newrelic').css('background-color', '#073642')
      $('#' + this.id + '.widget-newrelic h1').css('color', '#2aa198')
      $('#' + this.id + '.widget-newrelic h2').css('color', '#859900')
      $('#' + this.id + '.widget-newrelic .updated-at').css('color', '#fff')
    else if (
      ((@responseGreen < @responseYellow) && ((val > @responseGreen) && (val <= @responseYellow))) ||
      ((@responseGreen > @responseYellow) && ((val < @responseGreen) && (val >= @responseYellow)))
    )
      $('#' + this.id + '.widget-newrelic').css('background-color', '#F1C40F')
      $('#' + this.id + '.widget-newrelic h1').css('color', '#000')
      $('#' + this.id + '.widget-newrelic h2').css('color', '#000')
      $('#' + this.id + '.widget-newrelic .updated-at').css('color', '#000')
    else
      $('#' + this.id + '.widget-newrelic').css('background-color', '#e74c3c')
      $('#' + this.id + '.widget-newrelic h1').css('color', '#fff')
      $('#' + this.id + '.widget-newrelic h2').css('color', '#fff')
      $('#' + this.id + '.widget-newrelic .updated-at').css('color', '#fff')

    if @graph
      @graph.series[0].data = data.points
      @graph.render()
