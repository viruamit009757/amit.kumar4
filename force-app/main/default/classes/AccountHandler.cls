public class AccountHandler {
    public static void insertAccount(Integer numAccts){
        Integer n = 1;
        //create a list to add our accounts
        List<Account> addAccounts = new List<Account>();
        
        while(n <= numAccts){
            //display the current counter value
            System.debug('Counter Value before Incrementing ' + n);
            
            //create a new account
            Account Acc1 = new Account();
            Acc1.Name = 'Acme Inc ' + n;
            Acc1.AccountNumber = 'A000' + n;
            addAccounts.add(Acc1);
            
            System.debug(addAccounts);
            
            //increment the counter
            n = n + 1;
            System.debug('Counter Value after incrementing ' + n);
        }
        
        System.debug('Size of Account List: ' + addAccounts.size() );
        System.debug('Elements in Account List: ' + addAccounts);
        
        //insert all of the accounts in the list
        insert addAccounts;
    }
}