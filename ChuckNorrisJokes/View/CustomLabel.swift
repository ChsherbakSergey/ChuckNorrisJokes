//
//  CustomLabel.swift
//  ChuckNorrisJokes
//
//  Created by Sergey on 1/20/21.
//

import UIKit

class CustomLabel: UILabel {
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.text = text
        self.font = .boldSystemFont(ofSize: fontSize)
        self.textAlignment = .center
    }
    
}
