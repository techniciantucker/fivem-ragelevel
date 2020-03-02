var documentWidth = document.documentElement.clientWidth;
var documentHeight = document.documentElement.clientHeight;

var cursor = document.getElementById("cursor");
var cursorX = documentWidth / 2;
var cursorY = documentHeight / 2;

function UpdateCursorPos() {
 cursor.style.left = cursorX;
 cursor.style.top = cursorY;
}

function Click(x, y) {
 var element = $(document.elementFromPoint(x, y));
 element.focus().click();
}

$(function() {
    window.addEventListener('message', function(event) {
     var data = event.data;
     if (data.type == "enableui") {
      document.body.style.display = data.enable ? "block" : "none";
      document.getElementById("text").value = data.text; 
      document.getElementById("text").focus();
     }
    });

    $(document).mousemove(function(event) {
     cursorX = event.pageX;
     cursorY = event.pageY;
     UpdateCursorPos();
    });

    document.onkeyup = function (data) {
     if (data.which == 27 ) {
      $.post('http://clrp_notepad/escape', JSON.stringify({text: document.getElementById("text").value}));
     }
    };
});

