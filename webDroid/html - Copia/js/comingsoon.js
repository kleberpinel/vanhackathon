/*global $, jQuery, Snap, mina*/
$(document).ready(function () {
	"use strict";
    // Countdown
	$('#timer').countdown('2015/12/31', function (event) { //set date YYYY/MM/DD or YYYY/MM/DD HH:MM:SS
		var format = "<div class='col-xs-6 col-sm-3'><span>%D</span> days</div>" + "<div class='col-xs-6 col-sm-3'><span>%H</span> hours</div>" + "<div class='col-xs-6 col-sm-3'><span>%M</span> minutes</div>" + "<div class='col-xs-6 col-sm-3'><span>%S</span> seconds</div>";
		$(this).html(event.strftime(format));
	});

    // Subscribe Form
	$('.fire-modal').magnificPopup({
		type: 'inline',
		preloader: false,
        closeMarkup: '<button title="%title%" type="button" class="mfp-close icon icon-circle-with-cross"></button>'
	});
});

$(document).ready(function () {
    "use strict";
    // Snap SVG
    var s = new Snap("#svg"),
		d,
		coneBottom = s.path(d = "M30.048 20.906l-6.008-2.422 0.693 1.931c-0.035 2.046-4.006 3.678-8.733 3.678-4.725 0-8.699-1.63-8.733-3.678l0.693-1.931-6.008 2.422c-1.685 0.678-1.757 1.934-0.157 2.79l11.299 6.059c1.597 0.856 4.213 0.856 5.811 0l11.301-6.059c1.598-0.856 1.526-2.112-0.158-2.79z"),
		coneMiddle = s.path(d = "M16 19.325c3.824 0 7.027-1.299 7.221-2.997-0.57-1.594-1.19-3.334-1.8-5.043-0.422 1.218-2.76 2.082-5.421 2.082s-4.998-0.864-5.421-2.082c-0.61 1.709-1.23 3.45-1.798 5.043 0.194 1.698 3.395 2.997 7.219 2.997z"),
		coneTop = s.path(d = "M16 8.597c1.798 0 3.467-0.557 3.957-1.422-0.674-1.891-1.251-3.515-1.618-4.538-0.243-0.683-1.346-1.037-2.339-1.037s-2.096 0.354-2.339 1.037c-0.365 1.022-0.944 2.646-1.618 4.538 0.49 0.866 2.16 1.422 3.957 1.422z"),
		loopBottom = coneBottom,
		loopBottomLength = Snap.path.getTotalLength(loopBottom),
		loopMiddle = coneMiddle,
		loopMiddleLength = Snap.path.getTotalLength(loopMiddle),
		loopTop = coneTop,
		loopTopLength = Snap.path.getTotalLength(loopTop),
		coneBottomOutline = s.path({
		    path: Snap.path.getSubpath(loopBottom, 0, 0),
		    stroke: '#f8c471',
		    fillOpacity: 0,
		    strokeWidth: 0,
		    strokeLinecap: "round"
		}),
		coneMiddleOutline = s.path({
		    path: Snap.path.getSubpath(loopMiddle, 0, 0),
		    stroke: "#f8c471",
		    fillOpacity: 0,
		    strokeWidth: 0,
		    strokeLinecap: "round"
		}),
		coneTopOutline = s.path({
		    path: Snap.path.getSubpath(loopTop, 0, 0),
		    stroke: "#f8c471",
		    fillOpacity: 0,
		    strokeWidth: 0,
		    strokeLinecap: "round"
		});

    //attributes
    coneBottom.attr({
        fill: "#fff",
        stroke: "#f8c471",
        strokeWidth: 0,
        "data-fill": "#f8c471"
    });
    coneMiddle.attr({
        fill: "#fff",
        stroke: "#f8c471",
        strokeWidth: 0,
        "data-fill": "#f8c471"
    });
    coneTop.attr({
        fill: "#fff",
        stroke: "#f8c471",
        strokeWidth: 0,
        "data-fill": "#f8c471"
    });

    //functions
    function fillCone() {
        setTimeout(function () {
            coneBottom.animate({ 'fill': coneBottom.attr('data-fill') }, 2600, mina.linear);
            coneMiddle.animate({ 'fill': coneMiddle.attr('data-fill') }, 2600, mina.linear);
            coneTop.animate({ 'fill': coneTop.attr('data-fill') }, 2600, mina.linear);
        }, 6000);
    }

    function drawCone() {
        Snap.animate(0, loopBottomLength, function (step) {
            coneBottomOutline.attr({
                path: Snap.path.getSubpath(loopBottom, 0, step),
                strokeWidth: 0.1
            });
        }, 5800, mina.easeInOut, function drawMiddle() {
            Snap.animate(0, loopMiddleLength, function (step) {
                coneMiddleOutline.attr({
                    path: Snap.path.getSubpath(loopMiddle, 0, step),
                    strokeWidth: 0.1
                });
            }, 5800, mina.easeInOut, function drawTop() {
                Snap.animate(0, loopTopLength, function (step) {
                    coneTopOutline.attr({
                        path: Snap.path.getSubpath(loopTop, 0, step),
                        strokeWidth: 0.1
                    });
                }, 5800, mina.easeInOut, fillCone());
            });
        });
    }

    drawCone();

});























