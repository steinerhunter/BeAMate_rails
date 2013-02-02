$(document).ready( ->
  $('.delete_matepost').bind('ajax:success', ->
    $(this).closest('li').fadeOut();
  );
);