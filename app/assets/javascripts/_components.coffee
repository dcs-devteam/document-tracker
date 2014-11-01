$(document).ready ->
  notifications.initialize()
  sidebar.initialize()
  buttons.initialize()
  choices.initialize()
  filters.initialize()



# overhead notifications
notifications = 
  initialize: ->
    if $('.notification').length
      notification = $('.notification')
      notification.css {'left': (notification.parent().width() - notification.width()) / 2 + 'px'}
      setTimeout(->
        notification.fadeOut(300)
      , 3000)



# sidebar contents
sidebar = 
  initialize: ->
    $('.sidebar-trigger').on 'click', (e) ->
      e.preventDefault()
      contents = $($(this).data('target')).html()
      $('#main-sidebar .replaceable-content').html contents
      $('#main-sidebar').addClass 'shown'
      $('main').removeClass 'expanded'

    $('.sidebar-exit').on 'click', ->
      $('#main-sidebar').removeClass 'shown'
      $('main').addClass 'expanded'

    if $('.hidden .form-errors').length
      target = $('.hidden .form-errors').closest('.hidden').attr 'id'
      $('.sidebar-trigger[data-target="#' + target + '"]').click()



# interactive buttons
buttons =
  initialize: ->
    $('.dropdown-trigger').on 'click', ->
      $('.dropdown-trigger.active').not($(this)).removeClass 'active'
      $(this).toggleClass 'active'

    $(document).on 'click', (e) ->
      unless $(e.target).closest('.dropdown-trigger').length or $(e.target).closest('.label-changeable[data-ready="false"]').length
        $('.dropdown-trigger').removeClass 'active'

    $('.split-dropdown.changeable .dropdown-item').on 'click', (e) ->
      e.preventDefault()
      changeable = $(this).closest('.split-dropdown.changeable')
      changeable.find('.label-changeable').text $(this).text()

      if changeable.hasClass 'initially-empty'
        changeable.find('.label-changeable').attr 'data-ready', 'true'

      if $(this).hasClass 'label-changer'
        element = changeable.find '.label-changeable'
        element.text $(this).data('label')

      if $(this).hasClass 'link-changer'
        element = changeable.find '.link-changeable'
        element.attr 'href', $(this).data('link')

      if $(this).hasClass 'value-changer'
        element = changeable.find '.value-changeable'
        element.val $(this).data('value')

    $('.split-dropdown').on 'click', '.label-changeable[data-ready="false"]', (e) ->
      e.preventDefault()
      trigger = $(this).next '.dropdown-trigger'
      $('.dropdown-trigger.active').not(trigger).removeClass 'active'
      trigger.toggleClass 'active'



# variable form choices
choices =
  initialize: ->
    $('#main-sidebar').on 'click', '.add-choices', (e) ->
      e.preventDefault()
      date = new Date()
      list = $($('#choices-list').html()).clone()
      name = list.find('select').attr 'name'
      list.find('select').attr 'name', "#{name}[#{date.valueOf()}]"
      $(this).before list

    $('#main-sidebar').on 'click', '.subfield .remover', ->
      $(this).parent().remove()



# filtering of list items
filters =
  initialize: ->
    $('.filter-field').on 'keyup', (e) ->
      query = $(this).val()
      target = $('.listing[data-filter-target="' + $(this).data('target') + '"]')
      results = target.find('.list-item').filter(->
        return $(this).find('*[data-filter-value]').filter(->
          return $(this).data('filter-value').match('^' + query)
        ).length > 0
      ).removeClass('hidden')
      target.find('.list-item').not(results).addClass('hidden')
      if !results.length
        target.find('.empty-listing').removeClass('hidden')
      else
        target.find('.empty-listing').addClass('hidden')