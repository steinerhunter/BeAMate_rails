$(document).ready( ->
  $('.delete_requestpost').on('ajax:success', ->
    $(this).closest('.feed_item').animate({ height: 'toggle', opacity: 'toggle' }, 'slow');
  );
);