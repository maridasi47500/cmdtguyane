(function($) {
  "use strict";

  	$(".wpb_category_n_menu_accordion").each(function(){

		var accordion 		= $(this).data('accordion'),
			indicator_icon  = $(this).data('indicator_icon'),
			iconclass  		= $(this).data('iconclass'),
			caretHtml       = '';

		if( iconclass ){
			caretHtml = '<i class="'+iconclass+'"></i>';
		}else{
			caretHtml = indicator_icon;
		}

		$(this).find('.wpb_category_n_menu_accordion_list').navgoco({
			caretHtml: caretHtml,
			accordion: accordion,
			openClass: 'wpb-submenu-indicator-minus',
			save: true,
			cookie: {
				name: 'navgoco',
				expires: false,
				path: '/'
			},
			slide: {
				duration: 400,
				easing: 'swing'
			}
      	});

	});



  	/**
  	 * Accordion init on Elementor Editor
 	 * @param $scope The Widget wrapper element as a jQuery element
	 * @param $ The jQuery alias
	 */ 

	var WpbCategoryMenuAccordion = function( $scope, $test ) {

		var $_accordion_wrapper = $scope.find(".wpb_category_n_menu_accordion");

		$_accordion_wrapper.each(function(){

			var accordion 	= $(this).data('accordion'),
			indicator_icon  = $(this).data('indicator_icon'),
			iconclass  		= $(this).data('iconclass'),
			caretHtml       = '';

			if( iconclass ){
				caretHtml = '<i class="'+iconclass+'"></i>';
			}else{
				caretHtml = indicator_icon;
			}

			$(this).find('.wpb_category_n_menu_accordion_list').navgoco({
				caretHtml: caretHtml,
				accordion: accordion,
				openClass: 'wpb-submenu-indicator-minus',
				save: true,
				cookie: {
					name: 'navgoco',
					expires: false,
					path: '/'
				},
				slide: {
					duration: 400,
					easing: 'swing'
				}
	      	});

		});

	};

	// Run this code under Elementor.
	$( window ).on( 'elementor/frontend/init', function() {
		elementorFrontend.hooks.addAction( 'frontend/element_ready/wpb-accordion-categories.default', WpbCategoryMenuAccordion );
		elementorFrontend.hooks.addAction( 'frontend/element_ready/wpb-accordion-menu.default', WpbCategoryMenuAccordion );
	});

}(jQuery)); 