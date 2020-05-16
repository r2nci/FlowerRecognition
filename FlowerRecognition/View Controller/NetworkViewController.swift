//
//  NetworkViewController.swift
//  FlowerRecognition
//
//  Created by Ramazan ikinci on 1.05.2020.
//  Copyright © 2020 Ramazan ikinci. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class NetworkViewController: UIViewController {
    
    
    var secondVC =  FlowersDetailViewController()
    var flowerName = ""
    let wikipediURL = "https://tr.wikipedia.org/w/api.php"
    let translateURL = "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20191009T133952Z.0ba3f80453afac3b.f20ad425f69b3f293a7cd9b0df8e561b1d67e5ab&"
    var lang  = ""
    var translateName = ""
    var flowerDescription = ""
    var deneme = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    func yandexRequest(translate:String)->String{
        
        let url = "\(translateURL)text=\(translate)&lang=tr-\(lang)"
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let json : JSON = JSON(response.result.value)
                self.translateName = json["text"][0].stringValue
                print("alamofire ıcı",self.translateName)
                
            }
        }
        print(translateName,"-----------------")
        return translateName
    }
    
    
}
