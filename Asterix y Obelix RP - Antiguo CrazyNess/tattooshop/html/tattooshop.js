$(function(){
	var container = $("#tsContainer");
	var nameContainer = $("#tatNamesContainer");
				
	window.addEventListener("message", function(event)
	{
		var item = event.data;
		
		if (item.showShop)
		{
			container.show();		
		}
		else if (item.hideShop)
		{
			container.hide();
			nameContainer.hide();
		}
		else if (item.setTatNames)
		{
			var str = item.tatNames;
			
			$("#tatNames").children().detach();
			$("#tatNames").append(str);
			
			nameContainer.show();
		}
	});
	
	$(".menuoption").click(function(){
		var cat = $(this).data("cat");
		
		clearCategory();
		$(this).attr("class", "menuoption activecat");
				
		sendData("setTatCategory", {cat: cat});		
	});

	$(document).on("click", ".tatoption", function(){
		var name = $(this).html();
		
		sendData("setTattooPrev", {name: name});
	});
	
	$(document).on("mouseenter", ".tatoption", function(){
		if ($(this).attr("class") != "tatoption selected")
		{
			$(this).attr("class", "tatoption selected");
		}
	});
	
	$(document).on("mouseleave", ".tatoption", function(){
		if ($(this).attr("class") != "tatoption")
		{
			$(this).attr("class", "tatoption");
		}
	});
	
	$(".saveoption").click(function(){
		sendData("saveTattoos", "");
		sendData("escape", "");
		container.hide();
		nameContainer.hide();
	});
	
	$(".exitoption").click(function(){
		sendData("escape", "");
		container.hide();
		nameContainer.hide();
	});
	
	$(".resetoption").click(function(){
		var opt = $(this).data("opt");
		
		if (opt == "1")
		{
			$(".menuoption").each(function(){
				if ($(this).attr("class") == "menuoption activecat")
				{
					var cat = $(this).data("cat");
					var catname = $(this).html();
					sendData("resetTatForPart", {cat: cat, catname: catname});
				}
			});
		}
		else if (opt == "2")
		{
			sendData("resetAllTattoos", "");
		}
	});
	
	$(".menuoption").mouseenter(function(){
		if ($(this).attr("class") != "menuoption activecat")
		{
			if ($(this).attr("class") != "menuoption selected")
			{
				$(this).attr("class", "menuoption selected");
			}
		}
	});
	
	$(".menuoption").mouseleave(function(){
		if ($(this).attr("class") != "menuoption activecat")
		{
			if ($(this).attr("class") != "menuoption")
			{
				$(this).attr("class", "menuoption");
			}
		}
	});
	
	$(".saveoption").mouseenter(function(){
		if ($(this).attr("class") != "saveoption selected")
		{
			$(this).attr("class", "saveoption selected");
		}
	});
	
	$(".saveoption").mouseleave(function(){
		if ($(this).attr("class") != "saveoption")
		{
			$(this).attr("class", "saveoption");
		}
	});
	
	$(".exitoption").mouseenter(function(){
		if ($(this).attr("class") != "exitoption selected")
		{
			$(this).attr("class", "exitoption selected");
		}
	});
	
	$(".exitoption").mouseleave(function(){
		if ($(this).attr("class") != "exitoption")
		{
			$(this).attr("class", "exitoption");
		}
	});
	
	$(".resetoption").mouseenter(function(){
		if ($(this).attr("class") != "resetoption selected")
		{
			$(this).attr("class", "resetoption selected");
		}
	});
	
	$(".resetoption").mouseleave(function(){
		if ($(this).attr("class") != "resetoption")
		{
			$(this).attr("class", "resetoption");
		}
	});
});

function clearCategory()
{
	$(".menuoption").each(function(){
		if ($(this).attr("class") == "menuoption activecat")
		{
			$(this).attr("class", "menuoption");
		}
	});
}

function sendData(name, data)
{
    $.post("http://tattooshop/" + name, JSON.stringify(data), function(datab) {
        console.log(datab);
    });
}