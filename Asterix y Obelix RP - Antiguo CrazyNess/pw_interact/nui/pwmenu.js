var Config = new Object();
Config.closeKeys = [27, 121];
var keepOpen = false;
var cancelEvent = null;
var sliderObjects = null;
var forceDisableNext = false;
var forceDisablePrev = true;
var menuTypeActive = null;
var enableKeySwitch = false;
var autoPreview = false;
var previewTriggerType = null;
var previewTrigger = null;
var anyData = null;
var itemInfo = null;
var swapKeyEnabled = false;
var preventClose = false;
var taskHandsUp = false;
var resetCamera = null;
var colorTrigger = null;
var colorTriggerType = null;
var allowSkinMouseMove = false;
var menuOpen = false;

window.addEventListener("message", function (event) {    
    if(event.data.action == "openMenu") {
        menuOpen = true;
        $('#menuContainer').css({"display":"none"});
        $('#formContainer').css({"display":"none"});
        $('#blipContainerColor').css({"display":"none"});
        $('#blipContainer').css({"display":"none"});
        $('#colorPickerContainer').css({"display":"none"});
        $('#skinContainer').css({"display":"none"});
        $('#selectorContainer').css({"display":"none"});
        $('#resetCamera').css({"display":"none"});
        $('#formButtons').css({"display":"block"});
        keepOpen = event.data.keepOpen
        if(event.data.cancel !== undefined && event.data.cancel !== null) {
            cancelEvent = event.data.cancel
        }
        populateMenu(event.data);
        $("#menuContainer").css({"display":"block"});
        menuTypeActive = "normal"
    } else if(event.data.action == "openForm") {
        menuOpen = true;
        $('#menuContainer').css({"display":"none"});
        $('#formContainer').css({"display":"none"});
        $('#blipContainerColor').css({"display":"none"});
        $('#blipContainer').css({"display":"none"});
        $('#colorPickerContainer').css({"display":"none"});
        $('#skinContainer').css({"display":"none"});
        $('#selectorContainer').css({"display":"none"});
        $('#formButtons').css({"display":"block"});
        keepOpen = event.data.keepOpen
        if(event.data.cancel !== undefined && event.data.cancel !== null) {
            cancelEvent = event.data.cancel
        }
        $('#formDiv').css({"max-width":""+ event.data.width +""}).css({"min-width":""+ event.data.width +""});
        populateForm(event.data);
        menuTypeActive = "form"
    } else if(event.data.action == "simulateClose") {
        $('[data-act=skinBack]').click();
        setTimeout(function() {
            if (menuOpen === true) {
                menuOpen = false;
                $('[data-act=closeMenu]').click();
            }
        }, 500)
    } else if(event.data.action == "updateMouseSkinMove") {
        $('#mouseMovementSkin').html(event.data.text);
    } else if(event.data.action == "openBlips") {
        menuOpen = true;
        $('#menuContainer').css({"display":"none"});
        $('#formContainer').css({"display":"none"});
        $('#blipContainerColor').css({"display":"none"});
        $('#blipContainer').css({"display":"none"});
        $('#colorPickerContainer').css({"display":"none"});
        $('#skinContainer').css({"display":"none"});
        $('#selectorContainer').css({"display":"none"});
        $('#blipContainer').css({"display":"block"})
        $('#blipId').data('trigger', event.data.trigger);
        $('#blipId').data('triggertype', event.data.triggertype);
        if(event.data.cancel !== undefined && event.data.cancel !== null) {
            cancelEvent = event.data.cancel
        }
    } else if(event.data.action == "openBlipColor") {
        colorTrigger = null;
        colorTriggerType = null;
        menuOpen = true;
        $('#menuContainer').css({"display":"none"});
        $('#formContainer').css({"display":"none"});
        $('#blipContainerColor').css({"display":"none"});
        $('#blipContainer').css({"display":"none"});
        $('#colorPickerContainer').css({"display":"none"});
        $('#skinContainer').css({"display":"none"});
        $('#selectorContainer').css({"display":"none"});
        $('#blipContainerColor').css({"display":"block"});
        colorTrigger = event.data.trigger;
        colorTriggerType = event.data.triggertype;
        if(event.data.cancel !== undefined && event.data.cancel !== null) {
            cancelEvent = event.data.cancel
        }
    } else if(event.data.action == "closeMenu") {
        menuOpen = false;
        $('#menuContainer').css({"display":"none"});
        $('#formContainer').css({"display":"none"});
        $('#blipContainerColor').css({"display":"none"});
        $('#blipContainer').css({"display":"none"});
        $('#colorPickerContainer').css({"display":"none"});
        $('#skinContainer').css({"display":"none"});
        $('#selectorContainer').css({"display":"none"});
        $('#swapKey').css({"display":"none"});
        $('#allowHandsUp').css({"display":"none"});
        $('#resetCamera').css({"display":"none"});
        cancelEvent = null;
        swapKeyEnabled = false;
        cancelMethod = null;
        forceDisableNext = false;
        forceDisablePrev = true;
        menuTypeActive = null;
        autoPreview = false;
        previewTriggerType = null;
        previewTrigger = null;
        anyData = null;
        preventClose = false;
        taskHandsUp = false;
        resetCamera = null;
        colorTrigger = null;
        colorTriggerType = null;
    } else if(event.data.action == "openSlider") {
        menuOpen = true;

        $('#menuContainer').css({"display":"none"});
        $('#formContainer').css({"display":"none"});
        $('#blipContainerColor').css({"display":"none"});
        $('#blipContainer').css({"display":"none"});
        $('#colorPickerContainer').css({"display":"none"});
        $('#skinContainer').css({"display":"none"});
        $('#selectorContainer').css({"display":"none"});
        $('#loading').css({"display":"none"});
        if(event.data.cancel !== undefined && event.data.cancel !== null) {
            cancelEvent = event.data.cancel
        }
        generateSlider(event.data);
        menuTypeActive = "slider"
    } else if(event.data.action == "skinSliders") {
        menuOpen = true;
        $('#menuContainer').css({"display":"none"});
        $('#formContainer').css({"display":"none"});
        $('#blipContainerColor').css({"display":"none"});
        $('#blipContainer').css({"display":"none"});
        $('#colorPickerContainer').css({"display":"none"});
        $('#skinContainer').css({"display":"none"});
        $('#selectorContainer').css({"display":"none"});
        $('#loading').css({"display":"none"});
        skinMenu(event.data);
        menuTypeActive = "skinMenu"
    } else if(event.data.action == "enableSlider") {
        menuOpen = true;
        if(!forceDisableNext) {
        $('#nxtBtn').html('<i class="fas fa-arrow-right"></i>');
        $('#nxtBtn').removeClass('disabled');
        }

        if(!forceDisablePrev) {
        $('#preBtn').removeClass('disabled');
        $('#preBtn').html('<i class="fas fa-arrow-left"></i>');
        }
        $('#loading').css({"display":"none"});
    } else if(event.data.action == "resetMouseText") {
        $('[data-actionID=menuSwitcher]').css({"display":"block"}).html('<small>PRESS <span class="text-dark">Z</span> TO ACCESS IN-GAME MOUSE</small>');
    } else if(event.data.action == "colorPicker") {
        menuOpen = true;
        $('#colorDiv').css({"max-width":""+ event.data.width +""}).css({"min-width":""+ event.data.width +""});
        generateColorPicker(event.data)
    }
});

var colorPreview = $('#menuOptions'), 
    r = document.querySelector('#r'),
    g = document.querySelector('#g'),
    b = document.querySelector('#b');

function setColor(){
    $('#colorSave').data('r', r.value);
    $('#colorSave').data('g', g.value);
    $('#colorSave').data('b', b.value);
    $('#colorPreview').data('r', r.value);
    $('#colorPreview').data('g', g.value);
    $('#colorPreview').data('b', b.value);
    $('#selectedColor').css("background-color", "rgb(" + r.value + "," + g.value + "," + b.value + ")");
    if(autoPreview === true) {
        if(previewTrigger !== null && previewTriggerType !== null) {
            $.post("http://pw_interact/colorPreview", JSON.stringify({
                r: parseInt(r.value),
                g: parseInt(g.value),
                b: parseInt(b.value),    
                action: previewTrigger,
                trigger: previewTriggerType,
                data: anyData
            }));
        }
    }
}

function generateColorPicker(data) {
    $('#menuContainer').css({"display":"none"});
    $('#formContainer').css({"display":"none"});
    $('#blipContainerColor').css({"display":"none"});
    $('#blipContainer').css({"display":"none"});
    $('#colorPickerContainer').css({"display":"none"});
    $('#skinContainer').css({"display":"none"});
    $('#selectorContainer').css({"display":"none"});
    $('#colorSave').removeClass('disabled');
    $('#colorPreview').removeClass('disabled');
    $('#r').val('0');
    $('#g').val('0');
    $('#b').val('0');
    if (data.title !== null && data.title !== undefined) {
        $('#colorTitle').html(data.title);
    }

    if(data.options.menuSwitcher !== undefined && data.options.menuSwitcher !== null && data.options.menuSwitcher === true) {
        enableKeySwitch = true
        $('[data-actionID=menuSwitcher]').css({"display":"block"}).html('<small>PRESS <span class="text-dark">Z</span> TO ACCESS IN-GAME MOUSE</small>');
    }

    if(data.options.autoPreview !== undefined && data.options.autoPreview !== null && data.options.autoPreview === true) {
        autoPreview = true
        if(data.data !== undefined && data.data !== null) {
            anyData = data.data
        }
    }

    if(data.cancel !== undefined && data.cancel !== null) {
        cancelEvent = data.cancel
    }

    if(data.triggers.saveTrigger !== undefined && data.triggers.saveTrigger !== null) {
        $('#colorSave').data('trigger', data.triggers.saveTrigger.trigger);
        $('#colorSave').data('type', data.triggers.saveTrigger.type);
        if(data.data !== undefined && data.data !== null) {
            $('#colorSave').data('data', data.data);
        }
    } else {
        $('#colorSave').addClass('disabled')
    }
    if(data.triggers.previewTrigger !== undefined && data.triggers.previewTrigger !== null) {
        $('#colorPreview').data('trigger', data.triggers.previewTrigger.trigger);
        $('#colorPreview').data('type', data.triggers.previewTrigger.type);
        previewTrigger = data.triggers.previewTrigger.trigger
        previewTriggerType = data.triggers.previewTrigger.type
        if(data.data !== undefined && data.data !== null) {
            $('#colorPreview').data('data', data.data);
            anyData = data.data
        }
    } else {
        $('#colorPreview').addClass('disabled');
    }

    setColor();

    $('#colorPickerContainer').css({"display":"block"});
}

function populateMenu(menus) {
    cancelEvent = null;
    $('#menuContainer').css({"display":"none"});
    $('#formContainer').css({"display":"none"});
    $('#blipContainerColor').css({"display":"none"});
    $('#blipContainer').css({"display":"none"});
    $('#colorPickerContainer').css({"display":"none"});
    $('#skinContainer').css({"display":"none"});
    $('#selectorContainer').css({"display":"none"});
    $('#menuOptions').html('');

    if (menus.menuTitle !== null && menus.menuTitle !== undefined) {
    $('#menuTitle').html(menus.menuTitle);
    }

    $.each(menus.menuOptions, function (subindex, menu) {
        if(menu.subMenu !== null && menu.subMenu !== undefined) {
            // Standard Menu, but as a Dropdown
            $('#menuOptions').append('<div class="btn-group" role="group"><button id="' + subindex + '" data-menuid="'+ subindex +'" type="button" class="btn btn-' + menu.color + ' dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">' + menu.label + '</button><div class="dropdown-menu subMenuScroll" aria-labelledby="' + subindex + '" style="max-height:300px; overflow-y:scroll;" data-boundary="viewport" id="drop-' + subindex + '"></div></div>');
            $.each(menu.subMenu, function (index, submenu) {
                $('#drop-' + subindex).append('<a class="dropdown-item" href="#" data-act="completeRequest" data-subid="' + subindex + '-' + index + '" data-action="' + submenu.action + '" data-trigger="' + submenu.triggertype + '" style="z-index:9999;">' + submenu.label + '</a>');
                $('[data-subid=' + subindex + '-' + index + ']').data("value", submenu.value);
            });
        } else {
            // Standard Menu Option
            $('#menuOptions').append('<button type="button" id="' + subindex + '" class="btn btn-' + menu.color + '" data-menuid="'+ subindex +'" data-act="completeRequest" data-action="' + menu.action + '" data-trigger="' + menu.triggertype + '">' + menu.label + '</button>');
            $('[data-menuid='+subindex+']').data("value", menu.value);
        }
    });

    if(menus.options.preventClose !== undefined && menus.options.preventClose !== null && menus.options.preventClose === true) {
        $('#menuCloseButton').css({"display":"none"});
        preventClose = true
    }

    if(menus.cancel !== undefined) {
        cancelEvent = menus.cancel
    }
    $('#menuContainer').css({"display":"block"});
}

function populateForm(form) {
    cancelEvent = null;
    $('#menuContainer').css({"display":"none"});
    $('#formContainer').css({"display":"none"});
    $('#blipContainerColor').css({"display":"none"});
    $('#blipContainer').css({"display":"none"});
    $('#colorPickerContainer').css({"display":"none"});
    $('#skinContainer').css({"display":"none"});
    $('#selectorContainer').css({"display":"none"}); 
    $('#formOptions').html('');
    preventClose = false;

    if (form.menuTitle !== null && form.menuTitle !== undefined) {
        $('#formTitle').html(form.menuTitle);
    }

    $('#formOptions').append('<input type="hidden" name="submitAction" id="submitAction" value="' + form.submitTrigger + '"><input type="hidden" name="submitMethod" id="submitMethod" value="' + form.submitMethod + '">')
    $.each(form.formOptions, function (index, element) {
        if (element.type == "writting") {
            if(element.align !== undefined && element.align !== null) {
                align = element.align
            } else {
                align = "left"
            }
            $('#formOptions').append('<div class="row"><div class="col-12 p-2 text-' + align + '">' + element.value + '</div></div>');
        }
        if (element.type == "hr") { 
            $('#formOptions').append('<div class="row"><div class="col-12 p-0"><hr></div></div>');
        }
        if (element.type == "number") {
            if(element.placeholder !== undefined && element.placeholder !== null) { placeholder = ' placeholder="' + element.placeholder + '"'; } else { placeholder = ''}
            if(element.readonly !== undefined && element.readonly === true) { readonly = ' readonly="readonly"'; } else { readonly = ''; }
            $('#formOptions').append('<div class="row"><div class="col-12 p-2"><label for="' + element.name + '"><small>' + element.label + '</small></label><input type="number" name="' + element.name + '" id="' + element.name + '"'+ placeholder + readonly +' class="form-control"></div></div>');
        }
        if (element.type == "text") {
            if(element.placeholder !== undefined && element.placeholder !== null) { placeholder = ' placeholder="' + element.placeholder + '"'; } else { placeholder = ''}
            if(element.readonly !== undefined && element.readonly === true) { readonly = ' readonly="readonly"'; } else { readonly = ''; }
            $('#formOptions').append('<div class="row"><div class="col-12 p-2"><label for="' + element.name + '"><small>' + element.label + '</small></label><input type="text" name="' + element.name + '" id="' + element.name + '"'+ placeholder + readonly +' class="form-control"></div></div>');
        }
        if (element.type == "date") {
            if(element.placeholder !== undefined && element.placeholder !== null) { placeholder = ' placeholder="' + element.placeholder + '"'; } else { placeholder = ''}
            $('#formOptions').append('<div class="row"><div class="col-12 p-2"><label for="' + element.name + '"><small>' + element.label + '</small></label><input type="date" name="' + element.name + '" id="' + element.name + '"'+ placeholder +' class="form-control"></div></div>');
        }
        if (element.type == "range") {
            if(element.step !== undefined && element.step !== null) {
                var step = element.step;
            } else {
                var step = 1;
            }
            if(element.suffix !== undefined && element.suffix !== null) {
                suffix = ' ' + element.suffix
            } else {
                suffix = '';
            }
            $('#formOptions').append('<div class="row"><div class="col-12 p-2"><label for="' + element.name + '"><small>' + element.label + '<br>Selected Value: <strong><span id="' + element.name + '-value" class="text-info">' + element.default + '</span>' + suffix + '</strong></small></label><input type="range" name="' + element.name + '" step="' + step + '" id="' + element.name + '" min="' + element.min + '" max="' + element.max + '" value="' + element.default + '" class="form-control"></div></div>');
            $('#' + element.name).on('input', function() {
                $('#' + element.name + '-value').html(this.value);
            });
        }
        if (element.type == "password") {
            if(element.placeholder !== undefined && element.placeholder !== null) { placeholder = ' placeholder="' + element.placeholder + '"'; } else { placeholder = ''}
            if(element.readonly !== undefined && element.readonly === true) { readonly = ' readonly="readonly"'; } else { readonly = ''; }
            $('#formOptions').append('<div class="row"><div class="col-12 p-2"><label for="' + element.name + '"><small>' + element.label + '</small></label><input type="password" name="' + element.name + '" id="' + element.name + '"'+ placeholder + readonly +' class="form-control"></div></div>');
        }
        if (element.type == "textbox") {
            if(element.placeholder !== undefined && element.placeholder !== null) { placeholder = ' placeholder="' + element.placeholder + '"'; } else { placeholder = ''}
            if(element.readonly !== undefined && element.readonly === true) { readonly = ' readonly="readonly"'; } else { readonly = ''; }
            $('#formOptions').append('<div class="row"><div class="col-12 p-2"><label for="' + element.name + '"><small>' + element.label + '</small></label><textarea name="' + element.name + '" id="' + element.name + '"'+ placeholder + readonly +' class="form-control"></textarea></div></div>');
        }
        if (element.type == "hidden") {
            $('#formOptions').append('<input type="hidden" name="' + element.name + '" id="' + element.name + '" class="form-control" value="' + element.value + '">');
        }
        if (element.type == "checkbox") {
            $('#formOptions').append('<div class="row"><div class="col-10 p-2 my-auto"><label for="' + element.name + '"><small>' + element.label + '</small></label></div><div class="col-2 text-center p-2"><input type="checkbox" name="' + element.name + '" id="' + element.name + '" value="' + element.value + '" class="form-control"></textarea></div></div>');
        }
        if (element.type == "dropdown") {
            $('#formOptions').append('<div class="row"><div class="col-12 p-2"><label for="' + element.name + '"><small>' + element.label + '</small></label><select name="' + element.name + '" id="' + element.name + '" class="form-control"></select></div></div>');
            $('#' + element.name).html('');
            $.each(element.options, function (selindex, options) {
                $('#' + element.name).append('<option value="' + options.value + '">' + options.label + '</option>');
            });
        }
        if (element.type == "yesno") {
            if(element.success !== undefined) {
                yesMsg = element.success
            } else { yesMsg = "Confirm" }

            if(element.reject !== undefined) {
                rejMsg = element.reject
            } else { rejMsg = "Reject" }

            $('#formOptions').append('<div class="row"><div class="col-12 p-2 text-center"><button class="btn btn-sm btn-success m-1" data-act="submitForm">' + yesMsg +'</button> <button class="btn btn-sm btn-danger" data-act="closeMenu">' + rejMsg + '</button></div></div>');
            $('#formButtons').css({"display":"none"});
        }
        if(element.data !== undefined || element.data !== null) {
            $('#' + element.name).data('data', element.data)
        }

    });

    if(form.cancel !== undefined && form.cancel !== null) {
        cancelEvent = form.cancel
    }
    
    $('#formContainer').css({"display":"block"});
}

function skinMenu(data) {
    cancelEvent = null;
    $('#menuContainer').css({"display":"none"});
    $('#formContainer').css({"display":"none"});
    $('#blipContainerColor').css({"display":"none"});
    $('#blipContainer').css({"display":"none"});
    $('#colorPickerContainer').css({"display":"none"});
    $('#skinContainer').css({"display":"none"});
    $('#selectorContainer').css({"display":"none"});
    $('#skinMenuContents').html('');
    if(data.options !== null && data.options !== undefined) {
        if(data.options.allowSwapKey !== undefined && data.options.allowSwapKey !== null && data.options.allowSwapKey === true) {
            $('#swapKey').css({"display":"block"});
            swapKeyEnabled = true
        } else {
            $('#swapKey').css({"display":"none"});
            swapKeyEnabled = false
        } 
        if(data.options.allowHandsUp !== undefined && data.options.allowHandsUp !== null && data.options.allowHandsUp === true) {
            $('#allowHandsUp').css({"display":"block"});
            taskHandsUp = true
        } else {
            $('#allowHandsUp').css({"display":"none"});
            taskHandsUp = false
        }
        if(data.options.camera !== undefined && data.options.camera !== null) {
            $('#resetCamera').css({"display":"block"});
            resetCamera = data.options.camera
        } else {
            $('#resetCamera').css({"display":"none"});
        }
        if(data.options.moveMouse !== undefined && data.options.moveMouse !== null && data.options.moveMouse === true) {
            allowSkinMouseMove = true;
            $('#mouseMovementSkin').css({"display":"block"});
        } else {
            allowSkinMouseMove = false;
            $('#mouseMovementSkin').css({"display":"none"});
        }
    }
    if (data.title !== null && data.title !== undefined) {
        $('#sliderTitle2').html(data.title);
    }
    $.each(data.sliders, function(index, slider) {
        if(slider.options !== null && slider.options !== undefined) {
        $('#skinMenuContents').append('<div id="slider-' + index + '"><div class="mt-3 row pl-2 align-items-center text-center mx-auto"><button class="btn btn-dark m-1 btn-tab-prev" id="preBtn-multi" data-multi="' + index +'"><i class="fas fa-arrow-left"></i></button><ul class="nav nav-tabs multiSlider" id="selection-' + index +'" role="tablist"></ul><button class="btn btn-dark m-1 btn-tab-next" id="nxtBtn-multi" data-multi="' + index +'"><i class="fas fa-arrow-right"></i></button></div></div>');
            $.each(slider.options, function(idx, option) {
                var label;
                if(option.label !== null && option.label !== undefined) {
                    label = option.label;
                } else {
                    label = slider.label;
                }
                if(slider.default !== undefined && slider.default !== null && option.data.option !== undefined && option.data.option !== null) {
                    if(option.data.option == slider.default) {
                        
                        $('#selection-' + index).append('<li class="nav-item"><a class="nav-link active btn btn-secondary" style="min-width:195px; max-width:195px;" id="navID-' + index + '-' + idx +'" data-idx="' + idx + '" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true" data-act="selectActionSliderSkin"><small>' + label + '</small></a></li>');
                    } else {
                        $('#selection-' + index).append('<li class="nav-item"><a class="nav-link btn btn-secondary" style="min-width:195px; max-width:195px;" id="navID-' + index + '-' + idx +'" data-idx="' + idx + '" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true" data-act="selectActionSliderSkin"><small>' + label + '</small></a></li>');
                    }
                } else {
                    if(idx == 0) {
                        $('#selection-' + index).append('<li class="nav-item"><a class="nav-link active btn btn-secondary" style="min-width:195px; max-width:195px;" id="navID-' + index + '-' + idx +'" data-idx="' + idx + '" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true" data-act="selectActionSliderSkin"><small>' + label + '</small></a></li>');
                    } else {
                        $('#selection-' + index).append('<li class="nav-item"><a class="nav-link btn btn-secondary" style="min-width:195px; max-width:195px;" id="navID-' + index + '-' + idx +'" data-idx="' + idx + '" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true" data-act="selectActionSliderSkin"><small>' + label + '</small></a></li>');
                    }
                }
                $('#navID-' + index + '-' + idx).data('data', option.data);
                $('#navID-' + index + '-' + idx).data('trigger', option.trigger);
                $('#navID-' + index + '-' + idx).data('triggertype', option.triggertype);
            });
        } else {
            if(slider.type == undefined || slider.type == null) {
            $('#skinMenuContents').append('<div id="sliderHeader-' + index + '" class="mt-3 row pl-2 align-items-center mx-auto"><div class="col-12 text-center p-0"><small><strong>' + slider.label + '</strong></small></div></div>'); 
            } else {
                if(slider.type == "range") {
                    var defa
                    if(slider.default !== undefined && slider.default !== null) {
                        defa = slider.default;
                    } else {
                        defa = 0;
                    }
                    $('#skinMenuContents').append('<div id="sliderHeader-' + index + '"><div class="mt-3 row pl-2 align-items-center text-left mx-auto"><label for="option-' + index + '"><small>' + slider.label + '</small></label><input type="range" value="' + defa + '" data-skin="true" class="form-control" max="' + slider.max + '" min="' + slider.min + '" name="option-' + index + '" id="option-' + index +'" step="1"></div></div>'); 
                    if(slider.data !== undefined && slider.data !== null) {
                        $('#option-' + index).data('data', slider.data);
                    }
                }
            }
        }
    })
    $("#skinContainer").css({"display":"block"});
    if(data.options !== null && data.options !== undefined) {
        if(data.options.return !== null && data.options.return !== undefined) {
            $('[data-act=skinBack]').data('trigger', data.options.return.trigger);
            $('[data-act=skinBack]').data('triggertype', data.options.return.triggertype);
            if(data.options.return.data !== undefined && data.options.return.data !== null) {
                $('[data-act=skinBack]').data('data', data.options.return.data);
            }
        }
    }
}

function generateSlider(data) {
    cancelEvent = null;
    $('#menuContainer').css({"display":"none"});
    $('#formContainer').css({"display":"none"});
    $('#blipContainerColor').css({"display":"none"});
    $('#blipContainer').css({"display":"none"});
    $('#colorPickerContainer').css({"display":"none"});
    $('#skinContainer').css({"display":"none"});
    $('#selectorContainer').css({"display":"none"});
    $('#selection').html('');
    if (data.menuTitle !== null && data.menuTitle !== undefined) {
        $('#sliderTitle').html(data.menuTitle);
    }

    if(data.description !== undefined && data.description !== null) {
        $('#Sliderinformation').html(data.description)
    }
    sliderObjects = data.data
    $.each(data.data, function (index, option) {
        if (index == 0) {
            if(option.infoHtml !== undefined && option.infoHtml !== null) {
                if(option.infoHtml.type == "tooltip") {
                    $('#selection').append('<li class="nav-item"><a class="nav-link active btn btn-secondary" style="min-width:195px; max-width:195px;" title="' + option.infoHtml.title + '" id="navID-' + index + '" data-idx="' + index + '" data-tooltip="tooltip" data-html="true" data-toggle="tab" data-trigger="hover" data-placement="bottom" href="#home" role="tab" aria-controls="home" aria-selected="true" data-act="selectActionSlider"><small>' + option.label + ' <i class="fad fa-search"></i></small></a></li>');
                } else {
                    $('#selection').append('<li class="nav-item"><a class="nav-link active btn btn-secondary" style="min-width:195px; max-width:195px;" title="' + option.infoHtml.title + '" id="navID-' + index + '" data-idx="' + index + '" data-popover="popover" data-html="true" data-toggle="tab" data-trigger="hover" data-placement="bottom" data-content="' + option.infoHtml.content +'" href="#home" role="tab" aria-controls="home" aria-selected="true" data-act="selectActionSlider"><small>' + option.label + ' <i class="fad fa-search"></i></small></a></li>');
                }
                $('[data-popover="popover"]').popover();
                $('[data-tooltip="tooltip"]').tooltip();
            } else {
                $('#selection').append('<li class="nav-item"><a class="nav-link active btn btn-secondary" style="min-width:195px; max-width:195px;" id="navID-' + index + '" data-idx="' + index + '" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true" data-act="selectActionSlider"><small>' + option.label + ' <i class="fad fa-search"></i></small></a></li>');
            }
        } else {
            if(option.infoHtml !== undefined && option.infoHtml !== null) {
                if(option.infoHtml.type == "tooltip") {
                    $('#selection').append('<li class="nav-item"><a class="nav-link btn btn-secondary" style="min-width:195px; max-width:195px;" id="navID-' + index + '" title="' + option.infoHtml.title + '" data-idx="' + index + '" data-toggle="tab" data-tooltip="tooltip" data-html="true" data-trigger="hover" data-placement="bottom" href="#home" role="tab" aria-controls="home" aria-selected="true" data-act="selectActionSlider"><small>' + option.label + ' <i class="fad fa-search"></i></small></a></li>');        
                } else {
                    $('#selection').append('<li class="nav-item"><a class="nav-link btn btn-secondary" style="min-width:195px; max-width:195px;" id="navID-' + index + '" title="' + option.infoHtml.title + '" data-idx="' + index + '" data-toggle="tab" data-popover="popover" data-html="true" data-trigger="hover" data-placement="bottom" data-content="' + option.infoHtml.content +'" href="#home" role="tab" aria-controls="home" aria-selected="true" data-act="selectActionSlider"><small>' + option.label + ' <i class="fad fa-search"></i></small></a></li>');        
                }
                $('[data-popover="popover"]').popover();
                $('[data-tooltip="tooltip"]').tooltip();
            } else {
                $('#selection').append('<li class="nav-item"><a class="nav-link btn btn-secondary" style="min-width:195px; max-width:195px;" id="navID-' + index + '" data-idx="' + index + '" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true" data-act="selectActionSlider"><small>' + option.label + ' <i class="fad fa-search"></i></small></a></li>');        
            }
        }

        if(option.data !== undefined && option.data !== null) {
            $('#navID-' + index).data('associate', option.data); 
        }

        $('#navID-' + index).data('trigger', option.data.trigger);
        $('#navID-' + index).data('method', option.data.triggerType);
    });
    if(data.trigger !== undefined && data.trigger !== null && data.method !== undefined && data.method !== null) {
        $('[data-act=saveSlider]').data('trigger', data.trigger);
        $('[data-act=saveSlider]').data('method', data.method);
        $("[data-act=saveSlider]").css({"display":"block"});
    }
    $("#selectorContainer").css({"display":"block"});

    if(data.preloads.menuSwitcher !== undefined && data.preloads.menuSwitcher !== null && data.preloads.menuSwitcher === true) {
        enableKeySwitch = true
        $('[data-actionID=menuSwitcher]').css({"display":"block"}).html('<small>PRESS <span class="text-dark">Z</span> TO ACCESS IN-GAME MOUSE</small>');
    }

    if(data.preloads.vehicle !== undefined && data.preloads.vehicle !==  null && data.preloads.vehicle === true) {
        $('.nav-item > .active').parent().find('a').trigger('click');
        $('#preBtn').addClass('disabled');
        $('#nxtBtn').addClass('disabled');
        $('#loading').css({"display":"block"}); 
    }

    if(data.cancel !== undefined) {
        cancelEvent = data.cancel;
    }
    $('#selectorContainer').css({"display":"block"});
}

function closeMenu() {
    menuOpen = false;
    enableKeySwitch = false;
    $.post("http://pw_interact/NUIFocusOff", JSON.stringify({}));
    $('#formButtons').css({"display":"block"});
    $('[data-actionID=menuSwitcher]').css({"display":"none"});
    menuTypeActive = null
    $('#menuContainer').css({"display":"none"});
    $('#formContainer').css({"display":"none"});
    $('#blipContainerColor').css({"display":"none"});
    $('#blipContainer').css({"display":"none"});
    $('#colorPickerContainer').css({"display":"none"});
    $('#skinContainer').css({"display":"none"});
    $('#selectorContainer').css({"display":"none"});
    cancelEvent = null;
}

function pad(n){
    return (n.length<2) ? "0"+n : n;
  }

$( function() {
    $(document).on("keydown", function (key) {
        if (Config.closeKeys.includes(key.which)) {
            if(preventClose === false) {
                if (cancelEvent !== undefined && cancelEvent !== null) {
                    $.post("http://pw_interact/doCancel", JSON.stringify({
                        post: cancelEvent,
                    }));
                    cancelEvent = null
                }
                cancelMethod = null;
                closeMenu();
            }
        }
        if(key.which == 90 && enableKeySwitch == true) {
            $('[data-actionID=menuSwitcher]').css({"display":"block"}).html('<small>PRESS <span class="text-dark">Z</span> TO ACCESS MENU</small>');
            $.post("http://pw_interact/toggleNUI", JSON.stringify({}));
        }
        if(key.which == 67 && swapKeyEnabled == true) {
            $.post("http://pw_base/rotateCharacter", JSON.stringify({}));
        }
        if(key.which == 88 && taskHandsUp == true) {
            $.post("http://pw_base/handsUpCharacter", JSON.stringify({}));
        }
        if(key.which == 90 && resetCamera !== null) {
            $.post("http://pw_base/resetCamera", JSON.stringify({
                cameraPos: resetCamera
            }));
        }
        if(key.which == 90 && allowSkinMouseMove === true) {
            $.post("http://pw_interact/turnOffNUI", JSON.stringify({ }));
            $('#mouseMovementSkin').html('<small>PRESS [<span class="text-info">Z</span>] CONTROL MENU</small>')
        }
    });

    $(document).on('change', '[data-skin=true]',function(){
        value = $(this).val();
        data = $(this).data('data');
        $.post("http://pw_base/skinSlider", JSON.stringify({
            data: data,
            value: value,
        }));
    });

    r.addEventListener('change', function() {
        setColor();
      }, false);
      
      r.addEventListener('input', function() {
        setColor();
      }, false);
      
      g.addEventListener('change', function() {
        setColor();
      }, false);
      
      g.addEventListener('input', function() {
        setColor();
      }, false);
      
      b.addEventListener('change', function() {
        setColor();
      }, false);
      
      b.addEventListener('input', function() {
        setColor();
      }, false);

    $(document).on('click', '[data-action=predefinedColor]',function(){
        var r = $(this).data('r');
        var g = $(this).data('g');
        var b = $(this).data('b');
        $('#r').val(r);
        $('#g').val(g);
        $('#b').val(b);
        setColor();
    });

    $(document).on("show.bs.dropdown", function () {
        var dropdownToggle = $(this).find(".dropdown-toggle");
        var dropdownMenu = $(this).find(".dropdown-menu");
        dropdownMenu.css({
          "top": (dropdownToggle.position().top + dropdownToggle.outerHeight()) + "px",
          "left": dropdownToggle.position().left + "px"
        });
      });

    $(document).on('show.bs.dropdown', function () {
        height = $('#menuContainerOne').height()
        if(height <= 300) {
            $('#menuContainerOne').css({"overflow-y":"visible"});
        }
    });

    $(document).on('hide.bs.dropdown', function () {
        $('#menuContainerOne').css({"overflow-y":"scroll"});
    });

    $(document).on('click','[data-act=blipColorSelect]',function(){
        var colorId = $(this).data('ident');
        $.post("http://pw_interact/selectBlipColor", JSON.stringify({
            color: colorId,
            trigger: colorTrigger,
            triggertype: colorTriggerType
        }));
    });

    $(document).on('click','[data-act=submitForm]',function(){
        if (keepOpen === false) {
            closeMenu();
        }

        var response = new Object()
        $(':input:not(button,submit,reset)').each(function (index) {
            var itemName = this.getAttribute('id');
            var itemType = this.getAttribute('type');
            var itemData = $(this).data('data');
            response[itemName] = new Object();
            if (itemType == "checkbox") {
                if($(this).is(":checked")){
                    response[itemName]['value'] = true;
                } else {
                    response[itemName]['value'] = false;
                }
            } else {
            response[itemName]['value'] = $(this).val();
            }

            if(itemData !== undefined && itemData !== null) {
                response[itemName]['data'] = itemData
            }

        })

        var action = $('#submitAction').val();
        var sendType = $('#submitMethod').val();
        $.post("http://pw_interact/submitForm", JSON.stringify({
            action: action,
            trigger: sendType,
            response: response
        }));
    });
    
    $(document).on('click','[data-action=blipSelect]',function(){
        var blipId = $(this).data('ident');
        $('#blipId').val(blipId);
    });

    $(document).on('click','[data-act=blipSelected]',function(){
        var blipId = $('#blipId').val();
        if (blipId == null || blipId == "" || blipId < 0 || blipId == undefined) {
            $('#blipRequired').css({"display":"block"});
            setTimeout(function(){ 
                $('#blipRequired').css({"display":"none"});
            }, 5000);
        } else {
            var trigger = $('#blipId').data('trigger');
            var triggertype = $('#blipId').data('triggertype');
            $.post("http://pw_interact/selectBlip", JSON.stringify({
            blip: blipId,
            trigger: trigger,
            triggertype: triggertype
        }));
        }
    });


    $(document).on('click','#colorSave',function(){
        var r = $(this).data('r');
        var g = $(this).data('g');
        var b = $(this).data('b');
        var type = $(this).data('type');
        var trigger = $(this).data('trigger');
        var data = $(this).data('data');

        if(!$(this).hasClass('disabled')) {
            $.post("http://pw_interact/colorSave", JSON.stringify({
                r: parseInt(r),
                g: parseInt(g),
                b: parseInt(b),    
                action: trigger,
                trigger: type,
                data: data
            }));
            $('#colorPickerContainer').css({"display":"none"});
        }
    });

    $(document).on('click','#colorPreview',function(){
        var r = $(this).data('r');
        var g = $(this).data('g');
        var b = $(this).data('b');
        var type = $(this).data('type');
        var trigger = $(this).data('trigger');
        var data = $(this).data('data');

        if(!$(this).hasClass('disabled')) {
            $.post("http://pw_interact/colorPreview", JSON.stringify({
                r: parseInt(r),
                g: parseInt(g),
                b: parseInt(b),    
                action: trigger,
                trigger: type,
                data: data
            }));
        }
    });

    $(document).on('click','[data-act=completeRequest]',function(){
        if(!$(this).hasClass('disabled')) {
            if (keepOpen === false) {
                closeMenu();
            }
            var action = $(this).attr('data-action');
            var trigger = $(this).attr('data-trigger');
            var value = $(this).data('value');
            if (action !== undefined && action !== null || trigger !== undefined && trigger !== null) {
                $.post("http://pw_interact/requestAction", JSON.stringify({
                    action: action,
                    trigger: trigger,
                    value: value
                }));
            }
        }
        menuOpen = false;
    });

    $(document).on('click','[data-act=closeMenu]',function(){
        menuOpen = false;
        var response = new Object()
        var action = $('#submitAction').val();
        var sendType = $('#submitMethod').val();
        $(':input:not(button,submit,reset)').each(function (index) {
            var itemName = this.getAttribute('id');
            var itemData = $(this).data('data');
            response[itemName] = new Object();

            if(itemData !== undefined && itemData !== null) {
                response[itemName]['data'] = itemData
            }
        });

        if (cancelEvent !== null) {
            $.post("http://pw_interact/doCancel", JSON.stringify({
                post: cancelEvent,
            }));
            cancelEvent = null
        }

        $.post("http://pw_interact/cancelAction", JSON.stringify({
            action: action,
            trigger: sendType,
            response: response
        }));
        closeMenu();
    });

    $(document).on('click','[data-act=skinBack]',function(){
        menuOpen = false;
        var trigger = $(this).data('trigger');
        var triggertype = $(this).data('triggertype');
        var data = $(this).data('data');
        $.post("http://pw_interact/doSkinReturn", JSON.stringify({
            trigger: trigger,
            triggertype: triggertype,
            data: data
        }));
    });

    $(document).on('click','[data-act=justClose]',function(){
        menuOpen = false;
        if (cancelEvent !== null) {
            $.post("http://pw_interact/doCancel", JSON.stringify({
                post: cancelEvent,
            }));
            cancelEvent = null
        }
        sliderObjects = null
        closeMenu();
    });

    $(document).on('click','[data-act=selectActionSlider]',function(){

        var associate = $(this).data('associate');
        var method = $(this).data('method');
        var action = $(this).data('trigger');
        var idx = $(this).data('idx');
        var totIdx = (sliderObjects.length - 1);
        $.post("http://pw_interact/sliderAction", JSON.stringify({
            action: action,
            trigger: method,
            response: associate
        }));
        if(idx == totIdx) {
            forceDisableNext = true
            $('#nxtBtn').addClass('disabled');
        } else {
            forceDisableNext = false
            $('#nxtBtn').removeClass('disabled');
        }

        if(idx == 0) {
            forceDisablePrev = true
            $('#preBtn').addClass('disabled');
        } else {
            forceDisablePrev = false
            $('#preBtn').removeClass('disabled');
        }
    });

    $(document).on('click','[data-act=saveSlider]',function(){
        menuOpen = false;
        var information = $('.nav-link.active').data('associate')
        var method = $('[data-act=saveSlider]').data('method');
        var action = $('[data-act=saveSlider]').data('trigger');
        $.post("http://pw_interact/sliderAction", JSON.stringify({
            action: action,
            trigger: method,
            response: information
        }));
        sliderObjects = null;
        //closeMenu();
    });

    $(document).on('click', '#preBtn', function() {
        "use strict";
        if(!$('#preBtn').hasClass('disabled')) {
            $('#selection .nav-item > .active').parent().prev('li').find('a').trigger('click');
            $('.btn-tab-prev').addClass('disabled');
            $('#preBtn').addClass('disabled');
            $('#loading').css({"display":"block"});
        }
    });
    
    $(document).on('click', '#nxtBtn', function() {
        "use strict";
        var idx = $(this).data('idx');
        if(!$('#nxtBtn').hasClass('disabled')) {
            $('#selection .nav-item > .active').parent().next('li').find('a').trigger('click');
            $('.btn-tab-prev').addClass('disabled');
            $('#nxtBtn').addClass('disabled');
            $('#loading').css({"display":"block"});
        }
    });

    $(document).on('click', '[data-act=selectActionSliderSkin]', function() {
        var trigger = $(this).data('trigger');
        var triggertype = $(this).data('triggertype');
        var data = $(this).data('data');
        
        $.post("http://pw_interact/sliderActionSkin", JSON.stringify({
            trigger: trigger,
            triggertype: triggertype,
            data: data,
        }));
    });

    $(document).on('click', '#preBtn-multi', function() {
        "use strict";
        var idx = $(this).data('idx');
        var slider = $(this).data('multi');
        $('#selection-' + slider + ' .nav-item > .active').parent().prev('li').find('a').trigger('click');
        $('#loading').css({"display":"block"});
    });
    
    $(document).on('click', '#nxtBtn-multi', function() {
        "use strict";
        var idx = $(this).data('idx');
        var slider = $(this).data('multi');
        $('#selection-' + slider + ' .nav-item > .active').parent().next('li').find('a').trigger('click');
        $('#loading').css({"display":"block"});
    });
});

$(function () {
    $('[data-toggle="popover"]').popover()
  })
