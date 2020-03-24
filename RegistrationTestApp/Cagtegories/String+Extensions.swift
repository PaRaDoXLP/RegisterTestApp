//
//  String+Extensions.swift
//  RegistrationTestApp
//
//  Created by Вячеслав on 23/03/2020.
//  Copyright © 2020 PaRaDoX. All rights reserved.
//

import UIKit

extension String {
    
    func isValidEmailAddress() -> Bool {
        let emailRegexString =  "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegexString)
        return emailTest.evaluate(with: self)
    }
}
