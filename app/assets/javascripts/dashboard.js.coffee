$(document).ready ->
  if $('#more-notifications').length
    more_notifications.initialize()



more_notifications =
  months: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 
            'September', 'October', 'November', 'December'],
  initialize: ->
    $('#more-notifications').on 'click', ->
      url = $(this).data 'path'
      offset = $('.page-section').last().data 'date'
      $.ajax
        url: url
        data: { last_date: offset }
        beforeSend: ->
          $('#more-notifications').prop 'disabled', true
        success: (data) ->
          if data.empty
            $('#more-notifications').hide()
          else
            section = $('<section class="page-section" data-date="' + data.date + '"></section>')
            section.append '<h2 class="section-title">' + data.date + '</h2>'
            listing = $('<ul class="listing"></ul>')
            for notification in data.notifications
              notification = JSON.parse notification
              listing.append '<li class="list-item"><a href="' + notification.link + '" class="item-label">' + notification.body + '</a></li>'
            section.append listing
            $('#more-notifications').before section
            $('#more-notifications').prop 'disabled', false