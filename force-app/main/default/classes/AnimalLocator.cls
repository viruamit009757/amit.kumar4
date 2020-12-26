public class AnimalLocator {

    public static String getAnimalNameById(Integer idVal) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+idVal);
        
        String resultValue =NULL; 
        List<Object> animals;
        
        request.setMethod('GET');
        HttpResponse response = new HttpResponse();
        response = http.send(request);
        // If the request is successful, parse the JSON response.

        if (response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            animals = (List<Object>) results.get('animals');
            System.debug(animals);

           if (animals.size() > 0 && animals != NULL && idVal < animals.size()) {
                  resultValue = (String) animals.get(idVal);
           }         
        }
        return resultValue;  
    }
}