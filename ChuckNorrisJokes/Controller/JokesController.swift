//  JokesController.swift
//  ChuckNorrisJokes
//
//  Created by Sergey on 1/19/21.

import UIKit
import SVProgressHUD

final class JokesController: UIViewController {
    
    //MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(JokeCell.self, forCellReuseIdentifier: JokeCell.identifier)
        tableView.tableFooterView = UIView()
        return tableView
    }()

    private let noJokesLabel = CustomLabel(text: "No jokes to display yet.", fontSize: 20)
    private let inputTextField = CustomTextField(placeholder: "How many jokes do you want?", fontSize: 16)
    private lazy var loadButton: CustomButton = {
        let button = CustomButton(title: "Load", titleColor: .white, titleFontSize: 20, backgroundColor: .appBlueColor, cornerRadius: 10)
        button.addTarget(self, action: #selector(handleLoadButton), for: .touchUpInside)
        return button
    }()
    
    var alamofireNetworkManager = NetworkManagerAlamofire()
    var jokesData: [String] = []
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        setDelegatesAndDatasource()
    }
    
    //MARK: - Selectors
    @objc private func handleLoadButton() {
        inputTextField.resignFirstResponder()
        guard let number = inputTextField.text, !number.isEmpty, let numberOfJokes = Int(number)  else { return }
        jokesData.removeAll()
        inputTextField.text = nil
        loadButton.loadJokes(withNumber: numberOfJokes, networkManager: alamofireNetworkManager)
    }
    
    //MARK: - Helpers
    private func setInitialUI() {
        view.backgroundColor = .white
        navigationItem.title = "Jokes"
        //Adding subviews
        view.addSubview(tableView)
        view.addSubview(noJokesLabel)
        view.addSubview(inputTextField)
        view.addSubview(loadButton)
        //Layout Views
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: inputTextField.topAnchor, right: view.rightAnchor, paddingBottom: 10)
        noJokesLabel.center(inView: view)
        inputTextField.anchor(left: view.leftAnchor, bottom: loadButton.topAnchor, right: view.rightAnchor, paddingLeft: 50, paddingBottom: 20, paddingRight: 50)
        loadButton.anchor(left: view.leftAnchor, bottom: view.compatibleSafeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 50, paddingBottom: 65, paddingRight: 50, height: 50)
        //Height of the cell to support ios 12 and less otherwise miltiline label doesn't work on ios 10 and cell can only display two lines of textLabel
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 10
        //Hide or show noJokesLabel
        noJokesLabel.isHidden = jokesData.count == 0 ? false : true
    }
    
    private func setDelegatesAndDatasource() {
        tableView.dataSource = self
        alamofireNetworkManager.delegate = self
        inputTextField.delegate = self
    }
    
}
//MARK: - UITableViewDataSource

extension JokesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JokeCell.identifier, for: indexPath) as! JokeCell
        cell.configureCell(withModel: jokesData[indexPath.row])
        return cell
    }
    
}
//MARK: - UITextFieldDelegate

extension JokesController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == inputTextField {
            textField.resignFirstResponder()
            handleLoadButton()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
}
//MARK: - NetworkManagerAlamofireDelegate

extension JokesController: NetworkManagerAlamofireDelegate {
    
    func didGetResult(with result: [String]) {
        jokesData = result
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.noJokesLabel.isHidden = self.jokesData.count == 0 ? false : true
            SVProgressHUD.dismiss()
        }
    }
    
}
