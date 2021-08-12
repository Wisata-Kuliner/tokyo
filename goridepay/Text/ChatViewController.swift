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
    }
    
    func chatBox() {
        chatTableView.dataSource = self as? UITableViewDataSource
        chatTableView.delegate = self as? UITableViewDelegate
        self.chatTableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
    }

    @IBAction func editButton(_ sender: UIButton) {
        self.navigationController!.pushViewController(LandingViewController(nibName: "LandingViewController", bundle: nil), animated: true)
    }
    
    func stagingMessages() {
        let url = URL(string: "https://account-goridepay.herokuapp.com/api/v1/202001/messages")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                let json : NSDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                if let items = json["available_messages"] as? [[String:AnyObject]] {
                    for item in items {
                      // construct your model objects here
                      self.messagesList.append(Message(dictionary:item))
                    }
                    DispatchQueue.main.async {
                        self.chatTableView.reloadData()
                    }
                }
            } catch {
                print(String(data: data, encoding: .utf8)!)
            }
        }

        task.resume()
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
