//
//  JokeCell.swift
//  ChuckNorrisJokes
//
//  Created by Sergey on 1/20/21.
//

import UIKit

class JokeCell: UITableViewCell {
    
    static let identifier = "JokeCell"
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setInitialUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    private func setInitialUI() {
        textLabel?.numberOfLines = 0
        selectionStyle = .none
    }
    
    func configureCell(withModel model: String) {
        textLabel?.text = model
    }
    
}
