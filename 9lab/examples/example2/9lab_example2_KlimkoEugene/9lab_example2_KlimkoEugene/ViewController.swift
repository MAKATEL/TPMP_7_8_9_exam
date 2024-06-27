//
//  ViewController.swift
//  9lab_example2_KlimkoEugene
//
//  Created by MacOSExi on 17.05.24.
//  Copyright © 2024 MacOSExi. All rights reserved.
//



import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         RegisterView.isHidden=true;
        
        if((UserDefaults.standard.object(forKey: "login")) != nil){
            performSegue(withIdentifier: "closeZone", sender: self);
        }
    }
    @IBAction func LoginField(_ sender: Any) {
    }
    
    @IBAction func StetSwitch(_ sender: Any) {
        if(LoginRegisterSwitch.selectedSegmentIndex==1){
            RegisterView.isHidden=false;
        }
        else{
            RegisterView.isHidden=true;
        }
        
    }
    @IBOutlet weak var LoginInput: UITextField!
    @IBAction func RegConfButton(_ sender: Any) {
        UserDefaults.standard.set(LoginRegistration.text!,forKey: "login")
        UserDefaults.standard.set(PassRegistration.text!,forKey: "password")
        performSegue(withIdentifier: "closeZone", sender: self);
    }
    @IBOutlet weak var RegisterView: UIView!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var LoginRegistration: UITextField!
    
    @IBOutlet weak var PassRegistration: UITextField!
    @IBOutlet weak var EmailReg: UITextField!
    @IBOutlet weak var RepeatPassRegistration: UITextField!
    @IBOutlet weak var LoginRegisterSwitch: UISegmentedControl!
}



