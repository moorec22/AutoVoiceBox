$ ->
  drake = dragula({
    accepts: (el, target, source, sibling) ->
      return (el.classList.contains('phrase_box') &&
        target.classList.contains('category_body')) ||
        (el.classList.contains('outer_category_box') &&
        target.classList.contains('category_column'));
  })

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

  update_category_link = (category_id) ->
    $.ajax
      url: '/setting/current_category'
      type: 'POST'
      data : {'category': category_id}
      success: (data, status, response) ->
        $('#category_container').html(response.responseText)
      error: ->
        console.log('error')

  save_category = (category_name) ->
    $.ajax
      url: '/category'
      type: 'POST'
      data : {'name': category_name}
      success: (data, status, response) ->
        category = JSON.parse(response.responseText)
        link = $('<a>',{
          text: category['name'],
          category_id: category['id'],
          click: -> update_category_link(category['id'])
        })
        $('#category_list').append(link)
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

  $(".category_link").click ->
    update_category_link(this.getAttribute('category_id'))

  phrase_setup()
  category_setup()

