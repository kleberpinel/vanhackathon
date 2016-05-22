// ---------------------------------------
// // GMap 3 - Set Address on line 101
// ---------------------------------------
/*global $, jQuery, google*/
var styles = [
	{
		featureType: "all",
		stylers: [
			{ saturation: -80 }
		]
	}, {
		featureType: "road.arterial",
		elementType: "geometry",
		stylers: [
			{ hue: "#00ffee" },
			{ saturation: 50 }
		]
	}, {
		featureType: "poi.business",
		elementType: "labels",
		stylers: [
			{ visibility: "off" }
		]
	}
];

$("#mymap").gmap3({
    marker: {
        address: '795 Folsom Ave, San Francisco, CA 94107',
        data: "Here I am",
		events: {
			mouseover: function (marker, event, context) {
				"use strict";
				var map = $(this).gmap3("get"),
					infowindow = $(this).gmap3({get: {name: "infowindow"}});
				if (infowindow) {
					infowindow.open(map, marker);
                    infowindow.setContent(context.data);
                } else {
					$(this).gmap3({
						infowindow: {
							anchor: marker,
							options: {content: context.data}
						}
					});
				}
            },
            mouseout: function () {
				"use strict";
                var infowindow = $(this).gmap3({get: {name: "infowindow"}});
                if (infowindow) {
                    infowindow.close();
                }
            }
        }
    },
    map: {
		options: {
			styles: styles,
			zoom: 14,
            scrollwheel: false,
            draggable: true,
            zoomControl: true,
            zoomControlOptions: {
				style: google.maps.ZoomControlStyle.SMALL
			},
			mapTypeControl: false,
            scaleControl: false,
            streetViewControl: true
        }
    }
});