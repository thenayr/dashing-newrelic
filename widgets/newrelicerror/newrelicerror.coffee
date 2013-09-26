class Dashing.Newrelicerror extends Dashing.Widget
  @accessor 'error_rate', Dashing.AnimatedValue

  ready: ->
    ## Below what value should the charts remain netural?
    @errorRateGreen = 1
    ## Between green and this value, the chart will be yellow
    @errorRateYellow = 3.0

    val = @get('error_rate')
    ## Here we can check for arbitrary error values and change color based on the values.  
    ## Three levels, green, yellow red.
    if val <= @errorRateGreen
      $('.widget-newrelicerror').css('background-color', '#073642')
      $('.widget-newrelicerror h1').css('color', '#2aa198')
      $('.widget-newrelicerror h2').css('color', '#859900')
      $('.widget-newrelicerror .updated-at').css('color', '#fff')
    else if val > @errorRateGreen && val <= @errorRateYellow
      $('.widget-newrelicerror').css('background-color', '#F1C40F')
      $('.widget-newrelicerror h1').css('color', '#000')
      $('.widget-newrelicerror h2').css('color', '#000')
      $('.widget-newrelicerror .updated-at').css('color', '#000')
    else
      $('.widget-newrelicerror').css('background-color', '#E74C3C')
      $('.widget-newrelicerror h1').css('color', '#fff')
      $('.widget-newrelicerror h2').css('color', '#fff')
      $('.widget-newrelicerror .updated-at').css('color', '#fff')

    ## Here we use rickshaw js to create a new chart for our error rate tracking
    @graph = new Rickshaw.Graph(
      element: document.querySelector(".error-graph")
      renderer: 'area'
      height: 180
      width: 300
      series: [
        {
          color: "#fff",
          data: [{ x:0, y:40}]
        }
      ]
    )
    @graph.series[0].data = @get('points') if @get('points')
    @graph.render()

  onData: (data) ->

    val = data.error_rate
    if val <= @errorRateGreen
      $('.widget-newrelicerror').css('background-color', '#073642')
      $('.widget-newrelicerror h1').css('color', '#2aa198')
      $('.widget-newrelicerror h2').css('color', '#859900')
      $('.widget-newrelicerror .updated-at').css('color', '#fff')
    else if val > @errorRateGreen && val <= @errorRateYellow
      $('.widget-newrelicerror').css('background-color', '#F1C40F')
      $('.widget-newrelicerror h1').css('color', '#000')
      $('.widget-newrelicerror h2').css('color', '#000')
      $('.widget-newrelicerror .updated-at').css('color', '#000')
    else
      $('.widget-newrelicerror').css('background-color', '#e74c3c')
      $('.widget-newrelicerror h1').css('color', '#fff')
      $('.widget-newrelicerror h2').css('color', '#fff')
      $('.widget-newrelicerror .updated-at').css('color', '#fff')

    if @graph
      @graph.series[0].data = data.points
      @graph.render()
