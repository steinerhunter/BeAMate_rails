$(document).ready( ->
  $('.delete_matepost').on('ajax:success', ->
    $(this).closest('.feed_item').animate({ height: 'toggle', opacity: 'toggle' }, 'slow');
  );
);