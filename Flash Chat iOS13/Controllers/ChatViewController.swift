//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var errorAlert = ErrorAlert()
    var messages: [Message] = [
    
        Message(sender: "1@2.com", body: "Hey!"),
        Message(sender: "a@b.com", body: "Hello!"),
        Message(sender: "1@2.com", body: "What's up ;lk;lkpokf okpkopfok kfk[k f[[k[kfpokp djdlksd  ;md;ld;lasmd; ")
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
    }
        
    func loadMessages(){
        messages = []
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querrySnapshot, error) in
            if let e = error {
                print("fetch Error \(e.localizedDescription)")
                return
            } else {
                self.messages = []
                
                if let snapshotDocuments = querrySnapshot?.documents {
                    
                    for message in snapshotDocuments {
                        let data = message.data()
                        if let sender = data[K.FStore.senderField] as? String, let body = data[K.FStore.bodyField] as? String {
                            self.messages.append(Message(sender: sender , body: body ))
                            DispatchQueue.main.async {
                                
                                self.tableView.reloadData()
                            }
                        }

                    }
                }


            }
        }

    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
         print("Send...")
        print(Auth.auth().currentUser?.email)
   
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data:
               [K.FStore.senderField: messageSender,
                K.FStore.bodyField : messageBody,
                K.FStore.dateField : Date().timeIntervalSince1970
               ]) { (error) in
                if let e = error {
                    print("Error in saving \(e.localizedDescription)")
                } else {
                    print("Saved data")
                }
            }
        }
       
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            self.errorAlert.showAlert(view: self, title: K.Errors.authErrorTitle, message: signOutError.localizedDescription)
        }
    }
    
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
        // Example
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        return cell
    }
    
    
}
