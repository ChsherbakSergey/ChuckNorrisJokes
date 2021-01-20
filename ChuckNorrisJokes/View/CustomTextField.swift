//
//  CustomTextField.swift
//  ChuckNorrisJokes
//
//  Created by Sergey on 1/20/21.
//

import UIKit

class CustomTextField: UITextField {
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder: String, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.textAlignment = .center
        self.font = .systemFont(ofSize: fontSize)
    }

}
