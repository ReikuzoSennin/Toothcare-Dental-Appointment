function initMap() {
    // Latitude and Longitude
    var myLatLng = {lat: 3.0698, lng: 101.5037};

    var map = new google.maps.Map(document.getElementById('google-maps'), {
        zoom: 17,
        center: myLatLng
    });

    var marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        title: 'UiTM Shah Alam, MYS' // Title Location
    });
}