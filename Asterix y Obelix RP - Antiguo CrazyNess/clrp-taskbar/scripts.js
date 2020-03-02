$(document).ready(function(){
  
  var documentWidth = document.documentElement.clientWidth;
  var documentHeight = document.documentElement.clientHeight;
  var curTask = 0;
  var processed = []
  function openMain() {
    $(".divwrap").fadeIn(10);
  }

  function closeMain() {
    $(".divwrap").css("display", "none");
  }  

  function endMain(psTask) {
    var index = processed.indexOf(psTask);
    if (index > -1) {
      $.post('http://np-taskbar/taskEnd', JSON.stringify({tasknum: curTask}));
      $(".divwrap").css("display", "none");
    }    
  }

  function moveProgressBar(passedCounter,Task) {
      var getPercent = ($('.progress-wrap').data('progress-percent') / 100);
      var getProgressWrapWidth = $('.progress-wrap').width();
      var progressTotal = getPercent * getProgressWrapWidth;
      var animationLength = passedCounter;
      curTask = Task
      processed.push(Task); 

      $('.progress-bar').stop().animate({
          width: progressTotal
      }, animationLength);

      setTimeout(function() {
          endMain(Task);
      }, animationLength)

  }

  window.addEventListener('message', function(event){

    var item = event.data;
    if(item.runProgress === true) {

      openMain();

      $('.progress-bar').stop().animate({
          width: 0
      }, 0);

      $(".nicesexytext").empty();
      $('.nicesexytext').append(item.name);
      moveProgressBar(item.Length,item.Task);
    }

    if(item.closeFail === true) {
      var index = processed.indexOf(curTask);
      if (index > -1) {
        processed.splice(index, 1);
      }
      $.post('http://np-taskbar/taskCancel', JSON.stringify({tasknum: curTask}));
    }


    if(item.closeProgress === true) {
      closeMain();
    }

  });

});
