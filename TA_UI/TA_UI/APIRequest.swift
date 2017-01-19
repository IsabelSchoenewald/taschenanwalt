//
//  APIRequest.swift
//  apiai-request-model
//
//  Created by Sebastian Wagner on 10.12.16.
//  Copyright © 2016 Sebastian Wagner. All rights reserved.
//

import Foundation
import SwiftyJSON

class APIRequest
{
    //let urlEndpoint: String = "http://taschenanwalt.pythonanywhere.com/talk/?msg="
    let urlEnvarint: String = "http://taschenanwalt.pythonanywhere.com/json/?msg="
    //var idHelper = 0;
    func sendRequest(request: String, callback: @escaping (String) -> ())
    {
        let escapedRequest = request.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let url = URL(string: urlEnvarint + escapedRequest!) //create a url out of the endpoint
        print(request);
        print("Url endpoint + request: " + urlEnvarint + escapedRequest!);
        let urlRequest = URLRequest(url: url!) //make a request out of the URL
        let session = URLSession.shared
        //var result = ""
        //perform data request
        let task = session.dataTask(with: urlRequest) { data, response, error in
            // do stuff with response, data & error here
            //var d = data
            //var r = response
            //var e = error
            //result = (data?.base64EncodedString())!
            /*do {
                //let jsonDictionary = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments) as! [String: Any] //cast to JSON object
                //let fulfillment = jsonDictionary[0]["fulfillment"] as? [String: Any]//get the fulfillment field
                //let speech = fulfillment["speech"] as! String //extract the String response of chatbot
                result = speech
            }
            catch
            {
                //do something
            } */
            //print("result here !")
            //result = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String
            
            if let returnedData = data
            {
                print("Data has been returned.")
                let json = JSON(data: returnedData)
                print(json)
                if let done = json["result"]["parameters"]["done-status"].string{
                    if(done == "Done" ){
                        //var items = [[String:AnyObject]]()
                        //var allContent = [Faelle]();
                        let datum = self.aktuellesDatum();
                        let vorname = json["result"]["parameters"]["name"].string!
                        let wohnort = json["result"]["parameters"]["city"].string!
                        
                        let fall = Faelle(vorname: vorname , wohnort: wohnort, identi: idHelper, datum: datum);
                        print(fall);
                        /* let daten = try NSData(data);
                         let jsonDictionary = try JSONSerialization.jsonObject(with: daten as Data, options: .allowFragments) as! NSDictionary
                         //items.append(jsonDictionary as! [String : AnyObject]);
                         print(jsonDictionary);*/
                        
                        self.saveInJson(autounfall: fall);
                        
                        
                        //if arrayResult = json["result"]["parameters"].array{
                        //  print(arrayResult);
                        //}
                        //print(done);
                    }
                }

                if let result = json["result"]["fulfillment"]["speech"].string {
                    //Now you got your value
                    print("We've got our value.")
                    print(result)
                    callback(result) //The result will be accessible via the variable resultResponse
                }
                           }
            
            //print(result)
            //print("Response here!")
            //print(r)
            //print("Error here!")
            //print(e)
            
        }
        task.resume()
    }
    func saveInJson(autounfall: Faelle){
    
        //let savedData = ["Something": 1]
        
        /*let jsonObject: [String: AnyObject] = [
            "type_id": 1 as AnyObject,
            "model_id": 1 as AnyObject,
            "transfer": [
                "startDate": "10/04/2015 12:45",
                "endDate": "10/04/2015 16:00"
            ],
            "custom": savedData
        ]
        
        let valid = JSONSerialization.isValidJSONObject(jsonObject)*/
       
       
        let x : Int = autounfall.identi;
        let id = String(x);
       
        //let jsonDict = "[ {"person": {"name":"Dani","age":"24"}}, {"person": {"name":"ray","age":"70"}} ]"
        let jsonDict = ["ID" : id, "Vorname" : autounfall.vorname , "Wohnort" : autounfall.wohnort, "Datum" : autounfall.datum];
        do {
           // let json = JSONSerializer.toJson(autounfall)
            //let dict = try JSONSerializer.toDictionary(json)
            //Assert
            //let expected = "{\"fur\": true, \"weight\": 2.5, \"age\": 2, \"name\": \"An animal\", \"id\": 182371823}"
            try jsonFile.saveFile(dataForJson: jsonDict as NSDictionary)
        }
        catch {
            print(error)
        }
        
        
        //Print out whether the file exists.
        print("JSON file exists: \(jsonFile.fileExists)")
        do{
        try idHelper = jsonFile.getId();
        }
        catch{
        print(error);
        }
        
        }
        //Try to save the file. If there are any errors, print them out.
  
    func aktuellesDatum() -> String {
        //NSDate*today = [NSDate date];
       
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy hh:mm"
        let result = formatter.string(from: date)




      /*  var currentDate = NSDate()
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        var date = dateFormatter.date(from: currentDate);
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
   
        NSString *currentTime = [dateFormatter stringFromDate:today];
        print(@"Die Uhrzeit: %@",currentTime);
    
        [dateFormatter setDateFormat:@"dd.MM.yyyy"];
        NSString *currentDate = [dateFormatter stringFromDate:today];*/
        print(result)
        return result;
    
    }
    
    }

