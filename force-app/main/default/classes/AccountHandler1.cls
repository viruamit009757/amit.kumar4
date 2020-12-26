public class AccountHandler1
{
    public static Account insertNewAccount(String sName)
    {
        Account acc= new Account();
        acc.Name = sName;
        try
        {
            insert acc;
            return acc;
        }
        catch(Exception ee)
        {
            return null;
        }
    }
}