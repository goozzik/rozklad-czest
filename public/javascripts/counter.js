var arrival_count = new Date();
arrival_count = new Date($('#count_until_year').text(), $('#count_until_month').text(), $('#count_until_day').text(), $('#count_until_hour').text(), $('#count_until_minute').text(), $('#count_until_second').text());
$(function () {
	$('#firstCountdown').countdown({until: arrival_count, format: 'HMS' });
});
