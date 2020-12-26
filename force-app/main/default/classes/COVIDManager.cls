public class COVIDManager {

    @AuraEnabled

    public static list<COVID19CountrySummary> getCOVID19Summary(){

        list<COVID19CountrySummary> COVID19Summary = new list<COVID19CountrySummary>();

        String accToken;

        string responseBody;

        string endPoint='https://api.covid19api.com/summary';

        Http h1=new Http();

        HttpRequest req1=new HttpRequest();

        //req1.setHeader('Authorization','Bearer '+accToken);

        req1.setHeader('Content-Type','application/json');

        //req1.setHeader('Accept','application/json');

        req1.setMethod('GET');

        req1.setEndpoint(endPoint);

        HttpResponse hresp1=h1.send(req1);

        system.debug('***hresp1.getBody()'+hresp1.getBody());

        JSONParser parser = JSON.createParser(hresp1.getBody());

         while (parser.nextToken() != null){

             if (parser.getCurrentToken() == JSONToken.START_ARRAY) {

                 while (parser.nextToken() != null) {

                      if (parser.getCurrentToken() == JSONToken.START_OBJECT) {

                          COVID19CountrySummary covid19 = (COVID19CountrySummary)parser.readValueAs(COVID19CountrySummary.class);

                          if(string.isNotBlank(covid19.Country)){

                          COVID19Summary.add(covid19);

                          }



                      }



                 }   

             }



         }

         //lets chcek total for all

         if(COVID19Summary.size()>0){

             string countryName='World Total';

             integer NewConfirmedTotal= 0;

             integer TotalConfirmedTotal= 0;

             integer NewDeathsTotal= 0;

             integer TotalDeathsTotal= 0;

             integer NewRecoveredTotal= 0;

             integer TotalRecoveredTotal= 0;

            for(COVID19CountrySummary eachCountry :COVID19Summary){

                NewConfirmedTotal = NewConfirmedTotal+Integer.valueof(eachCountry.NewConfirmed);       

                TotalConfirmedTotal = TotalConfirmedTotal+Integer.valueof(eachCountry.TotalConfirmed);

                NewDeathsTotal = NewDeathsTotal+Integer.valueof(eachCountry.NewDeaths);

                TotalDeathsTotal = TotalDeathsTotal+Integer.valueof(eachCountry.TotalDeaths);

                NewRecoveredTotal = NewRecoveredTotal+Integer.valueof(eachCountry.NewRecovered);

                TotalRecoveredTotal = TotalRecoveredTotal+Integer.valueof(eachCountry.TotalRecovered);

            }

            COVID19CountrySummary totalSummary = new COVID19CountrySummary();

            totalSummary.Country = countryName;

            totalSummary.CountrySlug = countryName;

            totalSummary.NewConfirmed = string.valueOf(NewConfirmedTotal);

            totalSummary.TotalConfirmed = string.valueOf(TotalConfirmedTotal);

            totalSummary.NewDeaths = string.valueOf(NewDeathsTotal);

            totalSummary.TotalDeaths = string.valueOf(TotalDeathsTotal);

            totalSummary.NewRecovered = string.valueOf(NewRecoveredTotal);

            totalSummary.TotalRecovered = string.valueOf(TotalRecoveredTotal);

            system.debug('***totalSummary'+totalSummary);

            COVID19Summary.add(totalSummary );

         }

        system.debug('***COVID19Summary'+COVID19Summary);

        return COVID19Summary;

    }

   

    public class COVID19CountrySummary{

         @AuraEnabled

      public string Country;

       @AuraEnabled

      public string CountrySlug;

       @AuraEnabled

      public string NewConfirmed;

       @AuraEnabled

      public string TotalConfirmed;

       @AuraEnabled

      public string NewDeaths;

       @AuraEnabled

      public string TotalDeaths;

       @AuraEnabled

      public string NewRecovered;

       @AuraEnabled

      public string TotalRecovered;

    }

   



}