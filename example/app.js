// load module
var TiFlatUIKit = require('net.uchidak.tiflatuikit');
Ti.API.info("module is => " + TiFlatUIKit);

// window
var w = Ti.UI.createWindow({
    backgroundColor : '#f8f8f8',
    layout : 'horizontal'
});

// button
var b = TiFlatUIKit.createButton({
    top : 10,
    left : 10,
    width : 300,
    height : 60,
    title : 'Alert',
    font : {
        fontSize : 20,
        fontWeight : 'bold'
    },
    color : '#f8f8f8',
    selectedColor : '#ccc',
    buttonColor : '#1abc9c',
    shadowColor : '#16a085',
    shadowHeight : 5,
    cornerRadius : 4,
    enabled : true
});
b.addEventListener('click', function(e) {
    a.show();
});

// tabbed bar
var t = TiFlatUIKit.createTabbedBar({
    top : 10,
    left : 10,
    width : 300,
    height : 60,
    selectedFont : {
        fontSize : 20,
        fontWeight : 'bold'
    },
    deselectedFont : {
        fontSize : 20,
        fontWeight : 'bold'
    },
    selectedColor : '#d35400',
    deselectedColor : '#e67e22',
    selectedFontColor : '#ccc',
    deselectedFontColor : '#f8f8f8',
    dividerColor : '#e67e22',
    cornerRadius : 4,
    index : 0,
    labels : ['TabA', 'TabB', 'TabC'],
    enabled : true
});
t.addEventListener('click', function(e) {
    Ti.API.debug('TabbedBar index:' + e.index);
});

// alert dialog
var a = TiFlatUIKit.createAlertDialog({
    titleColor : '#f8f8f8',
    messageColor : '#f8f8f8',
    overlayColor : '#f8f8f8',
    backgroundColor : '#2ecc71',
    defaultButtonColor : '#3498db',
    defaultButtonShadowColor : '#2980b9',
    defaultButtonTitleColor : '#f8f8f8',
    cancelButtonColor : '#95a5a6',
    cancelButtonShadowColor : '#7f8c8d',
    cancelButtonTitleColor : '#f8f8f8',
    titleFont : {
        fontSize : 24,
        fontWeight : 'bold'
    },
    messageFont : {
        fontSize : 18,
    },
    buttonFont : {
        fontSize : 18,
        fontWeight : 'bold'
    },
    buttonNames : ['buttonA', 'buttonB', 'Cancel'],
    title : 'Title',
    message : 'This is TiFlatUIKit',
    cancel : 2
});
a.addEventListener('click', function(e) {
    Ti.API.debug(e);
});

// slider
var sd = TiFlatUIKit.createSlider({
    top : 10,
    left : 10,
    width : 300,
    height : 60,
    min : 1,
    max : 100,
    value : 50,
    trackColor : '##34495e',
    progressColor : '#f1c40f',
    thumbColor : '#3498db',
    enabled : true
});
sd.addEventListener('change', function(e) {
    Ti.API.debug(e);
});

// switch
var sw = TiFlatUIKit.createSwitch({
    top : 10,
    left : 10,
    width : 300,
    height : 60,
    onColor : '#f8f8f8',
    offColor : '#cccccc',
    onBackgroundColor : '#e74c3c',
    offBackgroundColor : '#7f8c8d',
    onLabel : 'YESSSS!!',
    offLabel : 'NOOOO!!',
    value : true,
    onLabelFont : {
        fontSize : 24
    },
    offLabelFont : {
        fontSize : 24
    }
});
sw.addEventListener('change', function(e) {
    Ti.API.log(e);
});

// progress bar
var p = TiFlatUIKit.createProgressBar({
    top : 10,
    left : 10,
    width : 300,
    height : 60,
    min : 0,
    max : 100,
    value : 1,
    color : '#333333',
    message : 'Loading...',
    font : {
        fontSize : 14
    },
    trackColor : '#1abc9c',
    progressColor : '#f1c40f'
});
var interval = setInterval(function() {
    if (100 == p.value) {
        p.value = 1;
    }
    p.value = p.value + 1;
}, 100);
p.show();

var stl = Ti.UI.createLabel({
    top : 10,
    left : 10,
    width : 60,
    height : 27,
    textAlign : Ti.UI.TEXT_ALIGNMENT_CENTER,
    borderRadius : 2,
    backgroundColor : '#34495e',
    font : {
        fontSize : 24
    },
    color : '#f8f8f8'
});

// stepper
var st = TiFlatUIKit.createStepper({
    top :10,
    left : 10,
    width : 94,
    height : 27,
    min : 1,
    max : 100,
    stepValue : 5,
    value : 50,
    color : '#34495e',
    highlightedColor : '#95a5a6',
    disabledColor : '#95a5a6',
    minusIconColor : '#e74c3c',
    plusIconColor : '#3498db'
});
st.addEventListener('change', function(e) {
    Ti.API.debug(e);
    stl.text = e.value;
});

w.add(b);
w.add(t);
w.add(sd);
w.add(sw);
w.add(p);
w.add(stl);
w.add(st);

w.open(t);
