class Dashing.Newrelicresponse extends Dashing.Widget
  @accessor 'response', Dashing.AnimatedValue
  ready: ->
    ## Below what value should the charts remain netural?
    @responseGreen = 200
    ## Between green and this value, the chart will be yellow
    @responseYellow = 500

    val = @get('response').replace(" ms","")
    ## Here we can check for arbitrary response values and change color based on the values.  
    ## Three levels, green, yellow red.
    if val <= @responseGreen
      $('.widget-newrelicresponse').css('background-color', '#073642')
      $('.widget-newrelicresponse h1').css('color', '#2aa198')
      $('.widget-newrelicresponse h2').css('color', '#859900')
      $('.widget-newrelicresponse .updated-at').css('color', '#fff')
    else if val > @responseGreen && val <= @responseYellow
      $('.widget-newrelicresponse').css('background-color', '#F1C40F')
      $('.widget-newrelicresponse h1').css('color', '#000')
      $('.widget-newrelicresponse h2').css('color', '#000')
      $('.widget-newrelicresponse .updated-at').css('color', '#000')
    else
      $('.widget-newrelicresponse').css('background-color', '#E74C3C')
      $('.widget-newrelicresponse h1').css('color', '#fff')
      $('.widget-newrelicresponse h2').css('color', '#fff')
      $('.widget-newrelicresponse .updated-at').css('color', '#fff')

    ## Here we use rickshaw js to create a new chart for our response rate tracking
    @graph = new Rickshaw.Graph(
      element: document.querySelector(".response-graph")
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

    val = data.response.replace("ms", "")
    if val <= @responseGreen
      $('.widget-newrelicresponse').css('background-color', '#073642')
      $('.widget-newrelicresponse h1').css('color', '#2aa198')
      $('.widget-newrelicresponse h2').css('color', '#859900')
      $('.widget-newrelicresponse .updated-at').css('color', '#fff')
    else if val > @responseGreen && val <= @responseYellow
      $('.widget-newrelicresponse').css('background-color', '#F1C40F')
      $('.widget-newrelicresponse h1').css('color', '#000')
      $('.widget-newrelicresponse h2').css('color', '#000')
      $('.widget-newrelicresponse .updated-at').css('color', '#000')
    else
      $('.widget-newrelicresponse').css('background-color', '#e74c3c')
      $('.widget-newrelicresponse h1').css('color', '#fff')
      $('.widget-newrelicresponse h2').css('color', '#fff')
      $('.widget-newrelicresponse .updated-at').css('color', '#fff')

    if @graph
      @graph.series[0].data = data.points
      @graph.render()
