//
//  RTAViewFromXib.swift
//  RegistrationTestApp
//
//  Created by Вячеслав on 22/03/2020.
//  Copyright © 2020 PaRaDoX. All rights reserved.
//

import UIKit

class RTAViewFromXib: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.xibSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        self.xibSetup()
    }
    
    func xibSetup() {
        let view: UIView = self.loadViewFromNib()!
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
    #if !TARGET_INTERFACE_BUILDER
        let bundle = Bundle.main
    #else
        let bundle = Bundle(for: type(of: self))
    #endif
        
        let nib = UINib(nibName: NSStringFromClass(type(of: self).self).components(separatedBy: ".").last!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView

        return view
    }

}
