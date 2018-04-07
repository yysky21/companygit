//Cufon.replace("#navigation ul li a", { hover: true });

function bindControls(carousel, state)
{
	$(".slider-navigation .next").bind("click", function(){
		carousel.next();
	})
	$(".slider-navigation .previous").bind("click", function(){
		carousel.prev();
	})
}

$(document).ready(function(){
	
	$(".slider-holder ul").jcarousel({
		
		auto:4,
		scroll:1,
		wrap: "both",
		initCallback: bindControls
		
	});	
	
	$(".field").focus(function(){
			if($(this).val()==$(this).attr('title'))
				$(this).val("");
		});
	
	$(".field").blur(function(){
			if($(this).val()=="")
				$(this).val($(this).attr('title'));
		});
		
	$("#navigation .with-dd").hover(function(){
		$("div", this).show();
		
		if($("a:eq(0)", this).hasClass("active"))
			$("a:eq(0)", this).addClass("wasactive")
		else
		$("a:eq(0)", this).addClass('active');
		
	}, function(){
		$("div", this).hide();
		
		if($("a:eq(0)", this).hasClass("wasactive"))
			$("a:eq(0)", this).removeClass('wasactive');
		else
			$("a:eq(0)", this).removeClass('active');
	});
});