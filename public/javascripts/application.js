$(function() {
  var intervalId = ''; 
  $.ajax({
    url: '/items/history',
    data: {
      keyword: $('input#buy').val()
    },
    dataType: 'html',
    success: function(data) {
      $('ul#history').replaceWith(data);
      $('ul#history>li').hide();
    }    
  });

  function listen_input(e) {
    if (intervalId != '') {
      clearTimeout(intervalId);
    }
    intervalId = setTimeout(function() {
      var pattern = new RegExp($('input#buy').val());
      $('ul#history>li').each(function(i, elm) {
        if ($(elm).text().match(pattern)) {
          $(elm).show();
        } else {
          $(elm).hide();
        }
      });
    }, 100);
  }
  $('input#buy')
    .live('click', listen_input)
    .live('keyup', listen_input); 
  $('ul#history>li>a').live('click', function(e) {
    e.preventDefault();
    $('input#buy').val($(this).text()); 
    $('ul#history li').hide();
  });

  $('input#price').live('click', function(e) {
    $('ul#history li').hide();
  });
});
