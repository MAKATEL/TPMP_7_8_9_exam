//
//  ViewController.swift
//  9lab_example1_KlimkoEugene
//
//  Created by MacOSExi on 17.05.24.
//  Copyright © 2024 MacOSExi. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    let myItemKey = "myItem"
    var myItemValue: String? = nil
    
    @IBOutlet weak var txtValue: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBtnClick(_ sender: Any) {
        self.saveData(value: txtValue.text!)
    }
    func loadData() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths[0] as! String
        let path = documentDirectory.appending("mayData.plist")
        let fileManager = FileManager.default
        if (!fileManager.fileExists(atPath: path)){
            if let bundlePath = Bundle.main.path(forResource: "myData", ofType: "plist"){
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                print("Bundle file myData.plist is -> \(String(describing: result?.description))")
                do{
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                        
                }catch{
                        print("Copy falilure.")
                }
            }else{
                print("File myData.plist not found")
            }
        }else{
            print("file myData.plist already exist at path")
        }
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        print("Load myData.plist is ->\(String(describing: resultDictionary?.description))")
        
        let myDict = NSDictionary(contentsOfFile: path)
        if let dict = myDict{
            myItemValue = dict.object(forKey: myItemKey) as! String?
            txtValue.text = myItemValue
        }else{
            print("Load failure.")
        }
    }
    
    func saveData(value: String){
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths.object(at: 0) as! String
        
        let path = documentDirectory.appending("myData.plist")
        let dict: NSMutableDictionary = [:]
        dict.setObject(value, forKey: myItemKey as NSCopying)
        dict.write(toFile:path, atomically: false)
        print("saved")
    }

}


