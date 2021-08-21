//
//  ChatViewController.swift
//  goridepay
//
//  Created by Bryanza on 05/08/21.
//  Copyright © 2021 Apple Developer Academy. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var chatSearchBar: UISearchBar!
    @IBOutlet weak var chatTableView: UITableView!
    
    var messagesList = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chatBox()
        stagingMessages()
    }
    
    func chatBox() {
        chatTableView.dataSource = self
        chatTableView.delegate = self
        self.chatTableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
    }

    @IBAction func editButton(_ sender: UIButton) {
        self.navigationController!.pushViewController(LandingViewController(nibName: "LandingViewController", bundle: nil), animated: true)
    }
    
    func stagingMessages() {
        let session = URLSession.shared
        Transfer().callHeroku(
            session: session,
            address: "https://account-goridepay.herokuapp.com/api/v1/202001/messages",
            contentType: "json",
            parameters: [:],
            requestMethod: "GET"
        ) {
            (responseArray, responseObject, responseString) in
                // parse array here
            if let items = responseObject["available_messages"] as? [[String:AnyObject]] {
                for item in items {
                  // construct your model objects here
                  self.messagesList.append(Message(dictionary:item))
                }
                DispatchQueue.main.async {
                    self.chatTableView.reloadData()
                }
            }else {
                print(responseObject)
            }
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

}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? ChatTableViewCell else {return UITableViewCell()}

        // Configure the cell...
        cell.senderLabel.text = String(messagesList[indexPath.row].senderId) + " "
            + String(messagesList[indexPath.row].id) + " "
            + String(messagesList[indexPath.row].attachmentId)
        cell.messageLabel.text = messagesList[indexPath.row].text + " "
            + messagesList[indexPath.row].secretKey
        let createdAt = Transfer().parseDate(createdAt: messagesList[indexPath.row].createdAt)
        cell.createdLabel.text = createdAt

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList.count
    }
    
}

class Message {
    
    let id: Int
    let senderId: Int
    let text: String
    let secretKey: String
    let createdAt: String
    let attachmentId: Int
    
    init(dictionary: [String: AnyObject]) {
        id = dictionary["id"] as? Int ?? 0
        senderId = dictionary["sender_id"] as? Int ?? 0
        text = dictionary["text"] as? String ?? ""
        secretKey = dictionary["secret_key"] as? String ?? ""
        createdAt = dictionary["created_at"] as? String ?? ""
        attachmentId = dictionary["attachment_id"] as? Int ?? 0
    }
    
}
