jQuery( document ).ready(function() {

	//IE doesn't like Google fonts...apparently it's Google's fault
	//at the moment, but whatever...load Web Safe font for IE users
	var gbr = FUSION.get.browser();
	if(gbr.browser && gbr.browser == "IE")
	{
// 		document.body.style.fontFamily = "'Trebuchet MS', Helvetica, sans-serif";
		document.body.style.setProperty("font-family", "'Trebuchet MS', Helvetica, sans-serif", "important");
	}

	$( "#schedule_schedule_date" ).datepicker();

	var path = window.location.pathname.split("/").clean("");

	if(path.length > 0)
	{
		console.log("gothere1");
		console.log(path.join("--"));
		if(path[0] == "songs")
		{
			console.log("gothere2");
			if(path[1] == "new" || path[path.length - 1] == "edit")
			{
				console.log("gothere3");
				$('#song_author').editableSelect();
				$('#song_composer').editableSelect();
			}
		}
	}

	var options = {
		valueNames: [ 'song_name' ]
	};

	var songList = new List('song_list_div', options);
});