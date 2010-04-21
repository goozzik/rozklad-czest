var v = new Date(); 
v = new Date($('#count_until_year').text(), $('#count_until_month').text(), $('#count_until_day').text(), $('#count_until_minute').text(), $('#count_until_second').text(), $('#count_until_year').text()); 
$('#noDays').countdown({until: v, format: 'HMS'}); 
