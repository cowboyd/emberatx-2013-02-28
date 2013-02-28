Point = Ember.Object.extend
  x: 0, y:0


Drag = Ember.Object.extend
  path: []
  offset0: top: 0, left: 0

  start: (->
    @get('path.firstObject') || Point.create()
  ).property 'path.firstObject'
  end: (->
    @get('path.lastObject') || Point.create()
  ).property 'path.lastObject'
  delta: (->
    x: @get('end.x') - @get('start.x'), y: @get('end.y') - @get('start.y')
  ).property 'start', 'end'
  offset: (->
    left: @get('offset0.left') + @get('delta.x')
    top: @get('offset0.top') + @get('delta.y')
  ).property 'delta.x', 'delta.y', 'offset0.left', 'offset0.top'

Drag.Interaction = Ember.Object.extend
  init: (attrs)->
    @_super attrs
    @set 'dragging', false
    @set 'drag', Drag.create offset0: Ember.Object.create
      left: @get 'element.offsetLeft'
      top: @get 'element.offsetTop'
  
    $(@get 'element').on 'mousedown', (e)=>
      @start(e)
    $(document.body).on 'mousemove', (e)=>
      @move(e)
    .on 'mouseup', (e)=>
      @finish(e)
  start: (e)->
    @set 'dragging', true
    @move e
  move: (e)->
    if @get 'dragging'
      @get('drag.path').pushObject Point.create x: e.pageX, y: e.pageY
  finish: (e)->
    if @get 'dragging'
      @move e
      @set 'dragging', false

  updateOffsets: (->
    $(@get 'element').css
      left: @get 'drag.offset.left'
      top: @get 'drag.offset.top'
      
  ).observes 'drag.offset.left', 'drag.offset.top'      

window.Drag = Drag
