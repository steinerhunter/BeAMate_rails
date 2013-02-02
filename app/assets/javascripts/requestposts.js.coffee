$(document).ready( ->
  $('.delete_requestpost').bind('ajax:success', ->
    $(this).closest('li').fadeOut();
  );
);