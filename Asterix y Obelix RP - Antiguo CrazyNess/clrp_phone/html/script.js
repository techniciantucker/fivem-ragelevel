var currentPage = ''; 
var phoneContacts = '';
var phoneNumber = '';
var phoneMessages = [];
var currentNumber = 'Unknown';
var callInfo = [];
var stockMarket = [];
var currentStockID = 0;

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
  if (data.type == "updateBanking") {
   $("#bankBalance").html(data.bankBalance);
   $("#sendMoneyBalance").html(data.bankBalance);
   $("#bankActivity").html(data.bankActivity);
  //Bullshit Phone Data
  } else if (data.type == "phoneData") {
   phoneContacts = data.contacts;
   $("#contactList").html(phoneContacts);
   $("#number").html(data.number);
  //Tweets
  } else if (data.type == "updateTweets") {
   $("#tweetList").html(data.tweets);
  } else if (data.type == "updateEmails") {
   $("#emailList").html(data.emails);
  } else if (data.type == "updateHousing") {
   $("#housingList").html(data.housingList);
  } else if (data.type == "updateMyVehicles") {
   $("#myVehicles").html(data.myVehicles);
  } else if (data.type == "updateDeepDark") {
   $("#deepWeb").css("display", "block"); 
   $("#deepWebList").html(data.tweets);
  } else if (data.type == "updateTruckingJob") {
    $("#trucking").css("display", "block"); 
    $("#truckingJobList").html(data.truckingList);
  //Messages
  } else if (data.type == "updateMessages") {
   $("#messagesList").html(data.recent);
   phoneMessages = data.all;
   if (currentNumber > 0) {$("#messageList").html(phoneMessages[currentNumber])}
  //Update Home Screen
  } else if (data.type == 'updateHomeScreen') {
   $("#time").html(data.time);
   $("#time2").html(data.time);
   $("#date").html(data.date);
   $("#myLocation").html(data.location);
  //Update Weather App
  } else if (data.type == 'updateWeatherAPP') {
   $("#newWeatherApp").html(data.weather);
   $("#currentTemp").html(data.temp + '°c ');
  //Stock Market
  } else if (data.type == 'updateStockMarket') {
   $("#stockMarket").html(data.myStock); 
   stockMarket = data.myStockMarket
  //Calling Bullshit
  } else if (data.type == 'callWaiting') {
   callInfo = data.callInfo;
   $("#callWaiting_number").html(currentNumber);
   openPage('callWaiting');
  } else if (data.type == 'callInProgress') {
   callInfo = data.callInfo;
   $("#callInProgress_number").html(callInfo.displayName);
   openPage('callInProgress');
  } else if (data.type == "enableui") {
   cursor.style.display = data.enable ? "block" : "none";
   document.body.style.display = data.enable ? "block" : "none";
  }
 });

 $(document).mousemove(function(event) {
  cursorX = event.pageX;
  cursorY = event.pageY;
  UpdateCursorPos();
 });

 document.onkeyup = function(data) {
  if (data.which == 27 ) {
   $.post('http://clrp_phone/escape', JSON.stringify({}));
  }
 };
});


function homePage() {$(".homePage").css("display", "block"); $("#" + currentPage).css("display", "none")}
function openPage(v) {
 $("#" + currentPage).css("display", "none");   
 currentPage = v; 
 $("#" + v).css("display", "block"); 
 $(".homePage").css("display", "none")
}

/* Contacts */
function messageService(id) {$.post('http://clrp_phone/contactServices', JSON.stringify({id: id, message: $("#serviceMessage").val()})); homePage()}
function newContact() {$("#addContact").css("display", "block")}
function closeContact() {$("#addContact").css("display", "none")}
function deleteContact(currentContact) {$.post('http://clrp_phone/removeContact', JSON.stringify({id: currentContact}))}
function addContact() {$.post('http://clrp_phone/newContact', JSON.stringify({name: $("#contact_name").val(), number: $("#contact_number").val()})); $("#addContact").css("display", "none")}
function sendMessage() {$.post('http://clrp_phone/newMessage', JSON.stringify({message: $("#new_message").val(), number: currentNumber})); $("#new_message").val('')}
function openMessages(id) {
 $("#messageList").html(''); 
 $("#messageList").html(phoneMessages[id]); 
 $("#messagesPage").css("display", "none"); 
 $("#contactsPage").css("display", "none"); 
 $("#messagePage").css("display", "block"); 
 currentNumber = id; 
 currentPage = 'messagePage';
}

/* Tweeting */
function newTweet() {$.post('http://clrp_phone/newTweet', JSON.stringify({message: $("#new_tweet").val()})); $("#new_tweet").val('')}
function newDeepDark() {$.post('http://clrp_phone/newDeepDark', JSON.stringify({message: $("#newDeepDark").val()})); $("#newDeepDark").val('')}


/* Calling */
function callContact(number) {
 $.post('http://clrp_phone/startCall', JSON.stringify({number: number}));
 $("#startCall_number").html(number);
 currentNumber = number; 
 openPage('startCall');
}

function answerCall() {
 $.post('http://clrp_phone/answerCall', JSON.stringify({callInfo: callInfo}));
 $("#startCall_number").html(currentNumber);
}

function declineCall() {
 $.post('http://clrp_phone/rejectCall', JSON.stringify({callInfo: callInfo}));
 $("#startCall").css("display", "none");
 $("#callWaiting").css("display", "none");
 $("#callInProgress").css("display", "none");
 $("#contactsPage").css("display", "none");
 homePage();
}


/* Our Fancy Banking */
function getBills() {$.post('http://clrp_phone/getBills')}
function payBills() {$.post('http://clrp_phone/payBills')}
function truckingMission(tid) {$.post('http://clrp_phone/truckingMission', JSON.stringify({id: tid})); homePage()}
function setLocation(x,y) {$.post('http://clrp_phone/setLocation', JSON.stringify({x: x, y: y})); homePage()}
function sendMoney() {$.post('http://clrp_phone/sendMoney', JSON.stringify({id: $("#transfer_id").val(), amount: $("#transfer_amount").val()})); $("#transfer_id").val(''); $("#transfer_amount").val(''); homePage()}
function buyStock() {$.post('http://clrp_phone/buyStock', JSON.stringify({id: currentStockID, amount: $("#stock_amount").val()})); $("#stock_amount").val(''); openPage('stockPage')}
function sellStock() {
  $.post('http://clrp_phone/sellStock', JSON.stringify({id: currentStockID, amount: $("#stock_amount").val()})); 
  $("#stock_amount").val(''); 
  openPage('stockPage')
}



function openStockPage(id) {
 openPage('myStockPage')
 var currentStock = stockMarket[id-1]
 currentStockID = currentStock.iD;
 $("#stockName").html(currentStock.stockName); 
 $("#stockProfit").html(currentStock.stockProfit); 
 $("#stockOwned").html(currentStock.stockOwned); 
 $("#stockCost").html(currentStock.purchasePrice); 
 $("#stockPreviousCost").html(currentStock.previousCost); 
}

/* Settings Page */
function muteNotifications() {
 var checkBox = document.getElementById("muteNotifications");
 $.post('http://clrp_phone/muteNotifications', JSON.stringify({status: checkBox.checked})); 
}

$("#selectorBackground").change(function(){
  $(".display").css("background-image", "url("+ $("#selectorBackground").val() +")"); 
});

function sendMyNumber() {
 $.post('http://clrp_phone/sendMyNumber'); 
}

