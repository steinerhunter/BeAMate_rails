$(document).ready( ->
  $('.delete_matepost').live('ajax:success', ->
    $(this).closest('li').animate({ height: 'toggle', opacity: 'toggle' }, 'slow');
  );
);