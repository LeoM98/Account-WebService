@isTest
public with sharing class LM_AccountWebService_Test {
    
    @TestSetup
    static void makeData(){
        Account acc = new Account();
        acc.Name='Test';
        acc.AccountNumber ='12345';
        acc.Phone = '123456789';
        acc.Website = 'www.acme.com';
        insert acc;
    }

    @isTest
    public static void getAccountTestOk(){

        Account acc = [SELECT Id, Name FROM Account LIMIT 1];
        Test.startTest();
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/api/Account/'+acc.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account acct = LM_AccountWebService.getAccount();
        System.assert(acct != null);
        System.assertEquals(acc.Name, acct.Name);
        Test.stopTest();
    }

    @isTest
    public static void getAccountTestBad(){

        Test.startTest();
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/api/Account/123456';
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account acct = LM_AccountWebService.getAccount();
        System.assert(acct == null);
        Test.stopTest();
    }

    @isTest
    public static void createAccountTest(){
        Test.startTest();
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/api/Account/';
        request.httpMethod = 'POST';
        RestContext.request = request;
        String acctId = LM_AccountWebService.createAccount('Test', '12345678', '1234');
        System.assert(acctId != null);
        Test.stopTest();
    }

    @isTest
    public static void updateAccountTestOk(){

        Account acc = [SELECT Id, Name FROM Account LIMIT 1];
        Test.startTest();
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/api/Account/'+acc.Id;
        request.httpMethod = 'PUT';
        RestContext.request = request;
        String response = LM_AccountWebService.updateAccount('Test', '12345678');
        System.assert(response != null);
        Test.stopTest();
    }

    @isTest
    public static void updateAccountTestBad(){
        Test.startTest();
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/api/Account/13566';
        request.httpMethod = 'PUT';
        RestContext.request = request;
        String response = LM_AccountWebService.updateAccount('Test', '12345678');
        System.assert(response != null);
        Test.stopTest();
    }

    @isTest
    public static void deleteAccountTestOk(){

        Account acc = [SELECT Id, Name FROM Account LIMIT 1];
        Test.startTest();
        //Okay Request
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/api/Account/'+acc.Id;
        request.httpMethod = 'DELETE';
        RestContext.request = request;

        String response = LM_AccountWebService.deleteAccount();
        System.assert(response != null);
        Test.stopTest();
    }

    @isTest
    public static void deleteAccountTestBad(){

        Test.startTest();
        //Okay Request
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/api/Account/34755';
        request.httpMethod = 'DELETE';
        RestContext.request = request;

        String response = LM_AccountWebService.deleteAccount();
        System.assert(response != null);
        Test.stopTest();
    }

    @isTest
    public static void updateAccountPatchTest(){

        Account acc = [SELECT Id, Name FROM Account LIMIT 1];
        Test.startTest();
        //Okay Request
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestUri ='/services/apexrest/api/Account/'+acc.Id;
        RestContext.request = request;
        RestContext.response = response;

        // Prepare the JSON request body
        Map<String, Object> requestBodyMap = new Map<String, Object>{
            'Name' => 'Updated Name',
            'Industry' => 'Updated Industry',
            'BillingCity' => 'Updated City'
        };
        String requestBody = JSON.serialize(requestBodyMap);
        
        // Set the request body
        request.requestBody = Blob.valueOf(requestBody);
        
        Account responseFinal = LM_AccountWebService.updateAccount();
        System.assert(responseFinal != null);
        Test.stopTest();
    }
}