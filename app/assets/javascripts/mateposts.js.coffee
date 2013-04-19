$(document).ready( ->
  $('.delete_matepost').live('ajax:success', ->
    $(this).closest('.feed_item').animate({ height: 'toggle', opacity: 'toggle' }, 'slow');
  );
);