var YRC = YRC || {};
jQuery(document).ready(function($){
	window.YD && window.YD.version();
	
	YRC.EM = YRC.EM || $({});
	YRC.template = YRC.template || {};
	YRC.counter = 0;
	YRC.single_videos = {};
	
	function yrcStyle( sel, data ){
		var colors = data.style.colors;
		var css = 
			sel+' li.yrc-active{\
				border-bottom: 3px solid '+ colors.color.menu +';\
			}\
			'+ sel +' .yrc-menu li{\
				color:'+ colors.color.menu +';\
			}\
			'+ sel +' .yrc-item{\
				margin-bottom:'+ (parseInt(data.style.theme.videos.carousel.spacing)||8) +'px;\
			}\
			'+ sel +' .yrc-brand, .yrc-placeholder-item{\
				background: '+ colors.item.background +';\
			}\
			'+ sel +' .yrc-item{\
				background: '+ colors.item.background +';\
			}\
			'+ sel +' .yrc-section-action, '+ sel +' .yrc-section-action, '+ sel +' .yrc-load-more-button, .yrc-search button, .yrc-player-bar, .yrc-player-bar span, .yrc-search-form-top button{\
				background: '+ colors.button.background +';\
				color: '+ colors.button.color +';\
				border:none;\
			}\
			'+ sel +' .yrc-section-action a{\
				color: '+ colors.button.color +';\
			}\
			.yrc-player-bar .yrc-close span{\
				color: '+ colors.button.background +';\
				background: '+ colors.button.color +';\
			}\
			'+ sel +' .yrc-brand{\
				color: '+ colors.color.text +';\
			}\
			.yrc-loading-overlay:after{ content: "'+ YRC.lang.form.Loading +'..."; }\
			'+ sel +' .yrc-item a{ color: '+ (colors.color.link === 'inherit' ? colors.color.link : colors.color.link) +'; }\
			'+ sel +' .yrc-item-meta{ color: '+ colors.color.meta +';'+ ( colors.item.background === 'inherit' ? '' : 'padding: .35em .35em .35em .35em;' ) +' }\
			'+ sel +' .yrc-item-closed .yrc-item-meta{ '+ ( colors.item.background === 'inherit' ? 'background: rgba(255, 255, 255, .95)' : colors.item.background ) +';padding: .35em; }\
			'+ sel +' .yrc-item-title { '+(data.style.truncate ? 'white-space:nowrap;text-overflow:ellipsis;' : '' )+' }';
												
			if(data.style.youtube_play_icon){
				css += sel+' .yrc-item .yrc-thumb a.yrc-video-link:before {\
					width:100%;\
					height:100%;\
					background-size:33%;\
					background-position:center;\
				}';
								
				if(data.style.play_icon === 'all')
					css += sel+' .yrc-video .yrc-thumb a:before{ content:" "; }';
					
				if(data.style.play_icon === 'hover')
					css += sel+' .yrc-video:hover .yrc-thumb a:before{ content:""; }';
			} else {
				css += sel+' .yrc-item .yrc-thumb a.yrc-video-link:before {\
					top:50%;\
					transform:translate(0, -50%);\
					pointer-events:all;\
					overflow:hidden;\
					font-size:3em;\
					font-family: \'icomoon\' !important;\
					color:#fff;\
					content:"\uf04b";\
					background: none;\
					text-align:center;\
					line-height:1;\
				}';
								
				if(data.style.play_icon === 'all')
					css += sel+' .yrc-video .yrc-thumb a:before{ width:100%; }';
					
				if(data.style.play_icon === 'hover')
					css += sel+' .yrc-video:hover .yrc-thumb a:before{ width:100%; }';
			}
						
		$('head').append('<style class="yrc-stylesheet">'+ css + '</style>');
		YRC.EM.trigger('yrc.style', [[sel, data]]);
	}

	function miti(stamp){
		stamp = +new Date - stamp;
		var days = Math.round( Math.floor( ( stamp/60000 )/60 )/24 );
		if(days < 7)
			stamp = days + ' ' + (days > 1 ? YRC.lang.fui.days : YRC.lang.fui.day);
		else if( Math.round(days/7) < 9)
			stamp = Math.round(days/7) + ' ' + (Math.round(days/7) > 1 ? YRC.lang.fui.weeks : YRC.lang.fui.week);
		else if( Math.round(days/30) < 12)
			stamp = Math.round(days/30) + ' ' + (Math.round(days/30) > 1 ? YRC.lang.fui.months : YRC.lang.fui.month);
		else stamp = Math.round( days/365 ) + ' ' + (Math.round(days/365) > 1 ? YRC.lang.fui.years : YRC.lang.fui.year);	
		stamp = (stamp === ('0 '+YRC.lang.fui.day)) ? YRC.lang.fui.today : stamp;
		if(stamp === YRC.lang.fui.today) return stamp;
		return (YRC.lang.fui.wplocale === 'de_DE' || YRC.lang.fui.wplocale === 'fr_FR') ? (YRC.lang.fui.ago + ' ' + stamp) : (stamp + ' ' + YRC.lang.fui.ago);
	}	
	
	YRC.miti = miti;
	
	window.onYouTubeIframeAPIReady = function() {
		console.log('YRC_API_LOADED');
		YRC.EM.trigger('yrc.api_loaded');
		
		Object.keys(YRC.Setups).forEach(function( key ){
			YRC.Setups[key].apiReady();
		});
	};
	function loadYouTubeAPI(){
		var tag = document.createElement('script');
			tag.innerHTML = "if (!window['YT']) {var YT = {loading: 0,loaded: 0};}if (!window['YTConfig']) {var YTConfig = {'host': 'https://www.youtube.com'};}if (!YT.loading) {YT.loading = 1;(function(){var l = [];YT.ready = function(f) {if (YT.loaded) {f();} else {l.push(f);}};window.onYTReady = function() {YT.loaded = 1;for (var i = 0; i < l.length; i++) {try {l[i]();} catch (e) {}}};YT.setConfig = function(c) {for (var k in c) {if (c.hasOwnProperty(k)) {YTConfig[k] = c[k];}}};var a = document.createElement('script');a.type = 'text/javascript';a.id = 'www-widgetapi-script';a.src = 'https:' + '//s.ytimg.com/yts/jsbin/www-widgetapi-vflYlgBFi/www-widgetapi.js';a.async = true;var b = document.getElementsByTagName('script')[0];b.parentNode.insertBefore(a, b);})();}";
		var firstScriptTag = document.getElementsByTagName('script')[0];
		firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
	}	
	loadYouTubeAPI();
	
	/*
	 * jQuery throttle / debounce - v1.1 - 3/7/2010
	 * http://benalman.com/projects/jquery-throttle-debounce-plugin/
	 * 
	 * Copyright (c) 2010 "Cowboy" Ben Alman
	 * Dual licensed under the MIT and GPL licenses.
	 * http://benalman.com/about/license/
	 */
	(function(b,c){var $=b.jQuery||b.Cowboy||(b.Cowboy={}),a;$.throttle=a=function(e,f,j,i){var h,d=0;if(typeof f!=="boolean"){i=j;j=f;f=c}function g(){var o=this,m=+new Date()-d,n=arguments;function l(){d=+new Date();j.apply(o,n)}function k(){h=c}if(i&&!h){l()}h&&clearTimeout(h);if(i===c&&m>e){l()}else{if(f!==true){h=setTimeout(i?k:l,i===c?e-m:e)}}}if($.guid){g.guid=j.guid=j.guid||$.guid++}return g};$.debounce=function(d,e,f){return f===c?a(d,e,false):a(d,f,e!==false)}})(window);		
		
	if(!$.throttle) $.throttle = function(t, fn){ return fn; };	
	
	var watch_video = 'https://www.youtube.com/watch?v=';
	
	YRC.copy = function( o ){ return JSON.parse(JSON.stringify(o)); };
	
	YRC.auth = {
		//'apikey': 'AIzaSyBHM34vx2jpa91sv4fk8VzaEHJbeL5UuZk',
		'baseUrl': function ( rl ){ return '/searchmyvideo/' + rl +'&key=' + this.apikey; },
		
		'url': function uuu(type, page, res, search, limit, vst){
                                                                        console.log(type);

			var url = '';

			switch(type){
				case 'Playlist':
					url = this.baseUrl('playlistItems?part=snippet%2C+contentDetails&maxResults='+limit+'&pageToken='+page+'&playlistId='+res);
				break;
				case 'Uploads':
					url = this.baseUrl('search?order='+ ((search || 'date')) +'&q='+(vst.t)+'&part=snippet'+( vst.own ? ('&channelId='+ res) : '') +'&type=video&pageToken='+page+'&maxResults='+limit);
				break;
				case 'channel':
					url = this.baseUrl('channels?part=contentDetails,snippet,statistics,brandingSettings&id='+ res);
				break;
				case 'Playlists':
					url = this.baseUrl('playlists?part=snippet,status,contentDetails&channelId='+ res +'&pageToken='+page+'&maxResults='+limit);
				break;
				case 'Search':
					url = this.baseUrl( YRC.searchUrl( page, res, search, limit ) );
				break;
				case 'Custom':
					url = this.baseUrl('videos?part=contentDetails,statistics,snippet&id=' + res);
				break;	
			}
			return url;
		}
	};
									
	YRC.extras = {
		'playlists': {'sel': ' .yrc-playlists', 'label': 'Playlists'},
		'uploads': {'sel': ' .yrc-uploads', 'label': 'Uploads'},
		'playlist': {'sel': ' .yrc-playlist-videos', 'label': 'Playlist'}
	};
	
	YRC.EM.trigger('yrc.extras');
	
	YRC.Base = function(){};
	
	YRC.normalizeItems = function(){
		
	};
		
	YRC.Base.prototype = {		
		'more': function( nextpage , more){
			this.request.page = nextpage;
			$(this.coresel + ' .yrc-item-list').append( YRC.template.loadMoreButton( more, this.request.pagetokens.prev, this.multi_page) );
		},
		
		'moreEvent': function(){
			var yc = this;
			$('body').off('click', this.coresel+' .yrc-load-more-button').on('click', this.coresel+' .yrc-load-more-button', function(e){
				//$(this).text(YRC.lang.form.more +'...');
				$(this).text('...');
				yc.request.dir = $(this).is('.yrc-nextpage') ? 1 :-1;
				yc.request.page = "/searchmore";
				// to do: get previous data from this.items for prev / next buttons
				yc.fetch();
			});
		},
		
		'channelOrId': function(){
			if(this.temp_label === 'Custom') return this.custom_vids.splice(0, this.per_page).join(',');
			return ((this.label === 'Playlist' || (this.temp_label === 'Playlist' && !this.vst.t)) ? this.request.id : (this.label === 'Search' ? (this.restrict_to_channel ? this.ref.channel : '') : this.ref.channel));
		},
		
		'fetch': function(){			
			if( !this.request.times && this.ref.Data[this.label.toLowerCase()] && !this.ref.Data[this.label.toLowerCase()].yrc_error && !this.sorted )
				return this.onResponse( this.ref.Data[this.label.toLowerCase()] );
			
			var url = YRC.auth.url( 'searchmyvideo', this.request.page, this.channelOrId(), this.criteria, this.per_page, this.vst ), yc = this;
			$(this.coresel).addClass('yrc-loading-overlay');
			$.get(url, function(re){
				$(yc.coresel).removeClass('yrc-loading-overlay');
				yc.onResponse( re );
			});
		},
		
		normalizeItems: function( items ){
			var yc = this;
			items.forEach(function( item ){
				if( item.kind !== 'youtube#playlist' )
					item.id = typeof item.id === 'object' ? item.id.videoId : (item.contentDetails && item.contentDetails.videoId ? item.contentDetails.videoId : item.id || item.snippet.resourceId.videoId);
				yc.normalizeThumbs(item);
			});
			return items;
		},
		
		'onResponse': function( re ){
			$(this.coresel+' .yrc-pagination').remove();
			if(!re.items.length) return this.nothingFound();
			this.request.times += this.request.dir;
			
			if(this.temp_label === 'Custom'){
				re.nextPageToken = ((this.request.times*this.per_page) < this.custom_vids_length);
				re.pageInfo.totalResults = this.custom_vids_length;
			}
			
			if((re.nextPageToken && ((this.request.times*this.per_page) < this.max)) || re.prevPageToken){
				this.request.pagetokens = {'prev': re.prevPageToken, 'next': re.nextPageToken};
				this.more( re.nextPageToken, Math.min(this.max, re.pageInfo.totalResults) - (this.request.times*this.per_page) );
			}
					
			this.normalizeItems( re.items );
			this.temp_items = re.items;
						
			if(!this.wait_for_preload) this.list();
			this.wait_for_preload = false;

		},
		
		'init': function(s, label){
			this.page = 0;
			this.current = 0;
			this.ref = s;
			this.items = [];
			this.preloads = 0;
			this.label = YRC.extras[label].label;
			this.secsel = this.ref.sel + YRC.extras[label].sel;
			this.data = this.ref.data;
			this.max = window.parseInt(this.data.meta.maxv) || 10000;
			this.coresel = this.secsel;
			this.multi_page = this.data.style.pagination;
			this.theme = this.data.style.theme[ label === 'playlists' ? 'playlists' : 'videos' ];
			if( ['__grid', '__list'].indexOf(this.theme.style) < 0 && !YRC.is_pro ) this.theme.style = '__grid';
			this.request = {'id':'', 'page':'', 'times':0, 'pagetokens': [], 'dir' : 1};
			this.criteria = this.data.meta.default_sorting || '';
			this.per_page = window.parseInt(this.data.meta.per_page) || 24;
			
			if( ['__slides', '__carousel'].indexOf( this.theme.style ) > -1 ) this.max = this.per_page;
			
			this.blacklist = (this.data.meta[ label === 'playlists' ? 'blacklisted_playlists' : 'blacklist' ] || '')
				.split(',').map(function(v){ return v.trim(); }).filter(function(v){ return v; });
				
			this.whitelist = (this.data.meta[ label === 'playlists' ? 'whitelisted_playlists' : 'whitelist' ] || '')
				.split(',').map(function(v){ return v.trim(); }).filter(function(v){ return v; });
				
			$(this.coresel).addClass(this.theme.style);
			
			var yc = this;
			this.ref.EM.on('resize', function(e){ 
				if( !yc.items.length ) return;
				var pl = yc.label === 'Playlists';
				yc.calcThumbSize(pl);
				yc.adjust($(yc.secsel+' .yrc-core'), pl ? '.yrc-playlist-item' : '.yrc-video');
				yc.resizeItemMeta();
			});
			
			this.calcThumbSize(this.label === 'Playlists');
			this.fetchAtSetup();
			this.moreEvent();
			this.events();
			return this;
		},
		
		'fetchAtSetup': function(){ this.fetch(); },
		
		'list': function(){			
			this.temp_items = this.temp_items.filter(function(item){
				return !( item.snippet.title === 'Private video' || item.snippet.title === 'Deleted video' );
			});
				
			var bl= this.blacklist;
			if( bl.length ){
				this.temp_items = this.temp_items.filter(function(item){
					return !(bl.indexOf(item.id) > -1);
				});
			}
			
			var wl= this.whitelist;
			if( wl.length ){
				this.temp_items = this.temp_items.filter(function(item){
					return wl.indexOf(item.id) > -1;
				});
			}
			
			this.sortList();
			this.afterList();
			this.addItems( this.temp_items );
			
			if( (this.request.times === 1 || this.multi_page) &&  this.theme.style === '__sidebar' ){
				$(this.coresel).find('.yrc-core').find('a.yrc-video-link').eq(0).trigger('click');
			}
		},
		
		sortList: function(){
			this.sort_later = true;
			var srt = this.data.meta.temp_sort || (this.label === 'Uploads' ? (this.criteria || 'etad') : 'etad'), i;
			if((srt !== 'none') && (( this.onlyonce || this.data.meta.playlist || this.data.meta.custom || (this.label === 'Playlist')) || srt === 'title_desc') ){
				if((srt === 'date' || srt === 'title' || srt === 'etad' || srt === 'title_desc')){
					this.temp_items.sort(function(a, b){
							if(srt === 'date') {i = (new Date(a.snippet.publishedAt) < new Date(b.snippet.publishedAt));}
							else if (srt === 'title_desc') {i = (a.snippet.title < b.snippet.title);}
							else if (srt === 'title') {i = (a.snippet.title > b.snippet.title);}
							else {i = (new Date(a.snippet.publishedAt) > new Date(b.snippet.publishedAt));}
						return i ? 1 : -1;	
					});
					this.sort_later = false;
				}
			}
			YRC.EM.trigger('yrc.sort_video_items', [[ null, this, this.sort_later, this.temp_items ]]);
		},
		
		afterList: function(){
			this.page++;
			this.listVideos($(this.coresel), (this.label === 'Playlist' || this.temp_label === 'Playlist' || this.temp_label === 'Custom'));
			if(this.label === 'Playlist' && this.request.times === 1)
				$('html,body').animate({'scrollTop': $(this.coresel).parents('.yrc-content').offset().top-50}, 'fast');
		},
		
		normalizeThumbs: function( item ){
			var thumbs = item.snippet.thumbnails || {};
			item.thumbs = {};
			
			if( thumbs.medium ) item.thumbs.small  = thumbs.medium.url;
			if( !item.thumbs.small && thumbs['default'] ) item.thumbs.small  = thumbs['default'].url;
			
			if( thumbs.high ) item.thumbs.medium  = thumbs.high.url;
			if( !item.thumbs.medium && thumbs.medium ) item.thumbs.medium  = thumbs.medium.url;
			
			if( thumbs.maxres ) item.thumbs.large = thumbs.maxres.url;
			if( !item.thumbs.large ) item.thumbs.large = 'https://i.ytimg.com/vi/'+ item.id +'/maxresdefault.jpg';
			
			delete item.snippet.thumbnails;
		},
		
		'nothingFound': function(){
			if(this.label !== 'Uploads' && !this.ref.data.style.preload)
				$(this.coresel + ' ul').html(YRC.lang.form.Nothing_found);
			return false;
		},
		
		'adjust': function(core, item){
			core.find(item).addClass('yrc-full-scale');
			core.parents('.yrc-sections').css('height', 'auto');
			YRC.Styles[ this.theme.style.replace('__', '') ](this, core, item);
		},
		
		'calcThumbSize': function(pl){
			var fw = 0, rem = (parseInt(this.theme.carousel.spacing)||8), ww = this.ref.size.ww, in_row = 0, yc = this;
			
			function determineColumns( s ){
				var vid_f = s ? s : (yc.theme.thumb[0] !== 'small') ? 2 : 1,
					fxw = 160*vid_f;
				fw = fxw;
				in_row = Math.round(ww/fw);
					
				if(in_row > 1) ww -= (in_row - 1) * rem; 
				
				fw = ww/in_row;
			}
			 
			function thumbWidthFixedColumns(){
				 in_row = parseInt(yc.theme.carousel.thumbs);
				 fw = (yc.ref.size.ww - ( (in_row-1)*rem )) / ( in_row );
				 if( fw < 140 ) determineColumns( 1 );
			}
			
			if( !YRC.is_pro ) this.theme.carousel.thumbs = undefined;
									
			if( !parseInt(this.theme.carousel.thumbs) ) determineColumns();
			else thumbWidthFixedColumns();
			
			if(this.theme.style === '__list' || this.theme.style === '__slides')fw = ww;
			
			this.ref.size.per_row = in_row;
			
			var img_size = 'small';
			if( fw > 350 ) img_size = 'medium';
			if( fw > 500 ) img_size = 'large';
												
			this.gridstyle = {'fw':fw, 'in_row':in_row, 'rem':rem, 'img': img_size};
		},
		
		addItems: function( items ){
			var _items = this.items;
			items.forEach(function( item ){
				_items.push(item);
			});
			items = [];
		},
		
		'listVideos': function(cont, res){
			var core = cont.find('.yrc-core'), first = !this.first_loaded;
			this.lstVideos(core, res);
			YRC.EM.trigger('yrc.videos_listed', [[ core, this, this.sort_later, this.temp_items, this.items.length && first && this.items[0] ]]);
		},
		
		'lstVideos': function(core, res){
			if(this.data.style.pagination){
				core.empty();
				if((core.offset().top - $(window).scrollTop()) < 0){
					$('html,body').animate({'scrollTop': core.offset().top-50}, 'fast');
				}
			}
						
			var yc = this, is_large_screen = this.ref.screen === 'yrc-desktop',
				items = ( this.items.length && !this.first_loaded && this.preloads ? [this.items[0]] : [] ).concat(this.temp_items);
				il = (this.request.times - 1) * items.length;
												
			items.forEach(function( vid, i ){
				core.append( YRC.template.video( vid, res, yc.theme.thumb, yc.gridstyle.img, yc.theme.desc, il+i ) );
			});
			
			core.find('.yrc-onlyone-video').removeClass('yrc-onlyone-video');
			this.adjust(core, '.yrc-video');	
			
			core.find('.yrc-just-listed img').on('load', function(e){
				// to do, this.naturalWidth alternative for IE8
				if( this.getAttribute('data-yrc-size') === 'large' && this.naturalWidth === 120){
					this.setAttribute('src', this.getAttribute('src').replace('maxresdefault', 'hqdefault'));
				}
				var figure = $(this).parents('figure').addClass('yrc-full-scale');
				if( yc.theme.style === '__list' && yc.theme.thumb[1] === 'adjacent' )
					figure.next().css('height', is_large_screen ? $(this).height() || 'auto' : 'auto');
			});	
			
			if(!this.first_loaded && !this.preloading){
				this.first_loaded = true;
				YRC.EM.trigger('yrc.first_load', [[this, core]]);
				if(YRC.Styles.hooks) YRC.Styles.hooks();
			}
		},
		
		resizeItemMeta: function(){
			if( this.theme.style !== '__list' || this.theme.thumb[1] !== 'adjacent' ) return false;
			var is_large_screen = this.ref.screen === 'yrc-desktop';
			console.log(is_large_screen); return;
			$(this.coresel).find('.yrc-item figure').each(function(e){
				$(this).next().css('height', is_large_screen ? $(this).height() : 'auto');
			});	
		},
		
		empty: function(){
			$(this.secsel).find('.yrc-core').empty().end().find('.yrc-load-more-button').remove();
			this.ref.closePlayer();
			this.slickshell && this.slickshell.destroySlider();
			delete this.slickshell;
		},
		
		events: function(){
			var yc = this;
			$('body').on('click', this.secsel+' .yrc-video a.yrc-video-link, '+this.coresel+' .yrc-video a.yrc-video-link, '+ this.coresel +' .yrc-item-closed .yrc-item-meta, '+ this.secsel +' .yrc-item-closed .yrc-item-meta', function(e){
				if(yc.ref.player_mode !== 2){
					e.preventDefault();
					yc.ref.active_section = yc;
					var yi = $(this).parents('li').data('yi');
					YRC.play(yc.ref, $(this), yc.items[ yi ] || yc.temp_items[ yi ] );
				}
				$('body')
					.off('click', '.yrc-player-bar .yrc-close span, .pb-closer')
					.on('click', '.yrc-player-bar .yrc-close span, .pb-closer', function(e){
						yc.ref.closePlayer(e, yc);
					});
					
				$('body')
					.off('click', '.yrc-popup')
					.on('click', '.yrc-popup', function(e){
						if(!$(e.target).is('.yrc-popup')) e.stopPropagation();
						yc.ref.closePlayer(e, yc);
					});
				
				$(document).keyup(function(e) {
				  if (e.keyCode === 27) yc.ref.closePlayer(e, yc);
				});	
			});
			
			this.pluginEvents && this.pluginEvents();	
		}
		
	};
	
	Object.keys( YRC.extras ).forEach(function(section){
		section = YRC.extras[section].label;
		YRC[ section ] = function(){};
		YRC[ section ].prototype = new YRC.Base();
		YRC[ section ].prototype.constructor = YRC[ section ];
	});
							
	YRC.Uploads.prototype.fetchAtSetup = function(){
		var search_own = (this.ref.data.meta.search_own === undefined) ? 1 : this.ref.data.meta.search_own;
		this.vst = {'t':(this.ref.data.meta.search_term || ''), 'own': parseInt(search_own)};
				
		if(this.ref.data.meta.playlist){
			this.temp_label =  'Playlist';
			this.request.id = this.ref.data.meta.playlist;
		}
		
		this.proSetup && this.proSetup();
		this.fetch();
	};
								
	YRC.Playlist.prototype.fetchAtSetup = function(){};
			
	YRC.Playlists.prototype.sortList = function (){};
	YRC.Playlists.prototype.afterList = function (){
		var cont = $(this.coresel), core = cont.find('.yrc-core'), yc = this;
		this.temp_items.forEach(function(list){
			core.append( YRC.template.playlistItem( list, yc.data.style.theme.playlists.thumb, yc.gridstyle.img, yc.theme.desc ) );
		});
		this.adjust(core, '.yrc-playlist-item', this.ref.section, true);
	};
						
	YRC.Playlists.prototype.events = function(){
		var yc = this, pl = this.ref.playlist;
				
		$('body').on('click', yc.secsel+' .yrc-playlist-item a, '+ this.secsel +' .yrc-item-closed .yrc-item-meta', function(e){ 
			e.preventDefault();
			var li = $(this).parents('li');
			pl.request.id = li.data('playlist');
			pl.request.page = '';
			pl.request.times = 0;
			pl.items = [];
			$(yc.secsel).css('margin-top', function(){return -$(this).height(); }).find('.yrc-section-action').remove();
			$(yc.secsel).append( YRC.template.subSectionBar( li.find('.yrc-item-meta div').text() ));
			pl.fetch();
		});
				
		$('body').on('click', yc.secsel+' .yrc-playlist-bar .yrc-close span', function(e){ 
			var t = $(this);
			t.parents('.yrc-sub-section').css('margin-top', 0);
			window.setTimeout(function(){
				pl.empty();
				t.parents('li').remove();
			}, 500);
		});
		
		YRC.EM.on('resize', function(e){
			window.setTimeout(function(){
				if( $(yc.secsel).find('.yrc-section-action').length ){
					$(yc.secsel).css('margin-top', function(){return -$(this).height()+$(this).find('.yrc-section-action').outerHeight(); });
				}
			}, 500);
		});
	};		
	
	YRC.Styles = $.extend(YRC.Styles, {
		list: function(){},
		
		grid: function(yc, core, item){
			var items = core.find(item), in_row = yc.gridstyle.in_row, rem = yc.gridstyle.rem; 
			var margin_dir = yc.ref.rtl ? 'right' : 'left';
			var lastrow = items.length - (items.length % in_row) - 1;
			core.find(item+'.yrc-has-left').css(('margin-'+margin_dir), 0).removeClass('yrc-has-left');
									
			core.find(item).css('width', yc.gridstyle.fw).css(('margin-'+(margin_dir ==='left'?'right':'left')), function(i){
				if(i > lastrow) $(this).css(('margin-'+margin_dir), rem).addClass('yrc-has-left');
				if((i+1)%in_row) return rem;
				return 0;
			});
		}		
	});
	
	YRC.EM.trigger('yrc.classes_defined');
	
	function isObject( o ){
		return (typeof o === 'object' && !Array.isArray(o) && o !== null);
	}
	
	YRC.merge = function(o, n, ox, ke){
		for(var k in n){
			if( !isObject(n[k]) ){
				if(o === undefined) ox[ke] = n;
				else {
					if(o[k] === undefined) o[k] = n[k];
				}
			} else {
				if( !o ) o = {};
				YRC.merge(o[k], n[k], o, k);
			}
		}
	};
		
		
	YRC.backwardCompatible = function(channel){
		var bc = {
			meta:{
				ads:'1'
			},
			'style': {
				'default_tab': 'uploads',
				'uploads': 1,
				'banner': 1,
				'theme': {
					'a': 1,
					'videos': {
						'style': '__grid',
						'thumb':['large', 'open'],
						'desc': '',
						"carousel":{"thumbs":4,"thumbs_to_slide":2,"spacing":8},
						"carousel_nav":{"modifier":"__sides","position":["left, none"],"location":"prepend","background":"#fff","color":"#000","font_size":2,"border_radius":0}
					}
				},
				'player':{
					'show_desc': '',
					'show_meta': ''
				},
				'menu': 1,
				youtube_play_icon:'',
				sticky:{
					enable:0,
					width: 400,
					position: 'bottom-right',
					only_above: 768,
					margin:12
				}
			}
		};
										
		YRC.merge(channel, bc);
		YRC.EM.trigger('yrc.defaults', channel);
										
		return channel;
	};
		
	YRC.Setup = function(id, channel, host){
		this.id = id;
		this.uid = host.data('yrc-uid') || 'editor';
		this.Data = YRC.Data[this.uid] || {};
		
		if(channel.meta.playlist) channel.meta.onlyonce = false;
				
		delete channel.meta.temp_sort;
		if(!channel.meta.playlist && !channel.meta.custom){
			channel.meta.default_sorting = (channel.meta.default_sorting === 'none') ? '' : channel.meta.default_sorting;
		}
				
		if(this.Data.custom){
			channel.meta.custom = channel.meta.custom_vids = this.Data.custom;
		}
								
		if(channel.meta.onlyonce){
			channel.meta.playlist = channel.meta.channel_uploads;
			this.onlyonce = true;
			//channel.meta.maxv = parseInt(channel.meta.maxv) || 0;
			//channel.meta.per_page = parseInt(channel.meta.per_page) || 50;
		}
				
		channel = YRC.backwardCompatible( channel );
						
		this.data = channel;
		this.channel = channel.meta.channel;
		this.host = host;
		this.rtl = channel.style.rtl ? 'yrc-rtl' : '';
		this.player = {};
		this.EM = $({});
						
		this.size = YRC.sizer();		
		this.active_sections = {};
		
		if(this.data.style.playlists)this.active_sections.playlists = true;
		if(this.data.style.search)this.active_sections.search = true;
		if(this.data.style.uploads)this.active_sections.uploads = true;
				
		YRC.EM.trigger('yrc.presetup', this);
		
		this.size.size(this);
		this.init();
		if(this.active_sections.uploads)
			this.uploads = new YRC.Uploads().init(this, 'uploads');
		
		if(this.active_sections.playlists){
			this.playlist = new YRC.Playlist().init(this, 'playlist');
			this.playlists = new YRC.Playlists().init(this, 'playlists');
		}
		
		YRC.EM.trigger('yrc.setup', this);
		this.section = this.data.style.default_tab;
		if( !$(this.sel+' .yrc-menu-items li[data-section='+this.section+']').length )
			this.section = $(this.sel+' .yrc-menu-items li').first().data('section');
		this.resizeTabs( $(this.sel+' .yrc-menu-items li[data-section='+this.section+']').addClass('yrc-active').index() );
		this.size.sections();
		return this;
	};
	
	YRC.Setup.prototype = {
		'apiReady': function(){},
		'init': function(){
			this.player_mode = window.parseInt(this.data.style.player_mode);
			this.data.style.rating_style = this.data.style.theme.videos.thumb[0] === 'large' ? window.parseInt(this.data.style.rating_style) : 0;
			this.data.style.theme.videos.thumb.push(this.data.style.rating_style ? 'pie' : 'bar');
			if( !this.data.style.theme.playlists ) this.data.style.theme.playlists = this.data.style.theme.videos;
			
			this.host.append('<div class="yrc-shell '+this.rtl+ (YRC.is_pro ? ' yrc-pro-v' : ' yrc-free-v') +'" id="yrc-shell-'+ this.id +'">'+ YRC.template.content( this.active_sections ) +'</div>')
			this.sel = '#yrc-shell-'+ this.id;
			yrcStyle( this.sel, this.data );
			this.load();
			
			if(Object.keys(this.active_sections).length < 2){
				if(!YRC.is_pro || (YRC.is_pro && (!this.data.style.uploads || !this.data.style.menu)))
					$(this.sel+' .yrc-menu').addClass('pb-hidden');
			}
		},
		
		'load': function(){
			YRC.auth.apikey = YRC.auth.apikey || this.data.meta.apikey;
			var yc = this, url = YRC.auth.baseUrl('channels?part=snippet,contentDetails,statistics,brandingSettings&id='+this.channel);
			
			if(this.data.style.banner){
				if(this.Data.banner && this.Data.banner.items.length){
					setTimeout(function(){ yc.deploy( yc.Data.banner.items[0] ); });
				} else {
					$.get(url, function(re){ yc.deploy( re.items[0] ); });
				}
			} else {
				setTimeout(function(){ yc.events(); }, 100);
				$(this.sel + ' .yrc-banner').addClass('pb-hidden');
				YRC.EM.trigger('yrc.deployed', [[this.sel, this.data, this]]);
			}
		},
		
		'deploy': function(channel){
			if(!channel.brandingSettings) channel.brandingSettings = {image:{}, channel:{title: channel.snippet.title}};
			var image = this.size.ww > 640 ? 'bannerTabletImageUrl' : 'bannerMobileImageUrl';
				image = channel.brandingSettings.image[ image ];
			var brands = $(this.sel).find('.yrc-brand');
				brands.css('background', 'url('+ (image || channel.brandingSettings.image.bannerImageUrl)+ ') no-repeat');
				brands.eq(0).append( YRC.template.header(channel) );
			$(this.sel +' .yrc-stats').css('top', function(){ return 75 - ($(this).height()/2); })		
			this.events();
			YRC.EM.trigger('yrc.deployed', [[this.sel, this.data, this]]);
		},
		
		'events': function(){
			var sel = this.sel, yc = this;
			$('body').on('click', sel+' .yrc-menu-item', function(e){ 
				yc.section = $(this).data('section');
				$(this).addClass('yrc-active').siblings().removeClass('yrc-active');
				
				if(yc.section === 'search' || yc.section === 'playlists') $(sel+' .yrc-search-form-top').css('display', 'none');
				else $(sel+' .yrc-search-form-top').css('display', '');
				
				yc.resizeTabs( $(this).index() );
			});			
						
			YRC.EM.on('resize', function(){
				yc.size.resize();
			});	
		},
		
		resizeTabs: function( idx ){
			$(this.sel+' .yrc-sections').css('margin-'+(this.rtl ? 'right': 'left'), (idx * -this.size.ww))
				.children()
					.filter(function(){return $(this).index() === idx; })
						.css('height', 'auto')
				.siblings()
					.css('height', function(){ return $(this).height() })
					.css('height', 0);
		},
		
		closePlayer: function(e){
			if(e && e.isPropagationStopped && e.isPropagationStopped()) return false;
			if(this.player.player) this.player.player.destroy();
			$(this.sel+' .yrc-player-shell').remove();
			fpclose();
			$(this.sel).find('.yrc-sub-section').removeClass('yrc-no-player-nav');
			$(this.sel).find('.__slides .yrc-playing-inthumb').css('height', function(){
				$(this).find('figure').height($(this).width() * 9/16);
			});
			$(this.sel).find('.yrc-onlyone-video, .yrc-playing, figure a.pb-force-hide, .yrc-playing .yrc-item-meta').removeClass('yrc-onlyone-video yrc-playing pb-force-hide yrc-playing-inthumb');
			this.player = {};
			YRC.sticky.Player( 'off' );
		}
				
	};
					
	YRC.play = function(yc, a, vid){
		//console.log( yc.player_mode );
		var li = a.parents('li'), orig_mode = yc.player_mode;
		if( li.is('.yrc-playing') ) return false;
								
		yc.closePlayer(null, yc);
		if(!li.siblings().length){
			if(yc.data.style.theme.videos.style !== '__sidebar') li.addClass('yrc-onlyone-video');
			li.parents('.yrc-sub-section').addClass('yrc-no-player-nav');
		}
		li.addClass('yrc-playing');
				
		if(yc.load_first_video) yc.player_mode = 3; // play at top
				
		if(yc.player_mode){	// inline
			
			if(yc.data.style.theme.videos.style !== '__grid') yc.player_mode = 3;
			
			if( parseInt(yc.player_mode) === 3){	// at top
				// remove this
				// li.parent().prepend( YRC.template.player( li, yc ) );
								
				// if slider or list ->> Play in the thumb itself
				if( yc.data.style.theme.videos.style === '__slides' || yc.data.style.theme.videos.style === '__list' ){
					li.addClass('yrc-playing-inthumb').find('figure').css('height', 'auto').prepend(YRC.template.player( li, yc, false, vid ));
					li.find('figure a').addClass('pb-force-hide');
					var pl_style = yc.active_section.data.style.player;
					if(li.is('.yrc-item-closed') || pl_style.show_desc || pl_style.show_meta) li.find('.yrc-item-meta').addClass('pb-force-hide');
					if(yc.active_section.slickshell) yc.active_section.slickshell.autoHeight();
				} else {	// at top
					li.parents('.yrc-item-list').siblings('.yrc-player-holder').html( YRC.template.player( li, yc, false, vid ) );
				}
			} else {	// inline
				var idx = li.index()+1;
					idx = idx - idx%yc.size.per_row;
					idx = idx ? idx : yc.size.per_row;
					
				var v = a.parents('ul').children('li');
					v = v.eq(idx-1).length ? v.eq(idx-1) : v.last();
					v.after( YRC.template.player( li, yc, false, vid ) );
			}
							
			//if(!window.YC) $('html,body').animate({'scrollTop': $(yc.sel+' .yrc-player').offset().top-ofs}, 'slow');
		} else { // lightbox
			$('body').fPopup({'content': YRC.template.player( li, yc, false, vid)});
		}
		
		if(yc.load_first_video){
			yc.player_mode = orig_mode;
		}
		
		yc.player.player = YRC.Player(yc, true);
		delete yc.load_first_video;
		yc.player.list = li.parent();
	};
	
	YRC.playerHeight = function( player ){
		if(player.is('.yrc-sticky-player')) return false;
		player.css('height', function(){
			return (9/16) * $(this).parents('.yrc-player').width();
		});
	};
	
	YRC.Player = function(yc, play, volume, start){
		if(yc.load_first_video && !yc.data.meta.autoplay) play = false;
				
		var ofs = ($(window).height() - (((9/16) * $('.yrc-player', yc.host).width()) + $(yc.sel+' .yrc-player-bar').outerHeight()) ) / 2;
		if(!window.YC && play && yc.player_mode) $('html,body').animate({'scrollTop': $(yc.sel+' .yrc-player').offset().top-ofs}, 'slow');
				
		var player_el = yc.host.find('.yrc-player-video');
		if( !player_el.length ) player_el = $('.pb-p-content .yrc-player-video');
		YRC.playerHeight( player_el );
		
		var player = new YT.Player('yrc-player-frame-'+ yc.id, {
			events: {
				'onReady':function(e){
					if( yc.data.meta.ads && play ){
						//console.log('Adwala');
						player.loadVideoById(player.getVideoData().video_id);
					} else {
						//console.log('No Adwala');
						if(play && !YRC.iOS) e.target.playVideo();
					}
					if(play && start) e.target.seekTo(start);
					if(volume !== undefined) e.target.setVolume(volume);
				},
				'onStateChange': function(e){
					if(yc.data.style.sticky.enable && !window.YC)
						YRC.sticky.init(yc.id, e.data, player_el.parents('.__grid, .__list, .__carousel, .yrc-single, .__sidebar').length, yc);
					YRC.EM.trigger('yrc.player_state_change', [[yc, e]]); 
				}
			}
		});
		
		player.yrcid = yc.id;
						
		YRC.EM.on('yrc.player_state_change', function(e, d){
			if( d[1].data !== 1 && d[1].data !== 3 ) return;
			try{
				if(d[1].target.yrcid !== player.yrcid) player.pauseVideo();
			} catch(e){
				//console.log(e);
			}
		});
						
		return player;
	};
		
	YRC.sticky = {
		is: null,
		width: 400,
		channel: null,
		el: null,
		only_above: 0,
		
		init:function(ycid, eid, ok_theme, yc){
			if((eid === 3 || eid === 1) && ok_theme && this.channel !== ycid){
				var style = yc.data.style.sticky, pos;
				
				if( $(window).width() < parseFloat(style.only_above) )
					return this.Player(true);
				
				this.width = parseFloat(style.width);
				this.only_above = parseFloat(style.only_above);
				
				pos = style.position.split('-');
				if(pos.length !== 2)
					pos = ['bottom', 'right'];
				
				this.poscss = {};
				this.poscss[pos[0]] = style.margin+'px';
				this.poscss[pos[1]] = style.margin+'px';
								
				this.Player( true );
				this.Player( true, ycid );
			}
		},
		
		Player: function( off, id ){
			var sticky_width = this.width,
				poscss = this.poscss,
				nopos = {left:'', top:'', right:'', bottom:''};
				
			function onScroll(e){
				if( id !== YRC.sticky.channel ) return false;
				
				var	player_shell = $('#yrc-shell-'+ id +'-player-shell .yrc-player-frame');
					player = player_shell.children('.yrc-player-video').eq(0),
					ptop = player_shell.offset().top,
					ph = player_shell.height(),
					scroll = $(document).scrollTop();
									
				var sticky = (scroll > ptop + ph) || (scroll + $(window).height() < ptop);
															
				if( sticky === YRC.sticky.is ) return false;
												
				player.parent().css('height', sticky ? player_shell.height() : 'auto')
					.end()[ sticky ? 'addClass' : 'removeClass' ]('yrc-sticky-player')
						.css(sticky ? poscss : nopos)
						.css('width', sticky ? sticky_width : 'auto')
						.css('height', (9/16) * ( sticky ? sticky_width : player.width() ));
									
				YRC.sticky.is = sticky;
				YRC.sticky.el = player;
			}
											
			if( off && this.el ) {
				this.el.removeClass('yrc-sticky-player')
					.css(nopos)
					.css('width', 'auto')
					.css('height', (9/16) * this.el.width());
					
				this.channel = this.el = this.is = null;
				$(window).off('scroll', $.throttle(150, onScroll));
				
			} else if(id !== undefined) {
				
				this.channel = id;
				$(window).on('scroll', $.throttle(150, onScroll));
			}
		}
	};	
		
	YRC.EM.on('resize', function(e){
		if( YRC.sticky.is && YRC.sticky.el ){
			YRC.sticky.el.css({'width': YRC.sticky.width, 'height': 9/16 * YRC.sticky.width});
			YRC.sticky.el.parent().css({'height': function(){
				return 9/16 * $(this).width();
			}});
		}
		
		if( $(window).width() < YRC.sticky.only_above )
			YRC.sticky.Player(true);
	});

	
	YRC.sizer = function(){
		return {
			'size': function(ref){
				this.ref = ref || this.ref;
				var th = this.ref.host.css('height', $(window).height()+5);
				
				var outer = this.ref.host.parent();
				while( !outer.width() ){
					outer = outer.parent();
				}
				this.ww = outer.width() || 280;
				
				var screen = 'yrc-desktop';
					if(this.ww < 651) screen = 'yrc-tablet';
					if(this.ww < 481) screen = 'yrc-mobile';
				this.ref.screen = screen;
				this.ref.host.css('height', 'auto').removeClass('yrc-mobile yrc-tablet yrc-desktop').addClass(screen);
			},
			
			'resize': function(){
				this.size();
				this.sections();
				this.ref.EM.trigger('resize');
			},
			
			'sections': function(){
				var yc = this, section;
				$(yc.ref.sel+'.yrc-shell, '+yc.ref.sel+' .yrc-section').css('width', this.ww);
				$(yc.ref.sel+' .yrc-sections').css('width', this.ww*Object.keys(yc.ref.active_sections).length).css('margin-'+(yc.ref.rtl ? 'right': 'left'), function(){
					section = $(this).parent().find('.yrc-menu-items .yrc-active').data('section');
					return -($(this).parent().find('.yrc-menu-items .yrc-active').index() * yc.ww);
				});
				YRC.playerHeight($('#yrc-shell-'+this.ref.id+'-player-shell .yrc-player-video'));
			}
		};
	};
	
	YRC.Video = function(id, channel, host){
		this.id = id;
		this.uid = host.data('yrc-uid');
		this.data = YRC.backwardCompatible( channel );
		this.Data = YRC.Data[this.uid];
		this.channel = channel.meta.channel;
		this.active_sections = {};
		YRC.auth.apikey = YRC.auth.apikey || this.data.meta.apikey;
		this.host = host;
		this.sel = '#yrc-shell-'+ this.id;
		this.init();
	};

	YRC.Video.prototype = {
		init: function(){
			var vid_id = this.Data.video;
			
			this.host.append( YRC.template.player(vid_id, this, false, {id: vid_id, alone:true}, '&start='+(this.data.style.player.start||0)) );
			
			if(window.YT.Player)
				this.createPlayer();
						
			(YRC.single_videos[vid_id] || (YRC.single_videos[vid_id] = [])).push(this);
			YRC.EM.trigger('yrc.presetup', this);
			YRC.EM.trigger('yrc.setup', this);
			this.size();
			
			var self = this;
			YRC.EM.on('resize', function(){
				self.size();
			});
		},
		
		size: function(){
			this.ww = this.host.parent().width() || 280;
			var screen = 'yrc-desktop';
				if(this.ww < 651) screen = 'yrc-tablet';
				if(this.ww < 481) screen = 'yrc-mobile';
			this.host.removeClass('yrc-mobile yrc-tablet yrc-desktop').addClass(screen);
			YRC.playerHeight(this.host.find('.yrc-player-video'));
		},
		
		createPlayer: function(){
			this.player = YRC.Player(this, this.data.meta.autoplay, this.data.style.player.volume, this.data.style.player.start);
		},
		
		apiReady: function(){
			if( !this.player )
				this.createPlayer();
		},
	};
		
	YRC.template.header = function(channel){
		return '<div class="yrc-name pb-absolute">\
					<img src="'+ channel.snippet.thumbnails.default.url +'"/>\
					<span>'+ channel.brandingSettings.channel.title +'</span>\
				</div>\
				<div class="yrc-stats pb-absolute">\
					<span class="yrc-subs"></span>\
					<span class="yrc-videos pb-block">'+ YRC.template.vicon +'<span class="pb-inline">'+ YRC.template.num( channel.statistics.videoCount ) +'</span></span>\
					<span class="yrc-views pb-block">'+ YRC.template.eyecon +'<span class="pb-inline">'+ YRC.template.num( channel.statistics.viewCount ) +'</span></span>\
				</div>';
	};	
	
	YRC.template.search = YRC.template.search || function(){ return '';};
	YRC.template.playlists = '<div class="yrc-section pb-inline">\
								<div class="yrc-playlists yrc-sub-section">\
									<div class="yrc-item-list">\
										<ul class="yrc-core"></ul>\
									</div>\
								</div>\
								<div class="yrc-playlist-videos yrc-video-list yrc-sub-section">\
									<div class="yrc-player-holder"></div>\
									<div class="yrc-item-list">\
										<ul class="yrc-core"></ul>\
									</div>\
								</div>\
							</div>';
				
	YRC.template.content = function( secs ){
		return '<div class="yrc-banner pb-relative"><div class="yrc-brand pb-relative"></div></div>\
		<div class="yrc-content">\
			<div class="yrc-menu pb-relative">\
				<ul class="yrc-menu-items">'+
					(secs.uploads ? '<li class="pb-inline yrc-menu-item" data-section="uploads">'+ YRC.lang.form.Videos +'</li>' : '') +
					(secs.playlists ? '<li class="pb-inline yrc-menu-item" data-section="playlists">'+ YRC.lang.form.Playlists +'</li>' : '') +
				'</ul>\
			</div>\
			<div class="yrc-sections">' +
				(secs.uploads ? '<div class="yrc-section pb-inline"><div class="yrc-uploads yrc-video-list yrc-sub-section">\
						<div class="yrc-player-holder"></div>\
						<div class="yrc-item-list">\
							<ul class="yrc-core"></ul>\
						</div>\
					</div>\
				</div>': '') +
				(secs.playlists ? YRC.template.playlists : '') + (secs.search ? YRC.template.search() : '') +
			'</div>\
		</div>\
		<div class="yrc-banner"><div class="yrc-brand pb-relative"></div></div>';
	};	
	
	YRC.template.loadMoreButton = function (more, prev, multi){
		var wrap = '<div class="yrc-pagination '+ (multi ? 'yrc-multi-page' : '') +'">';
			if(multi && prev) wrap += '<li class="yrc-load-more-button yrc-button yrc-prevpage">'+ YRC.lang.form.Prev +'</li>';
			if(more > 0) wrap += '<li class="yrc-load-more-button yrc-button yrc-nextpage">'+ ( multi ? YRC.lang.form.Next : (YRC.template.num(more) +' '+ YRC.lang.form.more)) +'</li>';
		wrap += '</div>';
		return wrap;
	};
	
	YRC.template.num = function( num, min ){
		if(!min) min = YRC.lang.fui.max_plain_number;
		if(num < min) return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		
		if(num >= 1000000000) {
			num =  (num / 1000000000).toFixed(1).replace(/\.0$/, '') + YRC.lang.fui.billion;
		} else if(num >= 1000000) {
			num =  (num / 1000000).toFixed(1).replace(/\.0$/, '') + YRC.lang.fui.million;
		} else  if (num >= 1000) {
			num =  (num / 1000).toFixed(1).replace(/\.0$/, '') + YRC.lang.fui.thousand;
		}
		
		return num;
	};
	
	YRC.template.subSectionBar = function( title , player, type){
		return '<li class="yrc-section-action yrc-player-top-'+type+' '+(player ? 'yrc-player-bar':'yrc-playlist-bar')+'">\
			<span class="yrc-sub-section-name">'+ title
			+'</span><span class="yrc-close"><span><i class="yi yi-times"></i></span></span>\
		</li>';
	};
	
	YRC.template.playerTop = function(li, type){
		if( typeof li === 'string' ) return [li, ''];
		return [li.data('video'), li.find('.yrc-video-'+type).html()||''];
	};
			
	YRC.template.player = function( li, yc, lightbox, vid, extra){
		if( !vid.alone ) setTimeout(function(){ YRC.EM.trigger('player_template', [vid, yc]); }, 1);
		
		var type = yc.data.style.player_top,
			v =  this.playerTop(li, type);
			
		return '<div class="yrc-player-shell '+(lightbox ? 'yrc-lightbox' : 'yrc-inline-player')+'" id="'+yc.sel.replace('#', '')+'-player-shell">\
			<div class="yrc-player">'
				+ YRC.template.subSectionBar(v[1], true, type) +
				'<div class="yrc-player-content">\
					<div class="yrc-player-frame">\
						<div class="yrc-player-video">\
							<iframe id="yrc-player-frame-'+ yc.id +'" style="width:100%;height:100%" src="//www.youtube.com/embed/'+v[0]+'?enablejsapi=1&rel=0&origin='+(window.location.origin)+'&modestbranding=1&controls=1'+extra+'" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>\
							<a class="pb-absolute fis-prev fis-arrow" href=""></a><a class="pb-absolute fis-next fis-arrow" href=""></a>\
						</div>\
					</div>\
				</div>\
			</div></div>';
	};
	
	YRC.template.playerVideoContent = function( vid, yc ){
		var style = yc.data.style.player;			

		var info = style.show_meta ? '<div class="yrc-player-video-info">\
										<div class="yrc-player-video-title">'+ vid.snippet.title +'</div>\
									</div>' : '';
		var desc = style.show_desc ? '<div class="yrc-player-video-details">\
										<div class="yrc-player-video-date">Published '+ miti( new Date(vid.snippet.publishedAt) ) +'</div>\
										<div class="yrc-player-video-description">'+ vid.snippet.description +'</div>\
										<div class="yrc-player-video-description-more">'+ YRC.lang.fui.show_more +'</div>\
									  </div>' : '';
									  
		return 	style.show_meta || style.show_desc ? ('<div class="yrc-player-video-content">'+ info + desc +'</div>') : '';
	};
	
	$.fn.fPopup = function( options ){
		this.each(function(){
						
			$(this).append([
				'<div class="pb-popup yrc-popup">',
					'<div class="pb-p-shell">',
						'<div class="pb-popup-bar pb-clr">',
							'<span class="pb-popup-title pb-float-left"></span>',
							'<span class="pb-closer pb-float-right"><span class="pb-close yi yi-close"><span/></span></div>',
						'<div class="pb-p-content">'+( options.content || '<div class="pb-loading">Loading...</div>')+'</div>',
					'</div>',
				'</div>'].join(''));
															
			$(this).find('.pb-p-shell').css( {'margin-top': function(){
					var sl = $(this),
						wh =  ($(window).height() - (sl.width() * 9/16))/2;
						
					sl.parent().css('height', $(document).outerHeight());
																	
					return jQuery(window).scrollTop() + (  wh > 0 ? wh : 20 ) + 'px';
				}
			});
			
		});
	};
		
	function fpclose(){
		$('.pb-popup').remove();
	}
	
	function fpresize( yc ){
		if( yc && yc.active_section && yc.active_section.slickshell ) yc.active_section.slickshell.autoHeight();
		$('.pb-popup').css('height', $(document).outerHeight());
	}
	
	YRC.fpresize = fpresize;
			
	YRC.template.video = function( vid, res, style, img, show_desc, i ){
		var cl = style[0] +(style[0] === 'adjacent' ? '' : ' yrc-item-'+style[1]),
			is_live = vid.snippet.liveBroadcastContent === 'live';
			
		return '<li class="yrc-video yrc-item-'+ cl +' yrc-item yrc-just-listed" data-video="'+ vid.id +'" data-yi="'+i+'">\
				<figure class="yrc-thumb pb-inline pb-relative">\
					<a href="'+ watch_video + vid.id +'" class="yrc-video-link pb-block" target="_blank" title="'+ vid.snippet.title +'">\
						<img src="'+ ( vid.thumbs[img] || vid.thumbs.large || vid.thumbs.medium || vid.thumbs.small ) +'" data-yrc-size="'+img+'"/>\
					</a>\
				</figure><div class="yrc-item-meta pb-inline">\
						<div class="yrc-name-date yrc-nd-'+style[2]+'">\
							<span class="pb-block yrc-video-title yrc-item-title"><a href="'+ watch_video + vid.id +'" class="yrc-video-link" target="_blank" title="'+ vid.snippet.title +'">'+ vid.snippet.title +'</a></span>\
							<span class="yrc-video-date '+( is_live ? 'yrc-live' : '' )+'">'
								+ (is_live ? YRC.lang.fui.live_now : miti( new Date(vid.snippet.publishedAt) )) +
							'</span>'+
							'<span class="yrc-video-views"></span>\
						</div>'
						+ (show_desc ? '<div class="yrc-item-desc yrc-video-desc">'+YRC.template.urlify(vid.snippet.description) +'</div>' : '') +'\
					</div>\
			</li>';
	};
	
	YRC.template.urlify = function(text) {
		var urlRegex = /(https?:\/\/[^\s]+)/g;
		return text.replace(urlRegex, function(url) {
			return '<a href="' + url + '" target="_blank">' + url + '</a>';
		});
	};
	
	YRC.iOS = (function(){
		var userAgent = navigator.userAgent || navigator.vendor || window.opera;
		return ( userAgent.match( /iPad/i ) || userAgent.match( /iPhone/i ) || userAgent.match( /iPod/i ) );
	}());
	
	YRC.template.playlistItem = function( item, style, img, show_desc ){
		var cl = style[0] +(style[0] === 'adjacent' ? '' : ' yrc-item-'+style[1]);
		return '<li class="yrc-playlist-item yrc-item yrc-item-'+cl+'" data-playlist="'+ item.id +'">\
				<figure class="yrc-thumb pb-inline yrc-full-scale"><a href="https://www.youtube.com/playlist?list='+item.id+'" target="_blank" title="'+ item.snippet.title +'"><img src="'+ ( item.thumbs[img] || item.thumbs.large || item.thumbs.medium || item.thumbs.small ) +'"\></a>\
					</figure><div class="pb-inline yrc-item-meta"><div class="pb-block yrc-item-title"><a href="https://www.youtube.com/playlist?list='+item.id+'" target="_blank" title="'+ item.snippet.title +'">'+ item.snippet.title +'</a></div>\
						<span class="pb-block">'+ item.contentDetails.itemCount +' '+YRC.lang.form.Videos.toLowerCase()+'</span>\
						<span class="pb-block">'+ miti( new Date(item.snippet.publishedAt) ) +'</span>' +
						(show_desc ? '<div class="yrc-item-desc">'+ item.snippet.description +'</div>' : '')
					+ '</div>\
			</li>';
	};
	
	
	YRC.template.eyecon = '<i class="yi yi-eye"></i>';
	YRC.template.vicon = '<i class="yi yi-video-camera"></i>';
				
	$('body').on('click', '.yrc-shell .yrc-brand, .yrc-shell .yrc-sections', function(e){
		e.stopPropagation();
		$('.yrc-sort-uploads').addClass('pb-hidden');
	});	
		
	$(window).on('resize', $.throttle(250, function(e){
		YRC.EM.trigger('resize');
	}));
		
	
	YRC.Setups = {};	
	
	if( !YRC.Data ) YRC.Data = {};
	//YRC.Data = {};
	//delete YRC.Data[ Object.keys(YRC.Data)[0] ].uploads;
	
	YRC.run = function(shell){
		if(!shell.attr('data-yrc-setup') && shell.length){
			var data = shell.data('yrc-channel');
			shell.attr('data-yrc-setup', 1);
			YRC.Setups[YRC.counter] = new YRC[ data.meta.single ? 'Video' : 'Setup' ](YRC.counter++, data, shell);
		}
	};
	
	YRC.lang = YRC.lang || yrc_lang_terms;
	
	if (!window.location.origin) {
	  window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port: '');
	}
	
	function cleanPage(){
		//$('html, body').attr('dir', 'rtl');
		$('#secondary, .entry-footer, #masthead, .entry-header').remove();
		$('#content').css({'padding': '0'});
		$('#primary').css({'width': '100%', 'margin': '1em auto'});
	}
	//cleanPage();
	
	YRC.run( $('.yrc-shell-cover').eq(0) );
	$('.yrc-single').each(function(){ YRC.run( $(this) ); });
	
	YRC.EM.trigger('yrc.run');
	
});
