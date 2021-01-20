//
//  CustomButton.swift
//  ChuckNorrisJokes
//
//  Created by Sergey on 1/20/21.
//

import UIKit

class CustomButton: UIButton {
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, titleColor: UIColor, titleFontSize: CGFloat, backgroundColor: UIColor, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: titleFontSize)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
    }
    
}
