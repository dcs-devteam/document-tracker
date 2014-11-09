$(document).ready ->
  if $('#notifications').length > 0
    global_notifications.initialize()



global_notifications =
  initialize: ->
    $('#notifications').on 'click', global_notifications.seen
    setInterval(->
      url = $('#notifications').data 'poll-url'
      start = $('#notifications').data 'last'
      global_notifications.poll(url, start)
    , 3000)
    
  seen: ->
    _this = $(this)
    notifications = $(this).find('a').map(->
      return $(this).data 'id'
    ).get().join ','
    url = $(this).data 'url'

    if notifications.length
      $.ajax
        url: url
        data: { notifications: notifications }
        type: 'PATCH'
        success: (data) ->
          _this.removeClass('notify').attr 'data-count', 0

  poll: (url, start) ->
    $.ajax
      url: url
      data: { offset: start }
      type: 'GET'
      success: (data) ->
        if data.length
          $notifications = $('#notifications')
          $notifications.find('.no-notifications').remove()
          $dropdown = $('#notifications .dropdown')
          for notification in data
            $notifications.data 'last', notification.id
            $notification = $('<li><a href="' + notification.link + '" class="dropdown-item">' + notification.body + '</a></li>')
            $dropdown.prepend $notification
          count = parseInt $notifications.attr('data-count')
          $notifications.attr('data-count', count + data.length).addClass 'notify'