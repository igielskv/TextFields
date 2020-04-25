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
    
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
    
    var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        upperTextField.delegate = self
        lowerTextField.delegate = self
        
        registerForKeyboardNotifications()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeTextField = nil
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        let keyboardSpacing: CGFloat = 8.0 // Standard value for spacing between keyboard and textfield
        
        let safeArea = view.safeAreaLayoutGuide.layoutFrame
        
        guard let userInfo = notification.userInfo,
            let keyboardFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        
        guard let activeTextFieldFrame = activeTextField?.frame else { return }
        
        let positionShift = activeTextFieldFrame.origin.y + activeTextFieldFrame.height + safeArea.origin.y - keyboardFrame.origin.y + keyboardSpacing
        
        print("Move by \(positionShift) pixels")
        
        if positionShift > 0 {
            containerViewBottomConstraint.constant = positionShift
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        containerViewBottomConstraint.constant = 0
    }
}

