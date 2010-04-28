var arrival_count = new Date();
// Problem z $('#count_until_hour').text() wyświetla jako string a musi być integer
var arrival_count = new Date(arrival_count.getFullYear(), 4, 29, $('#count_until_hour').text(), $('#count_until_minute').text());
$(function () {
	$('#firstCountdown').countdown({until: arrival_count, format: 'HMS', compact: true,});
});
