$(document).ready(function () {
	
	$("#loading").ajaxStart(function(){
	  $(this).fadeIn();
	}).ajaxStop(function(){
	  $(this).fadeOut();
	});
	
	$('.popup').mouseover(function () {
		$(this).find('ul').show();
	}).mouseleave(function () {
		$(this).find('ul').fadeOut('fast');
	});
	
	$('.popup ul li a').click(function () {
		var ul = $(this).parents('ul');
		ul.hide();
		$.getScript($(this).attr('href'));
		return false;
	});
	
	$('#new_comment').submit(function () {
		$.ajax({
		  type: "POST",
		  url: $(this).attr('action'),
		  data: $(this).serialize(),
			dataType: "script"
		});
		
		$(this)[0].reset();
		
		return false;
	});
});

function school_position_update(url,point){
	$.post(url, { lng: point.x, lat: point.y });
}

$(document).ajaxSend(function(event, request, settings) { 
	if (typeof(window._token) == "undefined") return;
	
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(window._token);
});
