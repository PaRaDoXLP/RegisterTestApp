//
//  RTACustomTextField.swift
//  RegistrationTestApp
//
//  Created by Вячеслав on 22/03/2020.
//  Copyright © 2020 PaRaDoX. All rights reserved.
//

import UIKit

enum FieldType: String {
    case Email = "email"
    case Password = "password"
    case Name = "name"
}

class RTACustomTextField: RTAViewFromXib, UITextFieldDelegate {
     @IBOutlet var placeholder: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var indicatorIcon: UIImageView!
    @IBOutlet var placeholderTopConstraint: NSLayoutConstraint!
    @IBOutlet var placeholderCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var nextResponderField: RTACustomTextField?
    
    var type = FieldType.Email
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'type' instead.")
    @IBInspectable var typeName: String? {
        willSet {
            if let newFieldType = FieldType(rawValue: newValue?.lowercased() ?? "") {
                type = newFieldType
            }
        }
        didSet {
            switch type {
            case .Email:
                self.placeholder.text = "e-mail"
                self.textField.keyboardType = .emailAddress
            case .Password:
                self.placeholder.text = "Пароль"
                self.textField.isSecureTextEntry = true
            case .Name:
                self.placeholder.text = "Имя"
            }
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    // MARK: - Setup
    func setup() {
        self.textField.delegate = self
        self.textField.addTarget(self, action: #selector(actionKeyboardButtonTapped(_:)), for: .editingDidEndOnExit)
    }
    
    func text() -> String {
        return self.textField.text!
    }
    
    
    // MARK: - Actions
    @IBAction func didTapTextField(_ sender: Any) {
        self.activateField()
    }
    
    @objc func actionKeyboardButtonTapped(_ sender: UITextField?) {
        if nextResponderField != nil {
            _ = self.nextResponderField!.becomeFirstResponder()
            self.deActivateField()
        } else {
            _ = self.resignFirstResponder()
        }
    }
    
    func activateField() {
        if self.textField.isHidden {
            self.textField.isHidden = false
            self.placeholderTopConstraint.isActive = true
            self.placeholderCenterXConstraint.isActive = false
            self.textField.becomeFirstResponder()
        }
    }
    
    func deActivateField() {
        if (self.textField.text!.isEmpty) {
            self.textField.isHidden = true
            self.placeholderTopConstraint.isActive = false
            self.placeholderCenterXConstraint.isActive = true
            self.textField.resignFirstResponder()
            
        } else {
            if (self.type == .Email) {
                self.indicatorIcon.image = UIImage.init(imageLiteralResourceName: self.textField.text!.isValidEmailAddress() ? "rightIcon" : "wrongIcon")
                self.textField.textColor = self.textField.text!.isValidEmailAddress() ? UIColor.label : UIColor(red: 0.953, green: 0.443, blue: 0.318, alpha: 1)
                self.indicatorIcon.isHidden = false
                self.textField.resignFirstResponder()
            }
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        self.activateField()
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        self.deActivateField()
        return super.resignFirstResponder()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
        self.deActivateField()
    }
}
