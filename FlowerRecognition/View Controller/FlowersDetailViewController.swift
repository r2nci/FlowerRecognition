//
//  FlowersDetailViewController.swift
//  FlowerRecognition
//
//  Created by Ramazan ikinci on 15.04.2020.
//  Copyright © 2020 Ramazan ikinci. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var detailTitleLabel: UILabel!
    
    @IBOutlet weak var flowerDetailText: UITextView!
    
    @IBOutlet weak var translatePicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.translatePicker.delegate = self
        self.translatePicker.dataSource = self
        doldur()
        detailTitleLabel.text = flowerName
        flowerDetailText.text = acıklama
        pickerData = ["Almanca","Arapça","Azerice","Bulgarca","Çekçe","Çince","Fransızca","İngilizce","İtalyanca","Japonca","Norveççe","Rusya" ]
        langShort = ["de","ar","az","bg","cs","zh","fr","en","it","ja","no","ru"]
        
        
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
    
    func doldur (){
        acıklama = network.wikipediRequest(flowername: flowerName)
        print(acıklama,"----")
    }
    
    @IBAction func translateButton(_ sender: UIButton) {
        
        network.lang = selectedLang
        network.flowerName = flowerName
        detailTitleLabel.text = network.yandexRequest()
        flowerDetailText.text = network.wikipediRequest(flowername: flowerName)
    }
    
    
    
}
