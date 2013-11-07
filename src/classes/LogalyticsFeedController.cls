public with sharing class LogalyticsFeedController {

	public String SessionID{
		get{
			return UserInfo.getSessionId();
		}
	}
	
	public String OrganizationID{
		get{
			return UserInfo.getOrganizationId();
		}
	}
	
	public String UserID{
		get{
			return UserInfo.getUserId();
		}
	}
	
	public String ServerURL{
		get{
			return URL.getSalesforceBaseUrl().toExternalForm() + '/services/Soap/u/29.0/' + UserInfo.getOrganizationId();
		}
	}
	
	public String FeedData{
		get{
			// make a callout here to api
			String authResponse = this.doAuth();
			return getFeed();
		}
	}
	
	public String doAuth(){
		HttpRequest req = new HttpRequest();
		HttpResponse res = new HttpResponse();
		Http http = new Http();
		String params = '?org_id=' + OrganizationId + 
					'&user_id=' + UserId + 
					'&session_id=' + SessionId + 
					'&url=' + ServerURL;
		req.setMethod( 'GET' );
		req.setEndpoint('https://logalytics.herokuapp.com/salesforce/touch' + params);
		req.setHeader('Accept', 'application/json');
	 	
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
	
	public String getFeed(){
		HttpRequest req = new HttpRequest();
		HttpResponse res = new HttpResponse();
		Http http = new Http();
		req.setMethod( 'GET' );
		req.setEndpoint('https://logalytics.herokuapp.com/api/feed');		
		req.setHeader('Accept', 'application/json');
		req.setHeader('x-api-version', '1');
		req.setHeader('x-subscriber-id', OrganizationID);
		req.setHeader('x-security-token', SessionID);
		
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