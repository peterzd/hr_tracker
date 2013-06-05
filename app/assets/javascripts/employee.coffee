$ ->
  $("#link_list_all").bind("ajax:success", (evt, data, status, xhr)=> $(".table").empty().html(xhr.responseText) )
