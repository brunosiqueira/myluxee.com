// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require javascript:navbar_scroll
//= require javascript:smoothscroll
//= require scrollReveal
//= require_self

var storeList = [];
var storeMap = {};
var map;

function setStoresToMap(stores) {
    console.log('setStoresToMap');
    storeList = stores;
}

function loadMarkers(){
    console.log('loadMarkers');
    var bounds = new google.maps.LatLngBounds();
    for(var i=0; i < storeList.length; i++){
        var store = storeList[i];
        storeMap[store.id] = new google.maps.Marker({
            position: {lat: store.latitude, lng: store.longitude},
            map: map,
            title: store.brand.name
        });
        storeMap[store.id].setIcon('http://maps.google.com/mapfiles/ms/icons/red-dot.png');
        bounds.extend(new google.maps.LatLng(store.latitude, store.longitude));
    }

    map.fitBounds(bounds);
}

function associateListToMap() {
    $(".store-area").mouseover(function(){
        console.log(storeMap[$(this).attr("data-id")].getIcon());
        storeMap[$(this).attr("data-id")].setIcon('http://maps.google.com/mapfiles/ms/icons/green-dot.png');
    });
    $(".store-area").mouseout(function(){
        storeMap[$(this).attr("data-id")].setIcon('http://maps.google.com/mapfiles/ms/icons/red-dot.png');
    });
}
function loadLocateMap() {
    console.log('loadLocateMap');
    var myLatlng = new google.maps.LatLng(48.8536450,2.3325860);
    var myOptions = {
        zoom: 14,
        center: myLatlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        styles: [{
            "featureType": "administrative",
            "elementType": "labels.text.fill",
            "stylers": [{"color": "#444444"}]
        }, {"featureType": "landscape", "elementType": "all", "stylers": [{"color": "#f2f2f2"}]}, {
            "featureType": "poi",
            "elementType": "all",
            "stylers": [{"visibility": "off"}]
        }, {
            "featureType": "road",
            "elementType": "all",
            "stylers": [{"saturation": -100}, {"lightness": 45}]
        }, {
            "featureType": "road.highway",
            "elementType": "all",
            "stylers": [{"visibility": "simplified"}]
        }, {
            "featureType": "road.arterial",
            "elementType": "labels.icon",
            "stylers": [{"visibility": "off"}]
        }, {
            "featureType": "transit",
            "elementType": "all",
            "stylers": [{"visibility": "off"}]
        }, {"featureType": "water", "elementType": "all", "stylers": [{"color": "#46bcec"}, {"visibility": "on"}]}]
    };
    map = new google.maps.Map(document.getElementById('map'), myOptions);

    loadMarkers()
    associateListToMap();
}

