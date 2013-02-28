
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
