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
	global static String freezeUser(String userId) {		
        UserLogin ulRecord = [SELECT Id, UserId, IsFrozen, IsPasswordLocked FROM UserLogin WHERE UserId=:userId];
        ulRecord.IsFrozen = true;
        update ulRecord;
        return 'ok';
    }
    
    @RemoteAction
	global static String resetPassword(String userId) {
		ResetPasswordResult result = System.resetPassword(userId, true);        
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
	
	public List<User> getSysAdminUsers(){
		String profileName = 'System Administrator';
		String profileId = [SELECT Id FROM Profile WHERE Name=:profileName LIMIT 1].Id;
		return [SELECT Id, Name FROM User WHERE ProfileId=:profileId];
	}
	
	public CollaborationGroup getLogalyticsGroup(){
		String groupName = 'Logalytics Alerts';
		return [SELECT Id, Name FROM CollaborationGroup WHERE Name=:groupName LIMIT 1]; 
	}
}