
let NegDinero = 0;


function abrirMenuJefe(){
	$('#background').show();
	$("body").css("display", "block");

}

function cerrarMenuJefe(){
	$('#background').hide();
	$("body").css("display", "none");

}

function abrirOpcionesMenu(){
	$('#background').hide();
	$("body").css("display", "block");
	$("#opciones").show();
	$("#balance").html("Balance: <span style='color: green;'>$"+NegDinero+"</span>");

}


function cerrarOpcionesMenu(){
	$("body").css("display", "none");
	$("#opciones").hide();
}




$(function() {

    window.addEventListener('message', function(event) {

		if (event.data.type == "jefeOn"){
			document.body.style.display = "block";

			NegDinero = event.data.dinero;
			abrirMenuJefe();
		}else if(event.data.type == "jefeOff") {
			document.body.style.display = "none";
			cerrarMenuJefe();
			cerrarOpcionesMenu();
		
		}else if(event.data.type == 'updateBalance'){
			NegDinero = event.data.dinero;
			abrirOpcionesMenu();
			

		}
	});
	

	
    document.onkeyup = function (data) {
        if (data.which == 27) { // Escape key
			$.post('http://chaini_negocios/escape', JSON.stringify({}));
			cerrarMenuJefe();
			cerrarOpcionesMenu();
        }
	};

   $("#botonBG2").click(function(){
		cerrarMenuJefe();
		abrirOpcionesMenu();
   });


	$("#depirardinerobt").click(function(){
		var dineros = $('#depdineroin').val();

		if (dineros > 0){
			$.post('http://chaini_negocios/manageBalance', JSON.stringify({
				tipo: 'depositar',
				money: dineros
			}));
		}
	});

	$("#retirardinerobt").click(function(){
		var dineros = $('#retdineroin').val();

		if (dineros <= NegDinero){
			$.post('http://chaini_negocios/manageBalance', JSON.stringify({
				tipo:'retirar',
				money: dineros
			}));
		}
	});

	$("#botonnombre").click(function(){
		var nombre = $('#nombrecambiar').val();
		validRegEx = /^[^\\\/&]*$/

		if(nombre.match(validRegEx) == null){
			nombre = '';
		}
		$.post('http://chaini_negocios/cambioNombre', JSON.stringify({
			str: nombre
		}));
	});

	$("#usuarioboton").click(function(){
		var precio = $('#precio').val();
		var iduser = $('#iduser').val();
		if (precio > 0){
			$.post('http://chaini_negocios/vendernegocio', JSON.stringify({
				precio: precio,
				usuario: iduser
			}));
		}
		cerrarOpcionesMenu();
	});

	$("#venderGobBoton").click(()=>{
		$.post('http://chaini_negocios/venderGob', JSON.stringify({}));
	});

});




