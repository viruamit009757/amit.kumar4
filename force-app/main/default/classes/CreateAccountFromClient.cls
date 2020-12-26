global class CreateAccountFromClient {
    webservice static string CreateAccountFromClient(string Name){
        try{
            Account Acc = new Account();
            acc.Name = Name;
            insert Acc;
            return Acc.id;
        }
        catch(exception ex){
            return 'Error during processing';
        }
    }
}