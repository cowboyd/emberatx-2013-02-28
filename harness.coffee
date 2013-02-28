
$.fn.bindTo = (model, path, fmt)->
  fmt ||= (val)-> new String(val)
  copy = => $(this).html fmt.call this, model.get path
  model.addObserver path, copy
  copy()
  return this


$('.block').each ->
  interaction = Drag.Interaction.create element: this
  drag = window.drag = interaction.get 'drag'
  $('.start').bindTo drag, 'start', ->
    "(x:#{drag.get('start.x')}, y:#{drag.get('start.y')})"
  $('.end').bindTo drag, 'end', ->
    "(x:#{drag.get('end.x')}, y:#{drag.get('end.y')})"
  $('.delta').bindTo drag, 'delta', ->
    "(x:#{drag.get('delta.x')}, y:#{drag.get('delta.y')})"
  $('.offset').bindTo drag, 'offset', ->
    "(left: #{drag.get('offset.top')}, top: #{drag.get('offset.top')})"

  visualization = Ember.Object.extend
    init: (attrs)->
      @_super attrs
    render: (->
      viewport = d3.select('svg#visualization')
      viewport.append('circle')
        .attr('class', 'point')
        .attr('cx', @get 'drag.offset.left' )
        .attr('cy', @get 'drag.offset.top')
        .attr('r', 1)
        .attr('stroke', 'gray')
        .attr('stroke-width', 1)
        .attr('fill', 'none')
      line = viewport.selectAll('line.distance').data([
        offset0: @get 'drag.offset0'
        offset: @get 'drag.offset'
      ])
      line.enter().append('line')
        .attr('class', 'distance')
        .attr('stroke-width', 1)
        .attr('stroke', 'gray')
      line
        .attr('x1', (d)-> d.offset0.left)
        .attr('x2', (d)-> d.offset.left)
        .attr('y1', (d)-> d.offset0.top)
        .attr('y2', (d)-> d.offset.top)
    ).observes 'drag.offset'      
  .create(drag: drag)
