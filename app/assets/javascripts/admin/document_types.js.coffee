$(document).ready ->
  if $('#create-document-type, #edit-document-type').length
    document_types.initialize()



document_types =
  initialize: ->
    cleaned = false
    $('#main-sidebar').on 'submit', 'form.new_document_type, form.edit_document_type', (e) ->
      if !cleaned
        e.preventDefault()
        route = $('#main-sidebar form select').map(->
          $(this).val()
        ).get().join ','
        $('#main-sidebar form input[name="document_type[route]"]').val route
        cleaned = true
        $(this).submit()