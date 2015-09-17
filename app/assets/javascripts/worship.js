var SONGLIST = {};

jQuery( document ).ready(function() {

	//IE doesn't like Google fonts...apparently it's Google's fault
	//at the moment, but whatever...load Web Safe font for IE users
	var gbr = FUSION.get.browser();
	if(gbr.browser && gbr.browser == "IE")
	{
// 		document.body.style.fontFamily = "'Trebuchet MS', Helvetica, sans-serif";
		document.body.style.setProperty("font-family", "'Trebuchet MS', Helvetica, sans-serif", "important");
	}

	$('#song_table').DataTable({
		"columnDefs": [{ "searchable": false, "targets": [5,6,7] }, { "orderable": false, "targets": [5,6,7] }]
	});
	$('#schedule_table').DataTable({
		"order": [[ 1, "desc" ]],
		"columnDefs": [{ "searchable": false, "targets": 4 }, { "orderable": false, "targets": 4 }]
	});

	$( "#schedule_schedule_date" ).datepicker();

	var path = window.location.pathname.split("/").clean("");
	if(path.length > 0)
	{
		if(path[0] == "songs")
		{
			if(path[1] == "new" || path[path.length - 1] == "edit")
			{
				$('#song_author').editableSelect();
				$('#song_composer').editableSelect();
			}
		}
	}
	createSongList();
});


function checkScheduleForm()
{
	var sname = FUSION.get.node("schedule_name").value;
	var sdate = FUSION.get.node("schedule_schedule_date").value;

	if(FUSION.lib.isBlank(sname) || FUSION.lib.isBlank(sdate))
	{
		alert("Please enter both a name and a date before saving the schedule!");
		return false;
	}
	return true;
}


function checkSongForm()
{
	var sname = FUSION.get.node("song_name").value;
	var sauth = FUSION.get.node("song_author").value;
	if(FUSION.lib.isBlank(sname) || FUSION.lib.isBlank(sauth))
	{
		alert("Please enter both a song name and an author before saving the song!");
		return false;
	}
	return true;
}


function createSongList()
{
	try {
		var options  = { valueNames: [ 'song_name' ] };
		var songList = new List('song_list_div', options);
		SONGLIST = songList;
		SONGLIST.sort('song_name', { order: "asc" });
	}
	catch(err){}
}


function addSongToSchedule(t)
{
	var old_li = t;
	var new_ul = FUSION.get.node("current_song_list");
	var new_sn = old_li.getElementsByTagName("p")[0].innerHTML;
 	var sng_id = old_li.getElementsByTagName("p")[1].innerHTML;
	var new_li = FUSION.lib.createHtmlElement({"type":"li",
											   "attributes":{"class":"song_list_li"},
											   "style":{"display":"list-item"},
											   "onclick":"removeSongFromSchedule(this)"});
	var new_p1 = FUSION.lib.createHtmlElement({"type":"p", "text":new_sn, "style":{"margin":"0px"}, "attributes":{"class":"song_name"}});
 	var new_p2 = FUSION.lib.createHtmlElement({"type":"p", "text":sng_id, "style":{"display":"none"}, "attributes":{"class":"song_id"}});

	new_li.appendChild(new_p1);
	new_li.appendChild(new_p2);
	new_ul.appendChild(new_li);

	var sids = JSON.parse(FUSION.get.node("schedule_song_order").value);
	sids.push(sng_id);
	FUSION.get.node("schedule_song_order").value = JSON.stringify(sids);

	SONGLIST.remove("song_name", new_sn);
}


function removeSongFromSchedule(t)
{
	var old_li = t;
	var new_sn = old_li.getElementsByTagName("p")[0].innerHTML;
 	var sng_id = old_li.getElementsByTagName("p")[1].innerHTML;
	FUSION.remove.node(old_li);

	var options = {
		"item": "<li><p class='song_name'></p><p style='display:none;' class='song_id'></p></li>",
		"song_name": new_sn,
		"song_id": sng_id
	};

	var sids = JSON.parse(FUSION.get.node("schedule_song_order").value);
	var index_int = sids.indexOf(sng_id);
	var index_str = sids.indexOf(parseInt(sng_id));
	if(index_int > -1) {
		sids.splice(index_int, 1);
	}
	if(index_str > -1) {
		sids.splice(index_str, 1);
	}
	FUSION.get.node("schedule_song_order").value = JSON.stringify(sids);

	SONGLIST.add(options);
 	SONGLIST.sort('song_name', { order: "asc" });
}


function sortUl(parent, childSelector, keySelector) {
    var items = parent.children(childSelector).sort(function(a, b) {
        var vA = $(keySelector, a).text();
        var vB = $(keySelector, b).text();
        return (vA < vB) ? -1 : (vA > vB) ? 1 : 0;
    });
    parent.append(items);
}
