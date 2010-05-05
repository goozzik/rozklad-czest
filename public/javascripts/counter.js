$(function () {
	var year = $('#count_until_year').text();
	var month = $('#count_until_month').text();
	var day = $('#count_until_day').text();
	var hour = $('#count_until_hour').text();
	var minute = $('#count_until_minute').text();
	var arrival_count = new Date();
	var arrival_count = new Date(year, month - 1, day, hour, minute);
	$('#firstCountdown').countdown({until: arrival_count, format: 'HMS', compact: true,});
});
