global class sendAcountToExternalSystem
{
set<id> id1=new set<id>();

public void sendAccount(string name,string phone,string industry,id id1)
{

senddatatosalesforce2(id1);

}

@future (callout=true)
public static void senddatatosalesforce2(id id2)
{
account accdata=[select name,phone,industry from account where id =:id2];
string name1;
string phone1;
string industry1;

name1=accdata.name;
phone1=accdata.phone;
industry1=accdata.industry;

partnerSoapSforceCom.Soap mypartnersoap=new partnerSoapSforceCom.Soap();  // Main class:partnerSoapSforceCom  Sublcass:Soap which contains login method

partnerSoapSforceCom.LoginResult  partnerloginresult=mypartnersoap.login('vinayak.s@quintiles.com','Iqvia@1235fzDJTEXX15oXwZmu1fdaJPt');  
// Return type of login method is "partnerSoapSforceCom.LoginResult"

system.debug('Generated session id is'+partnerloginresult.sessionId);  // Generating session id 

string sessionidfetch=partnerloginresult.sessionId; // Storing session id

soapSforceComSchemasClassGetparenta.SessionHeader_element webservicesessionheader=new soapSforceComSchemasClassGetparenta.SessionHeader_element();

webservicesessionheader.sessionId=sessionidfetch;  // Passing session id to session header element

soapSforceComSchemasClassGetparenta.getParentAccDetails objA=new soapSforceComSchemasClassGetparenta.getParentAccDetails();
objA.SessionHeader=webservicesessionheader;  // Passing session header
string status=objA.createAccountSecond(name1,phone1,industry1);
system.debug('status of task is'+status );


}


}