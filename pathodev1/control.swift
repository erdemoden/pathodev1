//
//  control.swift
//  pathodev1
//
//  Created by erdem öden on 28.07.2021.
//

import Foundation

public class kontrol {
    //let Model = modelim();
   // var datam : [modelim] = []
    func requestim(completed: @escaping () ->()){
        let url = URL(string: "http://hp-api.herokuapp.com/api/characters")!
        let session = URLSession.shared
        var alert = false;
        
        
       // var deneme = ["image":[],"name":[],"dateofbirth":[],"actor":[]]
        let task = session.dataTask(with: url) { [self] (data, response, error) in
            if(error != nil){
                alert = true
            }
            else{
                if( data != nil){
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [Dictionary<String,Any>]
                        
                        
                        DispatchQueue.main.async { [self] in
                            
                            for i in 0..<(json.count){
//                            var model = modelim();
//                            model.name = json[i]["name"] as! String
//                            model.actor = json[i]["actor"] as! String
//                            model.dateofbirth = json[i]["dateOfBirth"] as! String
//                            model.image = json[i]["image"] as! String
//                                datam.append(model)
//                            Model.data1["image"]!.append(json[i]["image"] as! String)
//                            Model.data1["actor"]!.append(json[i]["actor"] as! String)
//                            Model.data1["dateofbirth"]!.append(json[i]["dateOfBirth"] as! String)
                            
                           }
                            completed()
                           // print(datam.count)
                           
                            
                        
                            
                        
                            
                        }
                      
                    
                    }
                    catch{
                        print("error")
                    }
                   
                }
               
            }
           
            //print(self.data["name"])
        }
        task.resume()
}
}
