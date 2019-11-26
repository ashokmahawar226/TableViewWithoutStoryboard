//
//  Dashboard.swift
//  EmatrixProblem
//
//  Created by ashok Mahawar on 24/11/19.
//  Copyright © 2019 ashok Mahawar. All rights reserved.
//

import UIKit

class Dashboard: UIViewController,UITextFieldDelegate {

    private let greenView = UIView()
    private var textView : UITextField!
    private var checkUserButton : UIButton!

    
    override func loadView() {
        super.loadView()
        print("hhccccch")
        
        //setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hhh")
        
        view.backgroundColor = .white
        createEmailTextView()
        createButton()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        if LocalStorage.shared.getValueFromLocalStorage(AppConstant.EMAILID).isEmpty {
            
        } else {
            let friendList  = DataBase.shared.fetchUserInformation()
            for index in friendList {
                FriendsManager.shared.userInfo[index.imageUrl] = index
            }
            self.navigationController?.pushViewController(FriendListVC.init(), animated: false)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
    
    private func setupView() {
      greenView.translatesAutoresizingMaskIntoConstraints = false
      greenView.backgroundColor = .green
        view.addSubview(greenView)
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
           greenView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
           greenView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
    }
    
   
    
    func createEmailTextView()  {
        textView = UITextField.init()
        textView.delegate = self
        textView.placeholder = "email@xyz.com"
        textView.translatesAutoresizingMaskIntoConstraints = false
       // textView.center = self.view.center
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 10.0
        textView.setLeftPaddingPoints(10)
        textView.layer.masksToBounds = true
        textView.font = .boldSystemFont(ofSize: 20.0)
        textView.textColor = .red
        textView.keyboardType = .emailAddress
        self.view.addSubview(textView)
        
        textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIApplication.shared.statusBarFrame.height + 100).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }
    
    func createButton() {
         checkUserButton = UIButton.init()
        //checkUserButton.titleLabel?.text = "Hello"
        checkUserButton.setTitle("Login", for: .normal)
        checkUserButton.backgroundColor = .gray
        checkUserButton.addTarget(self, action:#selector(onTapSendEmail(sender:)), for: .touchUpInside)
        self.view.addSubview(checkUserButton)

        checkUserButton.translatesAutoresizingMaskIntoConstraints = false
        checkUserButton.topAnchor.constraint(equalToSystemSpacingBelow: textView.bottomAnchor, multiplier: 5).isActive = true
        checkUserButton.leftAnchor.constraint(equalToSystemSpacingAfter: textView.leftAnchor, multiplier: 0).isActive = true
        checkUserButton.rightAnchor.constraint(equalToSystemSpacingAfter: textView.rightAnchor, multiplier: 0).isActive = true
        checkUserButton.heightAnchor.constraint(equalToConstant: 40).isActive = true


        
    }
    
    @objc func onTapSendEmail(sender : UIButton) {
        guard let email = self.textView.text else {
            return
        }
        if validateEmail(enteredEmail: email) {
            LocalStorage.shared.saveToLocalStorage(AppConstant.EMAILID, email)
            FriendsManager.shared.getFriendList(email)
            self.navigationController?.pushViewController(FriendListVC.init(), animated: true)
        } else {
            showAlert("Please enter vaild email id", "Alert")
        }
    }
    
    
    func validateEmail(enteredEmail:String) -> Bool {

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)

    }
    
    func showAlert(_ message : String , _ title : String){
        let alert : UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (action) in
        }))
        
        self.present(alert,animated: true, completion: nil)
    }

}

