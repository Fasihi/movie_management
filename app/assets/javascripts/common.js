$(document).on('page:load ready', function() {
  $('.movie-poster').load(function() {
    $(this).data('height', this.height);
    }).bind('mouseenter mouseleave', function(e) {
      $(this).stop().animate({
        height: $(this).data('height') * (e.type === 'mouseenter' ? 1.5 : 1)
      });
    });
});

$('span#review-'+ "<%= @review.id %>").html("<div class='btn btn-xs btn-danger'>Reported</div>");
