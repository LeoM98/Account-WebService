@RestResource(urlMapping='/api/Account/*')
global with sharing class LM_AccountWebService {
    
    @HttpGet
    global static Account getAccount() {

        //Get an specific account according the provided Id
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

        List<Account> result = [SELECT Id, AccountNumber, Name, Phone, Website FROM Account WHERE Id = :accountId ];
        if (!result.isEmpty()) {
            return result.get(0);
        }else{
            return null;
        }
    }

    /* @HttpGet
    global static List<Account> getListAccounts() {

        List<Account> result = [SELECT Id, AccountNumber, Name, Phone, Website FROM Account LIMIT 50];
        if (!result.isEmpty()) {
            return result;
        }else{
            return new List<Account>(); 
        }
    } */

    @HttpPost
    global static String createAccount(String name, String phone, String accountNumber ) {

        Account acc = new Account();
        acc.name = name;
        acc.phone = phone;
        acc.AccountNumber = accountNumber ;
        insert acc;
        
        return acc.id;
    }

    
    @HttpPut
    global static String updateAccount(String name, String accountNumber) {
        String recordId = RestContext.request.requestURI.substring(RestContext.request.requestURI.lastIndexOf('/') + 1);

        // Perform the update operation using the recordId and updateData
        // For demonstration purposes, let's assume we're updating a custom object named MyCustomObject__c
        try {
            Account accountToUpdate = new Account(
                Id = recordId,
                Name = name,  // Update with the appropriate field name
                AccountNumber = accountNumber
                // Add more fields to update
            );
            
            update accountToUpdate;
            
            return 'Record with Id ' + recordId + ' updated successfully.';
        } catch (Exception e) {
            return 'Error updating record: ' + e.getMessage();
        }
    }

    @HttpDelete
    global static String deleteAccount() {

        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

        try {
            Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountId ];
            delete result;
            return 'Record with Id ' + accountId + ' deleted successfully.';
        } catch (Exception e) {
            return 'Error deleting record: ' + e.getMessage();
        }
    }

    @HTTPPatch
    global static Account updateAccount() {
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        // Getting the request body from the request
        String requestBody = req.requestBody.toString();
        // Creating an instance of Account object
        Account account;
        // Checking if the account id obtained from the URL is not empty
        if(String.isNotEmpty(accountId)) {
            // Deserializing the JSON response body and assigning it to the instance of Account object
            account = (Account) JSON.deserialize(requestBody, Account.class);
            // Assigning the Account id
            account.Id = accountId;
            // Updating acccount
            update account;
        }
        // Returning the acccount in the response
        return account;
    }
}