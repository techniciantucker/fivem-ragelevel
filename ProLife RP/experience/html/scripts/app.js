
$(function() {
	var audioPlayer = null;

    window.addEventListener('message', function(event) {
    	
		if (event.data.type == "changeLvl"){
			$('.lvl').html(event.data.level);
			$('.sp').html(event.data.points);
			$('.interior').css('width',Math.round(event.data.percent).toString() + '%')
		}else if(event.data.type == "playSound"){
			if (audioPlayer != null) {
	            audioPlayer.pause();
	          }

	          audioPlayer = new Audio("./sound/" + event.data.mp3 + ".ogg");
	          audioPlayer.volume = 0.3;
	          audioPlayer.play();
		}else if(event.data.type == "off"){
			$('#main_list').css("display","none");
			$('.box').css("display","none");
		}
	});
});


