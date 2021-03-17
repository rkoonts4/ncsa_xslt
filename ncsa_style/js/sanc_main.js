$(document).ready(function(){
    $(".collapse").collapse("show")
});

$("button").click(function(event){
    var target = $(event.currentTarget.valueOf());
    var d_target = $(this).attr('label');
    var test = $(this).text();

    if(test == '- ' + d_target) {
        target.html('+ ' + d_target + " ");
    } else {
        target.html('- ' + d_target + " ");
    }
});

$(function() {
    // Desired offset, in pixels
    var offset = -100;
    if ($(window).width() < 768) {
        offset = -250;
    }

    // Desired time to scroll, in milliseconds
    var scrollTime = 500;

    $('a[href^="#"]').click(function() {
        // Need both `html` and `body` for full browser support
        $("html, body").animate({
            scrollTop: $( $(this).attr("href") ).offset().top + offset
        }, scrollTime);

    });
});