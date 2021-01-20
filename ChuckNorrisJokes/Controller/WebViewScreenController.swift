//  WebViewScreenController.swift
//  ChuckNorrisJokes
//
//  Created by Sergey on 1/19/21.

import UIKit
import SafariServices

class WebViewScreenController: UIViewController {
    
    //MARK: - Properties
    private lazy var seeAPIButton: CustomButton = {
        let button = CustomButton(title: "See API", titleColor: .white, titleFontSize: 20, backgroundColor: .appBlueColor, cornerRadius: 10)
        button.addTarget(self, action: #selector(handleSeeAPIButton), for: .touchUpInside)
        return button
    }()
    
    let apiURL = "http://www.icndb.com/api/"
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        presentSafariVC(with: apiURL)
    }
    
    //MARK: - Selectors
    @objc private func handleSeeAPIButton() {
        presentSafariVC(with: apiURL)
    }
    
    //MARK: - Helpers
    private func setInitialUI() {
        view.backgroundColor = .white
        navigationItem.title = "API"
        view.addSubview(seeAPIButton)
        seeAPIButton.center(inView: view)
        seeAPIButton.setDimensions(width: 200, height: 50)
    }
    
    private func presentSafariVC(with url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
}
