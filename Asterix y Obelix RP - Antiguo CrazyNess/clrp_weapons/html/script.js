var currentMelee = 0;
var currentPistol = 0;
var currentRifle = 0;
var currentOther = 0;

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
   $("#meleeWeapons").html(data.melee);
   $("#pistolWeapons").html(data.pistol);
   $("#rifleWeapons").html(data.rifle);
   $("#otherWeapons").html(data.other);
   if (currentMelee > 0) {document.getElementById(currentMelee).style.backgroundColor = 'rgba(0, 128, 255,0.4)'}
   if (currentPistol > 0) {document.getElementById(currentPistol).style.backgroundColor = 'rgba(0, 128, 255,0.4)'}
   if (currentRifle > 0) {document.getElementById(currentRifle).style.backgroundColor = 'rgba(0, 128, 255,0.4)'} 
   if (currentOther > 0) {document.getElementById(currentOther).style.backgroundColor = 'rgba(0, 128, 255,0.4)'}
  } else if (data.type == 'resetUI') {
   if (currentMelee > 0) {document.getElementById(currentMelee).style.backgroundColor = 'rgba(0,0,0,0.5)'; currentMelee = 0;}
   if (currentPistol > 0) {document.getElementById(currentPistol).style.backgroundColor = 'rgba(0,0,0,0.5)'; currentPistol = 0;}
   if (currentRifle > 0) {document.getElementById(currentRifle).style.backgroundColor = 'rgba(0,0,0,0.5)'; currentRifle = 0;} 
   if (currentOther > 0) {document.getElementById(currentOther).style.backgroundColor = 'rgba(0,0,0,0.5)'; currentOther = 0;}
   $("#meleeWeapons").html('');
   $("#pistolWeapons").html('');
   $("#rifleWeapons").html('');
   $("#otherWeapons").html('');
  }
 });

 $(document).mousemove(function(event) {
  cursorX = event.pageX;
  cursorY = event.pageY;
  UpdateCursorPos();
 });

 document.onkeydown = function(data) {
  if (data.which == 27) {
   $.post('http://clrp_weapons/escape', JSON.stringify({melee: currentMelee, pistol: currentPistol, rifle: currentRifle, other: currentOther}));
  } else if (data.which == 87) {
   $.post('http://clrp_weapons/escape', JSON.stringify({melee: currentMelee, pistol: currentPistol, rifle: currentRifle, other: currentOther}));
  } 
 };
});

function selectMelee(id) {
 if (currentMelee > 0) {
  document.getElementById(currentMelee).style.backgroundColor = 'rgba(0,0,0,0.5)';
 }
 currentMelee = id
 document.getElementById(id).style.backgroundColor = 'rgba(0, 128, 255,0.4)';
}

function selectPistol(id) {
 if (currentPistol > 0) {
  document.getElementById(currentPistol).style.backgroundColor = 'rgba(0,0,0,0.5)';
 }
 currentPistol = id
 document.getElementById(id).style.backgroundColor = 'rgba(0, 128, 255,0.4)';
}

function selectRifle(id) {
 if (currentRifle > 0) {
  document.getElementById(currentRifle).style.backgroundColor = 'rgba(0,0,0,0.5)';
 }
 currentRifle = id
 document.getElementById(id).style.backgroundColor = 'rgba(0, 128, 255,0.4)';
}

function selectOther(id) {
 if (currentOther > 0) {
  document.getElementById(currentOther).style.backgroundColor = 'rgba(0,0,0,0.5)';
 }
 currentOther = id
 document.getElementById(id).style.backgroundColor = 'rgba(0, 128, 255,0.4)';
}