var currentPage = '';

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
  } else if (data.type == "initalizeSystem") {
   $("#chargeList").html(data.chargeList); 
   $("#ibisHistory").html(data.weaponBrass); 
   $("#warrantList").html('<div class="warrant" onclick="newWarrant()"><h2 style="text-align: center; padding-top: 5px;"><i class="fas fa-plus"></i></h2></div>' + data.warrantList); 
  } else if (data.type == "loadWarrants") {
   $("#warrantList").html('<div class="warrant" onclick="newWarrant()"><h2 style="text-align: center; padding-top: 5px;"><i class="fas fa-plus"></i></h2></div>' + data.warrantList); 
   $("#ibisHistory").html(data.weaponBrass); 
  } else if (data.type == "ncicResult") {
   // Information 
   $("#ncicInfoName").html(data.info.name); 
   $("#ncicInfoGender").html(data.info.gender); 
   $("#ncicInfoDOB").html(data.info.dob); 
   $("#ncicInfoJob").html(data.info.job); 
   $("#ncicInfoNumber").html(data.info.number); 
   $("#ncicInfoCID").html(data.info.license); 
   $("#arrestList").html(data.arrest); 
   $("#vehicleList").html(data.vehicle); 
   $("#weaponList").html(data.weapons); 
   $("#homesList").html(data.homes); 
   $("#warningHistory").html(data.warnings);
   $("#cautionCodes").html('<h5>'+data.cautionCodes+'</h5>');
  } else if (data.type == "updateCalls") {
   $("#callList").html(data.callList); 
  }
 });

 $(document).mousemove(function(event) {
  cursorX = event.pageX;
  cursorY = event.pageY;
  UpdateCursorPos();
 });

 document.onkeyup = function(data) {
  if (data.which == 27) {
   $.post('http://clrp_mdt/escape');
  }
 };
});

function openPage(v) {
 $("#charges").css("display", "none");   
 $("#" + currentPage).css("display", "none");   
 currentPage = v; 
 $("#" + v).css("display", "block"); 
}


function addCharge(name, jail, fine) {
 $("#jailTime").val(parseInt($("#jailTime").val(), 0) + jail) 
 $("#fine").val(parseInt($("#fine").val(), 0) + fine) 
 $("#suspectChargeList").val($("#suspectChargeList").val() + name + ', \n');
};


function processSuspect() {
 var checkBox = document.getElementById("setAsWarning");
 $.post('http://clrp_mdt/processSuspect', JSON.stringify({id: $("#playerID").val(), time: $("#jailTime").val(), fine: $("#fine").val(), charges: $("#suspectChargeList").val(), isWarning: checkBox.checked})); 
 $("#playerID").val(0);
 $("#jailTime").val(0);
 $("#fine").val(0);
 $("#suspectChargeList").val('');
 checkBox.checked = false
};

function clearSuspect() {
 var checkBox = document.getElementById("setAsWarning");
 $("#playerID").val(0);
 $("#jailTime").val(0);
 $("#fine").val(0);
 $("#suspectChargeList").val('');
 checkBox.checked = false
};

var currentWarrant = 0;

function viewWarrant(name, description, vehicles, charges, officer, id, timestamp) {
 $("#suspectName").html(name + '<font style="float: right; padding-right: 15px; font-size: 22px; color: #999999">' + timestamp +'</font>'); 
 $("#suspectDesciption").html("Suspect's Desciption: " + description); 
 $("#suspectVehicles").html("Suspect's Known Vehicle: " + vehicles); 
 $("#suspectCharges").html("Suspect's Charges: " + charges); 
 $("#issuingOfficer").html("Issuing Officer: " + officer); 
 currentWarrant = id;
}

function newWarrant() {
 $(".viewWarrant").css("display", "none"); 
 $(".newWarrant").css("display", "block");
}

function submitNewWarrant() {
 $.post('http://clrp_mdt/newWarrant', JSON.stringify({name: $("#warrantName").val(), vehicles: $("#warrantVehicles").val(), description: $("#warrantDecription").val(), charges: $("#warrantCharges").val()})); 
 $("#warrantName").val('');
 $("#warrantVehicles").val('');
 $("#warrantDecription").val('');
}

function deleteWarrant() {
 $.post('http://clrp_mdt/deleteWarrant', JSON.stringify({id: currentWarrant})); 
}

function searchNCIC(search) {
 if (search == "Person") {
  $.post('http://clrp_mdt/searchNCIC', JSON.stringify({id: 1, firstname: $("#ncicSearchFirstname").val(), lastname: $("#ncicSearchLastname").val()})); 
 } else if (search == "Vehicle") {
  $.post('http://clrp_mdt/searchNCIC', JSON.stringify({id: 2, plate: $("#ncicSearchPlate").val()})); 
 } else if (search == "Firearm") {
  $.post('http://clrp_mdt/searchNCIC', JSON.stringify({id: 3, weapon: $("#ncicSearchWeapon").val()})); 
 } else if (search == "License") {
  $.post('http://clrp_mdt/searchNCIC', JSON.stringify({id: 4, license: $("#ncicSearchLicense").val()})); 
 }
} 

function showNCICInfo() {
 $(".ncicInformation").css("display", "block");
 $(".ncicWarnings").css("display", "none");
 $(".ncicTags").css("display", "none"); 
 $(".ncicArrests").css("display", "none");
 $(".ncicVehicles").css("display", "none");
 $(".ncicWeapons").css("display", "none");
 $(".ncicHomes").css("display", "none");
}

function showNCICArrest() {
 $(".ncicInformation").css("display", "none"); 
 $(".ncicArrests").css("display", "block");
 $(".ncicWarnings").css("display", "none");
 $(".ncicTags").css("display", "none");
 $(".ncicVehicles").css("display", "none");
 $(".ncicWeapons").css("display", "none");
 $(".ncicHomes").css("display", "none");
}

function showNCICVehicles() {
 $(".ncicInformation").css("display", "none"); 
 $(".ncicArrests").css("display", "none");
 $(".ncicVehicles").css("display", "block");
 $(".ncicWarnings").css("display", "none");
 $(".ncicTags").css("display", "none");
 $(".ncicWeapons").css("display", "none");
 $(".ncicHomes").css("display", "none");
}

function showNCICWeapons() {
 $(".ncicInformation").css("display", "none"); 
 $(".ncicArrests").css("display", "none");
 $(".ncicVehicles").css("display", "none");
 $(".ncicWeapons").css("display", "block");
 $(".ncicWarnings").css("display", "none");
 $(".ncicTags").css("display", "none");
 $(".ncicHomes").css("display", "none");
}

function showNCICProperys() {
 $(".ncicInformation").css("display", "none"); 
 $(".ncicArrests").css("display", "none");
 $(".ncicVehicles").css("display", "none");
 $(".ncicWeapons").css("display", "none");
 $(".ncicHomes").css("display", "block");
 $(".ncicWarnings").css("display", "none");
 $(".ncicTags").css("display", "none");
}

function showNCICWarnings() {
 $(".ncicInformation").css("display", "none"); 
 $(".ncicArrests").css("display", "none");
 $(".ncicVehicles").css("display", "none");
 $(".ncicWeapons").css("display", "none");
 $(".ncicHomes").css("display", "none");
 $(".ncicWarnings").css("display", "block");
 $(".ncicTags").css("display", "none");
}

function newNCICWarning() {
 $(".ncicInformation").css("display", "none"); 
 $(".ncicArrests").css("display", "none");
 $(".ncicVehicles").css("display", "none");
 $(".ncicWeapons").css("display", "none");
 $(".ncicHomes").css("display", "none");
 $(".ncicWarnings").css("display", "none");
 $(".ncicTags").css("display", "none");
}

function showNCICTags() {
 $(".ncicInformation").css("display", "none"); 
 $(".ncicArrests").css("display", "none");
 $(".ncicVehicles").css("display", "none");
 $(".ncicWeapons").css("display", "none");
 $(".ncicHomes").css("display", "none");
 $(".ncicTags").css("display", "block");
}

function updateTags(cid) {
 $.post('http://clrp_mdt/updateTags', JSON.stringify({id: cid, status: document.getElementById(cid).checked})); 
}

var currentCall = 0;

function viewCall(id, name, callerid, info, distance, timestamp, officers) {
 $("#callerName").html(name + '<font style="float: right; padding-right: 15px; font-size: 22px; color: #999999">' + callerid +'</font>'); 
 $("#callerVehicles").html("Call Information: " + info); 
 $("#callerDistance").html("Call Distance: " + distance);
 $("#callResponders").html("Currently Responding: " + officers); 
 currentCall = id;
}

function acceptCall() {
 $.post('http://clrp_mdt/acceptCall', JSON.stringify({id: currentCall})); 
}

function finishCall() {
 $.post('http://clrp_mdt/finishCall', JSON.stringify({id: currentCall})); 
 currentCall = 0;
}

function newCallReport() {
 $.post('http://clrp_mdt/newCallReport', JSON.stringify({name: $("#callName").val(), info: $("#additionalInfo").val(), incident: $("#incidentReport").val()})); 
 $("#callName").val('');
 $("#additionalInfo").val('');
 $("#incidentReport").val('');
}