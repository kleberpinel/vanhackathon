$(window).load(function () {
	"use strict";
    $('.preloader').fadeOut(1200);
});

// -----------------------------
// Navbar fade
// -----------------------------
$(function () {
	"use strict";
    var navbar = $('.navbar');
    if (navbar.hasClass("is-transparent")) {
        $(window).scroll(function () {
            if (navbar.offset().top > 250) {
                navbar.removeClass("is-transparent");
            } else {
                navbar.addClass("is-transparent");
            }
        });
    } else {
        return;
    }
});

// -----------------------------
// Header > .btn-duo equal width
// -----------------------------
$(function () {
	"use strict";
	function btnDuo() {
		$(".btn-duo").each(function () {
			var btnFirst = $(this).find(".btn:first-child"),
				btnLast = $(this).find(".btn:last-child"),
				btnFirstWidth = btnFirst.outerWidth(),
				btnLastWidth = btnLast.outerWidth();
			if (btnFirstWidth < btnLastWidth) {
				$(btnFirst).css("width", btnLastWidth + "px");
			} else {
				$(btnLast).css("width", btnFirstWidth + "px");
			}
		});
	}
	btnDuo();
});

// -----------------------------
// Overlay Menu
// -----------------------------
$(document).ready(function () {
    "use strict";
    var menuWrapper = $('.menu-wrapper'),
		overlayMenu = $('.overlay-menu'),
		burgerMenu = $('.burger-menu'),
        burgerItems = $('.navbar-brand, .burger-menu');
    $(document).on('click', '.burger-menu, .menu-wrapper.is-visible', function (event) {
        if (menuWrapper.hasClass("is-visible")) {
            setTimeout(function () {
                overlayMenu.removeClass('menu-visible').css("opacity", "0").attr("aria-expanded", "false");
                burgerMenu.removeClass('icon-cross').addClass('icon-menu');
                burgerItems.css("color", "inherit");
                setTimeout(function () {
                    menuWrapper.removeClass('is-visible').css("display", "none");
                }, 1200);
            }, 600);
        } else {
            event.preventDefault();
            burgerMenu.removeClass('icon-menu').addClass('icon-cross');
            burgerItems.css("color", "#4a4c4d");
            setTimeout(function () {
                menuWrapper.addClass('is-visible').css("display", "block");
                setTimeout(function () {
                    overlayMenu.addClass('menu-visible').css("opacity", "1").attr("aria-expanded", "true");
                }, 300);
            }, 200);
        }
    });
});

// -----------------------------
// Slick
// -----------------------------
$(document).ready(function () {
	"use strict";
    // Clients Logos
    $('.slider.clients-logo').slick({
        slide: 'ul>li',
        autoplay: true,
        autoplaySpeed: 3000,
        slidesToShow: 5,
        arrows: false,
        responsive: [
			{
				breakpoint: 480,
				settings: {
					slidesToShow: 3
				}
			}
		]
	});
    // Customers Quotes
    $('.slider.quotes').slick({
        slide: 'ul>li',
        autoplay: true,
        autoplaySpeed: 5000,
        slidesToShow: 1,
        adaptiveHeight: true,
        arrows: false,
        dots: true,
        dotsClass: 'avatar-dots',
        customPaging: function (slider, i) {
            return '<a class="tab">' + $(slider.$slides[i]).find('.dot-trigger').html() + '</a>';
        }
    });
});

// -----------------------------
// Counters
// -----------------------------
$('.number').appear(function () {
	"use strict";
    $('.number').countTo();
});


// -----------------------------
// Section Title automatic alignment
// -----------------------------
$(".section-title").each(function () {
	"use strict";
    if ($(this).css('text-align') === 'center') {
        $(this).addClass("centered");
    } else if ($(this).css('text-align') === 'right') {
        $(this).addClass("right");
    } else {
        return;
    }
});

// -----------------------------
// Parallax
// ----------------------------
$('#scene').parallax({
    invertX: false,
    invertY: false
});

// -----------------------------
// Magnific Popup
// ----------------------------
$(document).ready(function () {
    "use strict";
    // Video
    $(".watch-video").magnificPopup({
        type: "iframe"
    });
    // Gallery Screens
    $('#gallery').on('click', function () {
        $(this).next().magnificPopup('open');
    });
    $('.gallery').each(function () {
        $(this).magnificPopup({
            delegate: 'a',
            gallery: {
                enabled: true,
                arrowMarkup: '<button title="%title%" type="button" class="icon icon-chevron-thin-%dir%"></button>'
            },
            type: 'image',
            fixedContentPos: false
        });
    });
});

// ----------------------------
// Progressbar
// ----------------------------
$('.progress-wrap').each(function () {
	"use strict";
    $('.progress').appear(function (s) {
        var value = $(this).find('.progress-bar').attr('aria-valuenow'),
			percent = parseInt(value, 10);
        $(this).find('.progress-bar').animate({
            'width': value + '%'
        }, 100, function () {
            $(this).find('.bar-value').countTo({
                from: 0,
                to: percent,
                speed: 1200,
                refreshInterval: 5
            }).fadeTo(3300, 1);
        });
    });
});

// ----------------------------
// Layout with slider background
// Hero bg images
// ----------------------------
$(document).ready(function () {
    "use strict";
    if ($("body").hasClass("slider-bg")) {
        $(".hero").vegas({
            transition: "blur",
            delay: 8000,
            color: "#D98880",
            slides: [
				{ src: "img/placeholder-slider1.jpg" },
				{ src: "img/placeholder-slider2.jpg", transition: 'swirlLeft' },
				{ src: "img/placeholder-slider3.jpg", transition: 'flash' }
			]
        });
        $(".vegas-wrapper").addClass("flex flex-middle");
        $(window).resize(function () {
            var wHeight = $(window).height();
            $(".hero").css("height", wHeight);
        });
    }
});

// ----------------------------
// Layout with video background
// Hero bg video
// ----------------------------
$(function () {
    "use strict";
    if ($("body").hasClass("video-bg")) {
		var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
		if (isMobile === false) {
			$(".player").mb_YTPlayer();
		} else {
			/* displays a background image if mobile device is detected*/
			$('body').removeClass('video-bg');
		}
	}
});