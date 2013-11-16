global with sharing class LogalyticsEventDetailController {
	public String Token 	{get; set;}
	public String EventId 	{get; set;}
	public String EventJSON {get; set;}
	
	public LogalyticsEventDetailController(){
		Token = ApexPages.currentPage().getParameters().get('token');
		EventId = ApexPages.currentPage().getParameters().get('id');
		if(EventId != null && EventId != ''){
			EventJSON = getEventDetails();
		}		
	}
	
	@RemoteAction
	global static String freezeUser(String userId, String subject, String description) {		
		UserLogin ulRecord = [SELECT Id, UserId, IsFrozen, IsPasswordLocked FROM UserLogin WHERE UserId=:userId];
		ulRecord.IsFrozen = true;
		update ulRecord;
        
		LogalyticsEventDetailController.createCase(subject, description);
		return 'ok';
	}
    
	@RemoteAction
	global static String resetPassword(String userId) {
		ResetPasswordResult result = System.resetPassword(userId, true);        
		return 'ok';
	}
	
	@RemoteAction
	global static String createTask(String subject, String description) {
		Task t 			= new Task();
		t.OwnerId 		= UserInfo.getUserId();
		t.Priority		= 'High';
		t.Subject		= subject;
		t.Description	= description;
		t.Status		= 'Not Started';
		insert t;
		
		return 'ok';
	}
    
	@RemoteAction
	global static String createCase(String subject, String description) {
		Case newCase 		= new Case();
		newCase.OwnerId 	= UserInfo.getUserId();
		newCase.Origin		= 'Logalytics';
		newCase.Priority 	= 'High';
		newCase.Subject		= subject;
		newCase.Description = description;
        insert newCase;
        
        LogalyticsEventDetailController.createChatterPost(newCase.Id, subject, description);
        
        return 'ok';
    }
    
    @RemoteAction
	global static String createUnitTestCase(String subject, String description) {
		//User u = [SELECT Id, LastModifiedById from ApexClass WHERE Id=:classId];
		
		Case newCase 		= new Case();
		newCase.OwnerId 	= UserInfo.getUserId();
		newCase.Origin		= 'Logalytics';
		newCase.Priority 	= 'High';
		newCase.Subject		= subject;
		newCase.Description = description;
        insert newCase;
        
        LogalyticsEventDetailController.createChatterPost(newCase.Id, subject, description);
        
        return 'ok';
    }
	
	public String OrganizationID{
		get{
			return UserInfo.getOrganizationId();
		}
	}
	
	public String getEventDetails(){
		HttpRequest req = new HttpRequest();
		HttpResponse res = new HttpResponse();
		Http http = new Http();
		req.setMethod( 'GET' );
		req.setEndpoint('https://logalytics.herokuapp.com/api/events/' + EventId);		
		req.setHeader('Accept', 'application/json');
		req.setHeader('x-api-version', '1');
		req.setHeader('x-subscriber-id', OrganizationID);
		req.setHeader('x-security-token', Token);
		
		try {
			res = http.send(req);
			System.debug('Callout response: ' + res.toString() + ' body: ' + res.getBody());
			return res.getBody();
		} catch(System.CalloutException e) {
			System.debug('Callout error: '+ e);
			System.debug(res.toString());
			return e.getMessage();
		}
	}
	
	public static void createChatterPost(Id pid, String title, String body){
		String communityId = null;
		ConnectApi.FeedType feedType = ConnectApi.FeedType.Record;
		
		ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
		ConnectApi.MessageBodyInput messageInput = new ConnectApi.MessageBodyInput();
		ConnectApi.TextSegmentInput textSegment;		
		
		messageInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
		
		textSegment = new ConnectApi.TextSegmentInput();
		textSegment.text = title + ' \n' + body + '\ncc: All Sys Admins: ';
		messageInput.messageSegments.add(textSegment);
				
		for(User u : LogalyticsEventDetailController.getSysAdminUsers()){
			ConnectApi.MentionSegmentInput mentionSegment = new ConnectApi.MentionSegmentInput();
			mentionSegment.id = u.Id;
			messageInput.messageSegments.add(mentionSegment);
		}
		
		input.body = messageInput;
		
		ConnectApi.FeedItem feedItemRep = ConnectApi.ChatterFeeds.postFeedItem(communityId, feedType, pid, input, null);
	}
	
	public static List<User> getSysAdminUsers(){
		String profileName = 'System Administrator';
		String profileId = [SELECT Id FROM Profile WHERE Name=:profileName LIMIT 1].Id;
		return [SELECT Id, Name, FirstName, LastName FROM User WHERE ProfileId=:profileId];
	}
}