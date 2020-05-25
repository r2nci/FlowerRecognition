//
//  FlowersDetailViewController.swift
//  FlowerRecognition
//
//  Created by Ramazan ikinci on 15.04.2020.
//  Copyright © 2020 Ramazan ikinci. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class FlowersDetailViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    
    // MARK: VAR & LET
    
    var deneme : String?
    var translateText = ""
    var translateLang = ""
    var flowerName  = "s"
    var pickerData: [String] = [String]()
    var langShort: [String] = [String]()
    var network = Network()
    var parsing = jsonParsing()
    var selectedLang  = ""
    var acıklama = ""
    let wikipediURL = "https://tr.wikipedia.org/w/api.php"
    let translateURL = "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20191009T133952Z.0ba3f80453afac3b.f20ad425f69b3f293a7cd9b0df8e561b1d67e5ab&"
    var translateName = ""
    
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var detailTitleLabel: UILabel!
    
    @IBOutlet weak var flowerDetailText: UITextView!
    
    @IBOutlet weak var translatePicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.translatePicker.delegate = self
        self.translatePicker.dataSource = self
        detailTitleLabel.text = flowerName
        flowerDetailText.text = acıklama
        pickerData = ["Almanca","Arapça","Azerice","Bulgarca","Çekçe","Çince","Fransızca","İngilizce","İtalyanca","Japonca","Norveççe","Türkçe","Rusya" ]
        langShort = ["de","ar","az","bg","cs","zh","fr","en","it","ja","no","tr","ru"]
        networkRequest(flowerName: flowerName)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ("\(pickerData[row])"+"(\(langShort[row]))")
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLang = langShort[row]
        
    }
    
    
    @IBAction func translateButton(_ sender: UIButton) {
        
        network.lang = selectedLang
        network.flowerName = flowerName
        tranlateLang(wordsa: flowerName)
        networkRequest(flowerName: flowerName)
        
        
    }
    
    
    
    func networkRequest(flowerName:String){
        let parameters : [String:String] = ["format" : "json", "action" : "query", "prop" : "extracts|pageimages", "exintro" : "", "explaintext" : "", "titles" : flowerName, "redirects" : "1", "pithumbsize" : "500", "indexpageids" : ""]
        
        Alamofire.request(wikipediURL, method: .get,parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                
                let json : JSON = JSON(response.result.value)
                let pageid = json["query"]["pageids"][0].stringValue
                self.translateText = json["query"]["pages"][pageid]["extract"].stringValue
                self.flowerDetailText.text = self.translateText
                self.translateWikipedi(info: self.translateText)
                print(self.translateText,"--------")
                
            }
            
            
            
        }
    }
    func tranlateLang(wordsa:String){
        
        let url = "\(translateURL)text=\(wordsa)&lang=tr-\(selectedLang)"
        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.result.isSuccess {
                let json : JSON = JSON(response.result.value)
                self.translateName = json["text"][0].stringValue
                self.detailTitleLabel.text = self.translateName
               
            }
            
            
        }
        
        
    }

    
        func translateWikipedi(info:String){
            print(selectedLang,"---------------")
            if selectedLang == ""
            {
                selectedLang = "tr"
            }
            
            var key = "trnsl.1.1.20191009T133952Z.0ba3f80453afac3b.f20ad425f69b3f293a7cd9b0df8e561b1d67e5ab"
            var deneme = "tr-\(selectedLang)"
            guard var components = URLComponents(string: translateURL) else { return }
            components.queryItems = [
                URLQueryItem(name: "key", value: key),
                URLQueryItem(name: "text", value: info),
                URLQueryItem(name: "lang", value: deneme)
            ]
            
            
            
            
            let url = "\(translateURL)text=\(info)&lang=tr-\(selectedLang)"
            Alamofire.request(components, method: .get).responseJSON { (response) in
                if response.result.isSuccess {
                    let json : JSON = JSON(response.result.value)
                    self.translateName = json["text"][0].stringValue
                    self.flowerDetailText.text = self.translateName
                    print(self.translateName,"234567890*")
                }
            }
        }
        
        
}
