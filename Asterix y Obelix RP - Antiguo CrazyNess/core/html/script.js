var documentWidth = document.documentElement.clientWidth;
var documentHeight = document.documentElement.clientHeight;

var cursor = document.getElementById("cursor");
var cursorX = documentWidth / 2;
var cursorY = documentHeight / 2;
var currentID = 0;

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
        if (event.data.type == "enableui") {
            cursor.style.display = event.data.enable ? "block" : "none";
            document.body.style.display = event.data.enable ? "block" : "none";
            if (event.data.enable) {
             $("#characters").html(event.data.characters);
             $(".dialog").css("display", "block");
            } else {
             $(".dialog").css("display", "none");
            }   
        } else if (event.data.type == "click") {
            // Avoid clicking the cursor itself, click 1px to the top/left;
            Click(cursorX - 1, cursorY - 1);
        }
    });

    $(document).mousemove(function(event) {
        cursorX = event.pageX;
        cursorY = event.pageY;
        UpdateCursorPos();
    });

    // Register Character Form
    $("#register").submit(function(e) {
        e.preventDefault();
        $(".dialog").css("display", "none");
        $("#characters").css("display", "block"); 
        $("#characterButtons").css("display", "block"); 
        $("#register").css("display", "none");
        $("#registerButtons").css("display", "none");
        $.post('http://core/create', JSON.stringify({
         firstname: $("#firstname").val(),
         lastname: $("#lastname").val(),
         dob: $("#dob").val(),
         twitter: $("#twitter").val(),
         gender: $('#gender').val(),
         backstory: $('#backstory').val()
        }));
    });
});

function newCharacter() {
 $("#characters").css("display", "none"); 
 $("#characterButtons").css("display", "none"); 
 $("#register").css("display", "block");
 $("#registerButtons").css("display", "block");
}

function showCharacters() {
 $("#characters").css("display", "block"); 
 $("#characterButtons").css("display", "block"); 
 $("#register").css("display", "none");
 $("#registerButtons").css("display", "none");
}

function selectCharacter(id) {
 if (currentID > 0) {
  $.post('http://core/selectcharacter', JSON.stringify({id: currentID}))
 }
 currentID = 0;
}

function deleteCharacter(id) {
 if (currentID > 0) {
  $.post('http://core/deletecharacter', JSON.stringify({id: currentID}))
 }
 currentID = 0;
}

function currentCharacter(id) {
 if (currentID > 0) {
  document.getElementById(currentID).style.backgroundColor = "#0052a5";
 }
 currentID = id;
 document.getElementById(id).style.backgroundColor = "#0080ff";
}