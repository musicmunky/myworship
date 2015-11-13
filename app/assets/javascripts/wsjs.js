/*$(function() {

	// Here we instantiate a new WebSocketRails instance
	dispatcher = new WebSocketRails("45.55.189.112:3004/websocket", true);
// 	dispatcher = new WebSocketRails("ffcsongs.com/websocket", true);

	// We bind the incoming message event
	channel = dispatcher.subscribe('comment');

	channel.bind('new_comment', function(message) {
		if(FUSION.get.node("sys_notes")) {
			var spn = FUSION.get.node("sys_notes");
			spn.innerHTML = "New " + message['notification_type'] + " from " + message['user_name'];
			spn.style.display = "block";
		}
	});

});

// Here we send the message in the websocket
function send(message) {
 	channel.trigger('new_comment', message);
}*/