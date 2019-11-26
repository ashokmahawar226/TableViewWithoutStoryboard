//
//  FriendListVC.swift
//  EmatrixProblem
//
//  Created by ashok Mahawar on 24/11/19.
//  Copyright © 2019 ashok Mahawar. All rights reserved.
//

import UIKit
import RxSwift

class FriendListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    var tableView : UITableView!
    var topBar : UIView!
    var logoutButton : UIButton!
    var emailIDLbl: UILabel!
    var arrDisposeBag = [Disposable]()
    var userDictKeyCopy = Array(FriendsManager.shared.userInfo.keys)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTopBar()
        createEmailLbl()
        createLogoutButton()
        createTableView()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTask()
        print("viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disposeTask()
    }
    
    func createTask(){
        arrDisposeBag.append(FriendsManager.shared.taskDownloadImage.subscribe(
            onNext : { url in
                print("taskDownloadImage")
                self.userDictKeyCopy = Array(FriendsManager.shared.userInfo.keys)
                self.tableView.reloadData()
        }))
        
        arrDisposeBag.append(FriendsManager.shared.taskError.subscribe(
            onNext : { error in
                var errorMsg = ""
                if let errorDict : NSError = error as NSError {
                    if let message : String = errorDict.userInfo["message"] as? String {
                        errorMsg = message
                    }
                }
                self.showAlertError(errorMsg, "Alert")
        }
        ))
    }
    
    func disposeTask() {
        arrDisposeBag.forEach { (disposable) in
            disposable.dispose()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func createTopBar() {
        topBar = UIView.init()
        topBar.backgroundColor = .white
        topBar.layer.borderColor = UIColor.red.cgColor
        topBar.layer.borderWidth = 2.0
        self.view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.topAnchor.constraint(equalTo: view.topAnchor, constant: UIApplication.shared.statusBarFrame.height).isActive = true
        topBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }
    
    func createEmailLbl(){
        emailIDLbl = UILabel.init()
        emailIDLbl.adjustsFontSizeToFitWidth = true
        emailIDLbl.textColor = .black
        emailIDLbl.text = LocalStorage.shared.getValueFromLocalStorage(AppConstant.EMAILID)
        emailIDLbl.textAlignment = .center
        self.topBar.addSubview(emailIDLbl)
        emailIDLbl.translatesAutoresizingMaskIntoConstraints = false
        
        emailIDLbl.topAnchor.constraint(equalTo: topBar.topAnchor).isActive = true
        emailIDLbl.leftAnchor.constraint(equalTo: topBar.leftAnchor).isActive = true
        emailIDLbl.widthAnchor.constraint(equalToConstant: view.bounds.width*0.85).isActive = true
        emailIDLbl.bottomAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        
        //
    }
    func createLogoutButton(){
        //
        logoutButton = UIButton.init()
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.backgroundColor = .gray
        logoutButton.addTarget(self, action: #selector(logoutPressed(sender:)), for: .touchUpInside)
        topBar.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.topAnchor.constraint(equalTo: topBar.topAnchor).isActive = true
        logoutButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        logoutButton.leftAnchor.constraint(equalTo: self.emailIDLbl.rightAnchor).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
    }
    
    func createTableView() {
        tableView = UITableView.init()
        //tableView.backgroundColor = .cyan
        //tableView.layer.borderWidth = 2.0
        tableView.layer.borderColor = UIColor.red.cgColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentSize.height = 130
        tableView.tableFooterView = UIView.init()

        self.view.addSubview(tableView)
        tableView.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 10).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 120
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendsManager.shared.userInfo.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FriendCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "FriendCell")
        let user : String = userDictKeyCopy[indexPath.row]
        cell.fullNameLbl.text = "\(String(describing: FriendsManager.shared.userInfo[user]!.firstName)) \(String(describing: FriendsManager.shared.userInfo[user]!.lastName))"
        cell.emailID.text = FriendsManager.shared.userInfo[user]?.emailID
        cell.selectionStyle = .none
        cell.profileImage?.image = UIImage.init(data: FriendsManager.shared.userInfo[user]?.profileImage as Data? ?? Data.init())
               return cell
      }
    
    @objc func logoutPressed(sender: UIButton) {
        print("pressedBrowser")
        showAlert("Logout", "Alert")
    }
    
    @objc func pressedTelephone(sender: UIButton) {
        print("pressedTelephone")
    }
    
    func showAlert(_ message : String , _ title : String){
        let alert : UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (action) in
            //
            self.userDictKeyCopy.removeAll()
            FriendsManager.shared.logoutFromAPP()
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .default, handler: { (action) in
            //
        }))
        
        self.present(alert,animated: true, completion: nil)
    }
    
    func showAlertError(_ message : String , _ title : String) {
        let alert : UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (action) in
            //
            self.userDictKeyCopy.removeAll()
            FriendsManager.shared.logoutFromAPP()
            self.navigationController?.popViewController(animated: true)
        }))
        
        
        self.present(alert,animated: true, completion: nil)
    }

}
