jQuery(function($){$(document).find('.entry-content > .panel-layout > .panel-grid').each(function(i,e){$(e).attr('data-id','slide'+i)})
$(document).on('click','.scrollify_pagination_wrapper a',function(e){e.preventDefault();var target=$(this).attr('href');target=target.replace('#','');console.log(target);var header_stuck_threashold=$('.mwdc_sticky_nav.active').outerHeight();if($(document).find('#'+target).length){$('html,body').animate({scrollTop:(($(document).find('#'+target).offset().top)-header_stuck_threashold)},1000)}else if($(document).find('[data-id="'+target+'"]').length){$('html,body').animate({scrollTop:(($(document).find('[data-id="'+target+'"]').offset().top)-header_stuck_threashold)},1000)}})})