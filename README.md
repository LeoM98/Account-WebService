# Salesforce Account WebService
The main idea is show you how to build a Web Service using apex. It's a task for trainee, so, in this case you will see a simple webservice with the following methods:
- HttpGET
- HttpPOST
- HttpPATCH
- HttpPUT
- HttpDELETE

You will have access to the classes and their test classes with a cover of the 100%. I hope that you could enjoy it.

## How Do We Test Our WebService?

We'll test this webservice using Workbench of Salesforce with the following url reserved in the rest explorer /services/apexrest/api/Account/

## Http Methods Examples

- HttpGET: ![image](https://github.com/LeoM98/Account-WebService/assets/54753222/1c656c27-405b-4fe4-a291-d5e1319875f4). As you can see, you need to pass a parameter (recordId) into the uri to get the specific record.
- HttpPOST: ![image](https://github.com/LeoM98/Account-WebService/assets/54753222/aecb34dc-9b53-455d-99e7-875954c818b9). For POST method you dont need pass a parameter, you need to build an specific body and send the request.
- HttpPATCH: ![image](https://github.com/LeoM98/Account-WebService/assets/54753222/2828433b-5675-4466-b38e-0bfee28a9a55). PATCH method allow you modify an especific variable or field in your record.
- HttpPUT: ![image](https://github.com/LeoM98/Account-WebService/assets/54753222/c2d563d2-f030-4513-a06a-bac0296eb1d6). PUT allow you update the entire record with the parameter that you are passing to the body.
- HttpDELETE: ![image](https://github.com/LeoM98/Account-WebService/assets/54753222/04f77b60-93ec-417f-b525-91f33f84c09c). Finally, DELETE method allow you to delete the specific record.
