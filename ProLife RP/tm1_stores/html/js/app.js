$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type == "openNUI"){
            $('#main').css('display', 'block').fadeIn();
            $('#companyName').html(event.data.storeName);
            $('#woodTitle').html("Madera (" + event.data.wood + "%)");
            $('#foodTitle').html("Alimento (" + event.data.food + "%)");
            $('#mineTitle').html("Minerales (" + event.data.mine + "%)");
            $('#waterTitle').html("Agua (" + event.data.water + "%)");
            $('.wood-bar-fill').css('width',event.data.wood + '%');
            $('.food-bar-fill').css('width',event.data.food + '%');
            $('.mine-bar-fill').css('width',event.data.mine + '%');
            $('.water-bar-fill').css('width',event.data.water + '%');
        }else if(event.data.type == "closeUI"){
            $('#main').css('display', 'none');  
        }
    });

    $( "#sell" ).click(function() {
        $('#main').css('display', 'none');
        $.post('http://tm1_stores/sell', JSON.stringify({
            companyName: $("#companyName").html()
        }));
        $.post('http://tm1_stores/NUIFocusOff', JSON.stringify({}));
    });

    $( "#get" ).click(function() {
        $('#main').css('display', 'none');
        $.post('http://tm1_stores/get', JSON.stringify({
            companyName: $("#companyName").html()
        }));
        $.post('http://tm1_stores/NUIFocusOff', JSON.stringify({}));
    });
});

document.onkeyup = function(data){
    if (data.which == 27){
        $('#main').css('display', 'none');
        $.post('http://tm1_stores/NUIFocusOff', JSON.stringify({}));
    }
}
