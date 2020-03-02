$(document).ready(function () {
	
	var documentWidth = document.documentElement.clientWidth;
	var documentHeight = document.documentElement.clientHeight;
				
	window.addEventListener('message', function (event) {
		var item = event.data;

		if (item.open === true) {
			$('#impound-form').css('display', 'block');
			$('#newspaper').css('display', 'none');
		}
		if (item.open == false) {
			$('#impound-form').css('display', 'none');
			$('#newspaper').css('display', 'none');
			$('#bennys').css('display', 'none');
		}
		if (item.news == true) {
			$('#impound-form').css('display', 'none');
			$('#newspaper').css('display', 'block');
		}
		if (item.bennys == true) {
			$('#bennys').css('display', 'block');
		}
	})
		
	document.onkeyup = function (data) {
		if (data.which == 27 ) {
			$.post('http://clrp_bennys/escape', JSON.stringify({}));
		}
	};
	
	$('#confirmsale').click(function (event) {
		$.post('http://clrp_bennys/confirmsale', JSON.stringify({
			seller: $('#seller').val(),
			ownerid: $('#ownerid').val(),
			owner: $('#owner').val(),
			price: $('#price').val(),
			sellprice: $('#import_price').val(),
			notes: $('#notes').val(),
		}));
	});
		
	$('#cancel, #exit').click(function (event) {
		$.post('http://clrp_bennys/escape', null);
	});
	
});