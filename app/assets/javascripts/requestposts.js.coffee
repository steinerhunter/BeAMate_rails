$(document).ready( ->
  $('.delete_requestpost').live('ajax:success', ->
    $(this).closest('.feed_item').animate({ height: 'toggle', opacity: 'toggle' }, 'slow');
  );
);