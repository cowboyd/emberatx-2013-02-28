
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
      ).observes 'drag.offset'
  .create(drag: drag)
