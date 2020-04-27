//
//  Network.swift
//  FlowerRecognition
//
//  Created by Ramazan ikinci on 16.04.2020.
//  Copyright © 2020 Ramazan ikinci. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Network {
    
    var flowerName = ""
    let wikipediURL = "https://tr.wikipedia.org/w/api.php"
    let translateURL = "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20191009T133952Z.0ba3f80453afac3b.f20ad425f69b3f293a7cd9b0df8e561b1d67e5ab&"
    var lang  = ""
    var translateName = String()
    var flowerDescription = ""
    var parsing = jsonParsing()
    
    func yandexRequest()->String{
        
        let url = "\(translateURL)text=\(flowerName)&lang=tr-\(lang)"
        
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let json : JSON = JSON(response.result.value)
                self.translateName = self.parsing.jsonTranslateParsing(json: json)
                
            }
            
            
        }
        print(translateName,"-----------------")
        return translateName
    }
    
    func wikipediRequest(flowername:String)->String{
        let parameters : [String:String] = ["format" : "json", "action" : "query", "prop" : "extracts|pageimages", "exintro" : "", "explaintext" : "", "titles" : flowername, "redirects" : "1", "pithumbsize" : "500", "indexpageids" : ""]
        
        Alamofire.request(wikipediURL, method: .get,parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                let json : JSON = JSON(response.result.value)
                self.flowerDescription = self.parsing.wikipediParsing(json: json)
            }
        }
        return flowerDescription
    }
    
}
