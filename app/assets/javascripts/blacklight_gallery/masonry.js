(function($){
  $.fn.BlacklightMasonry = function() {
    var container = this;
    if(container.length > 0) {
      container.imagesLoaded(function(){
        container.masonry();
      });
    }
  }
})(jQuery);

Blacklight.onLoad(function() {
  $('.documents-masonry').BlacklightMasonry();
});
