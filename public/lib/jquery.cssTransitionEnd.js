// run cb when the next animation is complate (or right away if there is no animation support)
jQuery.fn.cssTransitionEnd = function (cb) {
  var self = this
  var transEndEventNames = {
    'WebkitTransition' : 'webkitTransitionEnd',
    'MozTransition'    : 'transitionend',
    'OTransition'      : 'oTransitionEnd',
    'msTransition'     : 'msTransitionEnd', // maybe?
    'transition'       : 'transitionEnd'
  }

  var transEndEventName = transEndEventNames[Modernizr.prefixed("transition")]

  function unbind () {
    $(self).unbind(transEndEventName, animEnd)
  }

  // animations propogate so only cb if it was fired on this elem
  function animEnd (e) {
    if (e.target == e.currentTarget) {
      if (cb(e.originalEvent.propertyName) !== false) unbind()
    }
  }

  if (Modernizr.csstransitions) {
    $(this).bind(transEndEventName, animEnd)
  }
  else {
    // just run the cb now because the event will never be fired
    setTimeout(function () {
      cb("")
    }, 0)
  }

  return {
    unbind: unbind
  }
}