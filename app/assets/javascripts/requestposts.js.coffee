$(document).ready( ->
  $('.delete_requestpost').live('ajax:success', ->
    $(this).closest('div').animate({ height: 'toggle', opacity: 'toggle' }, 'slow');
  );
);