global class createParentAccDetails{
webservice static string createAccountSecond(string name,string phone,string industry)
{
account obj=new account();
obj.Name=name;
obj.Phone=phone;
obj.Industry=industry;
insert obj;
return 'success';
}
}