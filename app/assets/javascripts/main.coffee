class Lock
  constructor: ->
    @locked = false

  lock: ->
    if @locked
      return false
    @locked = true
    return true
  
  unlock: ->
    @locked = false

window.speechLock = new Lock

class Speaker
  constructor: ->
    @synth = window.speechSynthesis
    @current_voice_name = @.default_voice_name()

  voices: ->
    @synth.getVoices()

  enabled_voices: ->
    set_voices = ['Daniel', 'Oliver', 'Peter', 'Samantha', 'Victoria', 'Alex', 'Fred']
    voice for voice in @.voices() when set_voices.includes(voice.name)

  default_voice_name: ->
    'Oliver'

  current_voice: ->
    (voice for voice in @.enabled_voices() when voice.name == @.current_voice_name)[0]

  set_voice_name: (voice_name) ->
    @current_voice_name = voice_name

  say: (phrase) ->
    if window.speechLock.lock()
      utterance = new SpeechSynthesisUtterance(phrase)
      utterance.voice = @.current_voice()
      utterance.onend = window.speechLock.unlock
      @synth.speak(utterance)

$ ->
  drake = dragula({
    accepts: (el, target, source, sibling) ->
      return (el.classList.contains('phrase_box') &&
        target.classList.contains('category_body')) ||
        (el.classList.contains('outer_category_box') &&
        target.classList.contains('category_column'))
  })
  speaker = new Speaker

  say = (phrase) ->
    speaker.say(phrase)

  save = (phrase) ->
    $.ajax
      url: '/phrase'
      type: 'POST'
      data : {'phrase': phrase}
      success: (data, status, response) ->
        $('#phrase_queue').append(response.responseText)
        $('#phrase_input').val("")
        phrase_setup()
      error: ->
        console.log('error')

  save_category = (category_name) ->
    $.ajax
      url: '/category'
      type: 'POST'
      data : {'name': category_name}
      success: (data, status, response) ->
        left = $("#category_column_left")
        right = $("#category_column_right")
        if (left.children().size() <= right.children().size())
          left.append(response.responseText)
        else
          right.append(response.responseText)
        category_setup()
        $("#new_category_input").val("")
      error: ->
        console.log('error')

  update_voice = (voice) ->
    speaker.set_voice_name(voice)

  destroy = (phrase_id) ->
    $.ajax
      url: '/phrase'
      type: 'DELETE'
      data: {'phrase_id': phrase_id}
      success: (data, status,response) ->
        $("[phrase_id='" + phrase_id + "']").remove()
      error: ->
        console.log('error')

  update_phrase = (phrase_id, category_id, next_phrase_id) ->
    $.ajax
      url: '/phrase'
      type: 'UPDATE'
      data: {
        'type': 'CATEGORY',
        'phrase_id': phrase_id,
        'category_id': category_id,
        'next_phrase_id': next_phrase_id,
      }
      success: (data, status, response) ->
      error: ->
        console.log('error')

  update_category = (category_id, next_category_id, column) ->
    $.ajax
      url: '/category'
      type: 'UPDATE'
      data: {
        'type': 'POSITION',
        'category_id': category_id,
        'next_category_id': next_category_id,
        'column': column,
      }
      success: (data, status, response) ->
      error: ->

  delete_category = (category_id) ->
    $.ajax
      url: '/category'
      type: 'DELETE'
      data: {category_id: category_id}
      success: (data, status, response) ->
        $("[category_id='" + category_id + "']").remove()
      error: ->
        console.log('error')


  getParentCategoryBox = (element) ->
    while (element && !element.classList.contains('category_box'))
      element = element.parentNode
    return element

  $('#say').click ->
    say($('#phrase_input').val())

  $('#save').click ->
    input = $('#phrase_input').val()
    if input
      save(input)

  drop = (el, target, source, sibling) ->
    if (el.classList.contains('phrase_box') &&
        target.classList.contains('category_body'))
      phrase_id = el.getAttribute('phrase_id')
      category_id = target.getAttribute('category_id')
      if sibling
        next_phrase_id = sibling.getAttribute('phrase_id')
      else
        next_phrase_id = null
      update_phrase(phrase_id, category_id, next_phrase_id)
    else if (el.classList.contains('outer_category_box') &&
        target.classList.contains('category_column'))
      category_id = el.getAttribute('category_id')
      if sibling
        next_category_id = sibling.getAttribute('category_id')
      else
        next_category_id = null
      column = target.getAttribute('column')
      update_category(category_id, next_category_id, column)

  phrase_setup = ->
    $(".phrase_say").click ->
      say(this.getAttribute('text'))

    $(".phrase_delete").click ->
      destroy(this.getAttribute('phrase_id'))

  category_setup = ->
    $(".category_delete").click ->
      delete_category(this.getAttribute('category_id'))

    # setting up drag and drop events in categories
    categories = (el for el in document.querySelectorAll('.category_body'))
    categories.push(document.querySelector('#phrase_queue'))
    for category in categories
      drake.containers.push(category)
    drake.containers.push(document.querySelector('#category_column_left'))
    drake.containers.push(document.querySelector('#category_column_right'))
    drake.on('drop', drop)

  $("#new_category_button").click ->
    input = $("#new_category_input").val()
    if input
      save_category(input)

  $(".voice_selector").change ->
    update_voice(this.options[this.selectedIndex].value)


  phrase_setup()
  category_setup()

