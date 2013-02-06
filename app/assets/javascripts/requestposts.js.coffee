$(document).ready( ->
  $('.delete_requestpost').live('ajax:success', ->
    $(this).closest('li').animate({ height: 'toggle', opacity: 'toggle' }, 'slow');
  );
);