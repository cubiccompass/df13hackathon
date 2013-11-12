public with sharing class LogalyticsEventDetailController {
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
}