$(document).ready( ->
  $('.delete_matepost').live('ajax:success', ->
    $(this).closest('div').animate({ height: 'toggle', opacity: 'toggle' }, 'slow');
  );
);