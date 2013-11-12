if(!LOG) var LOG = {};

LOG.registerEventHandlers = function(eventid){
	$("#details-header-text").text(LOG.event.EventSubject);
	$('#details-header').live('click',function(event){
		window.location = 'LogalyticsFeed';
	});
}

LOG.getEvent = function(eventid){
	var event = null;
	for (var i=0;i<LOG.events.length;i++){
		if(LOG.events[i].Id === eventid){
			event = LOG.events[i];
			break;
		}
	}
	return event;
};

LOG.bindFeed = function(container, eventFilter){
	var output = '';
	var displayedItemsCount = 0;
	$("#" + container).empty();
	var dividers = [];
			
	LOG.today 		= new XDate();
	LOG.yesterday 	= new XDate().addDays(-1);
			
	$.each(LOG.events, function(index, value){
		if(eventFilter != 'all' && eventFilter != value.EventType){
			return true; //continue
		}
		var dt = new XDate( parseInt(value.timestamp) );
		var label = LOG.getDividerLabel(dt);
		if( $.inArray(label, dividers) == -1){
			output += '<div class="feed-date-separator">' + label + '</div>';
			dividers.push(label);
		}
		
		var barcolor = (value.EventType === 'alert' ? '#f00' : '#0f0');
		output += '<div class="feed-item" id="' + value.Id + '" style="border-left: 5px solid ' + barcolor + ';">';
			output += '<div style="float:left; width="80%">';
				output += '<h3>' + value.EventSubject + '</h3>';
				output += '<p class="feed-item-summary">' + value.EventSummary + '</p>';
			output += '</div>';
			output += '<div class="feed-item-right" style="float: right;">';
				output += '<p class="feed-item-timestamp">' + dt.toString('h:mm TT') + '</p>';
			output += '</div>';
		output += '</div>';
		displayedItemsCount++;
	});
	$('#' + container).append(output);
};

LOG.getDividerLabel = function(dt){
	if( LOG.isToday(dt) ){
		return "Today";
	}
	else if( LOG.isYesterday(dt) ){
		return "Yesterday";
	}
	else{
		return dt.toDateString();
	}
};

LOG.isToday = function(dt){
	return( LOG.today.getFullYear() == dt.getFullYear() &&
			LOG.today.getMonth() == dt.getMonth() &&
			LOG.today.getDate() == dt.getDate() );
};

LOG.isYesterday = function(dt){
	return( LOG.yesterday.getFullYear() == dt.getFullYear() &&
			LOG.yesterday.getMonth() == dt.getMonth() &&
			LOG.yesterday.getDate() == dt.getDate() );
};
		
window.addEventListener('load', function () {
	FastClick.attach(document.body);
}, false);