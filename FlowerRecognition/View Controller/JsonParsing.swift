//
//  JsonParsing.swift
//  FlowerRecognition
//
//  Created by Ramazan ikinci on 19.04.2020.
//  Copyright © 2020 Ramazan ikinci. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class jsonParsing{
    
    func jsonTranslateParsing(json:JSON)->String{
        let isim = json["text"][0].stringValue
        return isim
        
    }
    
    func wikipediParsing(json:JSON)->String {
        let pageid = json["query"]["pageids"][0].stringValue
        let flowerDescription = json["query"]["pages"][pageid]["extract"].stringValue
        return flowerDescription
    }
}
