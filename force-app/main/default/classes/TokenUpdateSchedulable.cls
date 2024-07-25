global class TokenUpdateSchedulable implements Schedulable {
    global void execute(SchedulableContext SC){
        List<Account> tokenRecord = [SELECT Id, Name, Description FROM Account Where Name = 'TOKEN'];
        if(tokenRecord != null && tokenRecord.size() > 0){
            String userName = 'ITSquad_X';
            String password = 'testPWD_X';
            String key = 'U2FsdGVkX1/ILYHKcJAo6CPUjfHOw7N3luMp5ykTJ1rXCy14gRBXqvMLYKBktFIX_X';
            String endPoint = 'https://crm.dssimage.com:8008/api/auth_X';
            String requestBody = '{"UserName":"' + username + '","Password":"' + password + '","Key":"' + key + '"}';
            Http request = new Http();
            HttpRequest requestData = new HttpRequest();
            requestData.setBody(requestBody);
            requestData.setMethod('POST');
            requestData.setEndpoint(endPoint);
            requestData.setHeader('Content-Type', 'application/json');
            HttpResponse response = request.send(requestData);
            if(response.getStatusCode() == 200){
                Map<String,Object> responseBody = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
                tokenRecord[0].Description = (String)responseBody.get('token');
                update tokenRecord;
            }
        }
    }
}