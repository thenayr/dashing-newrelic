class Dashing.Newrelicrpm extends Dashing.Widget
  @accessor 'rpm', Dashing.AnimatedValue


  ready: ->
    $('.widget-newrelicrpm').css('background-color', '#073642')
    $('.widget-newrelicrpm h1').css('color', '#2aa198')
    $('.widget-newrelicrpm h2').css('color', '#859900')
    $('.widget-newrelicrpm .updated-at').css('color', '#fff')
    ## Here we use rickshaw js to create a new chart for our rpm rate tracking
    @graph = new Rickshaw.Graph(
      element: document.querySelector(".rpm-graph")
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
    $('.widget-newrelicrpm').css('background-color', '#073642')
    $('.widget-newrelicrpm h1').css('color', '#2aa198')
    $('.widget-newrelicrpm h2').css('color', '#859900')
    $('.widget-newrelicrpm .updated-at').css('color', '#fff')

    if @graph
      @graph.series[0].data = data.points
      @graph.render()
