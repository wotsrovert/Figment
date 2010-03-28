jQuery(document).ready(function($) {
    $(document).ready(function() {
        $("tbody tr:first").addClass("first");
        $('input.category').click( refreshQuestions );
        refreshQuestions();
    });
});

function refreshQuestions(){
    $( 'div.questions > ul > li').addClass("toHide");
    $( 'input.category:checked').each( function(){ $( 'div.questions > ul > li.' + this.value ).removeClass("toHide");  });
    $( 'div.questions > ul > li.toHide').slideUp();
    $( 'div.questions ul li:not(.toHide)').slideDown();
    return true;
}
