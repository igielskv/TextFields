//
//  ViewController.swift
//  TextFields
//
//  Created by Manoli on 24/04/2020.
//  Copyright © 2020 macForce. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var upperTextField: UITextField!
    @IBOutlet weak var lowerTextField: UITextField!
    
    var callCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        upperTextField.delegate = self
        lowerTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillChangeFrame(_ notification: NSNotification) {
        callCounter += 1
        print("keyboardWillChangeFrame is being called \(callCounter) times.")
    }
}

