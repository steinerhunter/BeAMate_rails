$(document).ready( ->
  $('.delete_requestpost').bind('ajax:success', ->
    $(this).closest('li').animate({ height: 'toggle', opacity: 'toggle' }, 'slow');
  );
);