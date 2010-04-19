var newYear = new Date(); 
newYear = new Date(newYear.getFullYear() + 1, 1 - 1, 1); 
$('#defaultCountdown').countdown({until: newYear}); 
 
$('#removeCountdown').toggle(function() { 
        $(this).text('Re-attach'); 
        $('#defaultCountdown').countdown('destroy'); 
    }, 
    function() { 
        $(this).text('Remove'); 
        $('#defaultCountdown').countdown({until: newYear}); 
    } 
);

