function refresh() {
	location.reload();
}
$(function () {
	var year = parseInt($('#count_until_year').text());
	var month = parseInt($('#count_until_month').text());
	var day = parseInt($('#count_until_day').text());
	var hour1 = parseInt($('#count_until_hour1').text());
	var minute1 = parseInt($('#count_until_minute1').text());
	var hour2 = parseInt($('#count_until_hour2').text());
	var minute2 = parseInt($('#count_until_minute2').text());
	var arrival_count1 = new Date();
	var arrival_count1 = new Date(year, month - 1, day, hour1, minute1);
	$('#firstCountdown').countdown({until: arrival_count1, format: 'HMS', compact: true, onExpiry: refresh});
	var arrival_count2 = new Date();
	var arrival_count2 = new Date(year, month - 1, day, hour2, minute2);
	$('#secondCountdown').countdown({until: arrival_count2, format: 'HMS', compact: true});
});

