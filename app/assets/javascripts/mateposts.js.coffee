$(document).ready( ->
  $('.delete_matepost').bind('ajax:success', ->
    $(this).closest('li').animate({ height: 'toggle', opacity: 'toggle' }, 'slow');
  );
);