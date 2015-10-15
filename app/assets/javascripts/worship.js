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

	var sng_coldefs = [{ "type": "date", "targets": 5 }];
	if(FUSION.get.node("song_table"))
	{
		var sng_last_col = FUSION.get.node("song_table").rows[0].cells.length - 1;
		var sng_cols_arr = [];
		if(sng_last_col > 4)
		{
			for(var i = 6; i <= sng_last_col; i++)
			{
				sng_cols_arr.push(i);
			}
			//sng_coldefs = [{ "searchable": false, "targets": sng_cols_arr }, { "orderable": false, "targets": sng_cols_arr }];
			sng_coldefs.push({ "searchable": false, "targets": sng_cols_arr });
			sng_coldefs.push({ "orderable": false, "targets": sng_cols_arr });
		}
	}

	$('#song_table').DataTable({
		"pageLength":50,
		"columnDefs": sng_coldefs
	});

	$("#song_search_table").DataTable();

	var sch_coldefs  = [];
	if(FUSION.get.node("schedule_table"))
	{
		var sch_last_col = FUSION.get.node("schedule_table").rows[0].cells.length - 1;
		if(sch_last_col > 3)
		{
			sch_coldefs = [{ "searchable": false, "targets": sch_last_col }, { "orderable": false, "targets": sch_last_col }];
		}
	}
	$('#schedule_table').DataTable({
		"order": [[ 1, "desc" ]],
		"columnDefs": sch_coldefs
	});

	$( "#all_reports" ).tabs();

	$( "#schedule_schedule_date" ).datepicker();
	$( "#attendance_start_time" ).datepicker();
	$( "#attendance_end_time" ).datepicker();

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

	$( "#current_song_list" ).sortable({
		stop: function( event, ui ) {
			var li_arry = this.getElementsByTagName("li");
			var id_arry = [];
			var id_tmp = "";
			for(var i = 0; i < li_arry.length; i++)
			{
				id_tmp = li_arry[i].getElementsByClassName("song_id")[0].innerHTML;
				id_arry.push(id_tmp);
			}
			FUSION.get.node("schedule_song_order").value = JSON.stringify(id_arry);
		}
	});

    $( "#current_song_list" ).disableSelection();

	if ($('.pagination').length) {
		$(window).scroll(function() {
			var url = $('.pagination .next_page').attr('href');
			if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
				$('.pagination').text("Please Wait...");
				return $.getScript(url);
			}
		});
		return $(window).scroll();
	}

	$( "#song_search_txt" ).keypress(function( event ) {
		if ( event.which == 13 ) {
			event.preventDefault();
			var ul = FUSION.get.node("full_song_list");
			var li_arry = ul.getElementsByTagName("li");
			if(li_arry.length > 0)
			{
				var li = li_arry[0];
				addSongToSchedule(li);
			}
		}
	});

});


function closeNotice(t)
{
	try {
		if(t && FUSION.lib.isElement(t)) {
			$( t.parentNode ).fadeOut( "slow", function() {});
		}
	}
	catch(err) { FUSION.error.logError(err); }
}


function updateAdmin(id, chk)
{
	alert("ID IS: " + id + ",  CHECKED IS: " + chk);
}


function checkScheduleForm()
{
	var sname = FUSION.get.node("schedule_name").value;
	var sdate = FUSION.get.node("schedule_schedule_date").value;

	if(FUSION.lib.isBlank(sname) || FUSION.lib.isBlank(sdate))
	{
		alert("Please enter both a name and a date before saving the schedule!");
		return false;
	}

	if(!isValidDate(sdate))
	{
		alert("Please select a valid date!");
		return false;
	}

	return true;
}


// Validates that the input string is a valid date formatted as "mm/dd/yyyy"
function isValidDate(dateString)
{
	try {
		// First check for the pattern
		if(!/^\d{1,2}\/\d{1,2}\/\d{4}$/.test(dateString))
		{ return false; }

		// Parse the date parts to integers
		var parts = dateString.split("/");
		var day   = 0;
		var month = 0;
		var year  = 0;

		if(parts.length == 3)
		{
			day   = parseInt(parts[1], 10);
			month = parseInt(parts[0], 10);
			year  = parseInt(parts[2], 10);
		}
		else
		{ return false; }

		// Check the ranges of month and year
		if(year < 2000 || year > 2100 || month < 1 || month > 12)
		{ return false; }

		var monthLength = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

		// Adjust for leap years
		if(year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
		{ monthLength[1] = 29; }

		// Check the range of the day
		return day > 0 && day <= monthLength[month - 1];
	}
	catch(err) {
		FUSION.error.logError(err);
		return false;
	}
}


function checkUserForm()
{
	var fname = FUSION.get.node("user_first_name").value;
	var lname = FUSION.get.node("user_last_name").value;
	var email = FUSION.get.node("user_email").value;

	if(FUSION.lib.isBlank(fname) || FUSION.lib.isBlank(lname) || FUSION.lib.isBlank(email))
	{
		alert("Please make sure you have a first name, last name, and email address entered!");
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
	catch(err){
		FUSION.error.logError(err);
	}
}


function addSongToSchedule(t)
{
	var old_li = t;
	var new_ul = FUSION.get.node("current_song_list");
	var new_sn = old_li.getElementsByTagName("p")[0].innerHTML;
 	var sng_id = old_li.getElementsByTagName("p")[1].innerHTML;
	var new_li = FUSION.lib.createHtmlElement({"type":"li", "attributes":{"class":"song_list_li"}, "style":{"display":"list-item"}});
	var new_p1 = FUSION.lib.createHtmlElement({"type":"p", "text":new_sn, "style":{"margin":"0px"}, "attributes":{"class":"song_name"}});
 	var new_p2 = FUSION.lib.createHtmlElement({"type":"p", "text":sng_id, "style":{"display":"none"}, "attributes":{"class":"song_id"}});
	var newbtn = FUSION.lib.createHtmlElement({"type":"button", "onclick":"removeSongFromSchedule(this.parentNode)", "attributes":{"class":"li_delete"}});
	var newspn = FUSION.lib.createHtmlElement({"type":"span", "attributes":{"class":"glyphicon glyphicon-remove"}});

	newbtn.appendChild(newspn);
	new_li.appendChild(new_p1);
	new_li.appendChild(new_p2);
	new_li.appendChild(newbtn);
	new_ul.appendChild(new_li);

	var sids = JSON.parse(FUSION.get.node("schedule_song_order").value);
	sids.push(sng_id);
	FUSION.get.node("schedule_song_order").value = JSON.stringify(sids);
	FUSION.get.node("song_search_txt").value = "";

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


function getSchedules()
{
	var sid = FUSION.get.node("song_search").value;
	if(!sid || FUSION.lib.isBlank(sid)) {
		return false;
	}

 	FUSION.get.node("song_search_txt").value = "";
	var table = $('#song_search_table').DataTable();
	table.clear().draw();

	var info = {
		"type": "GET",
		"path": "/songs/" + sid + "/getSongSchedules",
		"data": {
			"song_id": sid
		},
		"func": displaySongSchedules
	};
	FUSION.lib.ajaxCall(info);
}


function displaySongSchedules(h)
{
	var hash = h || {};
	if(hash['num_schedules'] > 0)
	{
		var table = $("#song_search_table").DataTable();
		var scheds  = hash['schedules'];
		FUSION.get.node("song_name").innerHTML = hash['song_name'];

		var dt = "";
		var domain = window.location.host;
		for(var i = 0; i < scheds.length; i++)
		{
			dt = moment(scheds[i]['schedule_date']).format("MM/DD/YYYY");
			table.row.add( [ dt, "<a href='http://" + domain + scheds[i]['url'] + "'>" + scheds[i]['name'] + "</a>", scheds[i]['notes'] ]).draw();
		}
	}
}


function sortUl(parent, childSelector, keySelector) {
    var items = parent.children(childSelector).sort(function(a, b) {
        var vA = $(keySelector, a).text();
        var vB = $(keySelector, b).text();
        return (vA < vB) ? -1 : (vA > vB) ? 1 : 0;
    });
    parent.append(items);
}
