$ ->
  drake = dragula()

  say = (phrase) ->
    $.ajax
      url: '/speech'
      type: 'POST'
      data : {'phrase': phrase}
      success: (data, status, response) ->
      error: ->
        console.log('error')

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
    $.ajax
      url: '/setting/voice'
      type: 'POST'
      data: { 'voice': voice }
      error: ->
        console.log('error')
      

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
    phrase_id = el.getAttribute('phrase_id')
    category_id = target.getAttribute('category_id')
    if sibling
      next_phrase_id = sibling.getAttribute('phrase_id')
    else
      next_phrase_id = null
    update_phrase(phrase_id, category_id, next_phrase_id)

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
    drake.on('drop', drop)

  $("#new_category_button").click ->
    input = $("#new_category_input").val()
    if input
      save_category(input)

  $(".voice_selector").change ->
    update_voice(this.options[this.selectedIndex].value)


  phrase_setup()
  category_setup()

