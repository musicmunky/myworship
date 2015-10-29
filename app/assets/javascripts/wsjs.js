$(function() {

	// Here we instantiate a new WebSocketRails instance
	dispatcher = new WebSocketRails("45.55.189.112:3004/websocket", true);

	// We bind the incoming message event
	channel = dispatcher.subscribe('comment');

	channel.bind('new_comment', function(message) {
		if(FUSION.get.node("sys_notes")) {
			FUSION.get.node("sys_notes").style.display = "block";
		}
// 		document.querySelector('#sys_notes').innerHTML = message;
	});

});

// Here we send the message in the websocket
function send(message) {
 	channel.trigger('new_comment', message);
}