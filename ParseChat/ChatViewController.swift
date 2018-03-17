//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Tavien on 2/26/18.
//  Copyright © 2018 Warpedflo. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var chatField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var posts : [AnyObject] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
    @IBAction func SendMessage(_ sender: Any)
    {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatField.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success
            {
                print("The message was saved!")
                self.chatField.text = ""
            } else if let error = error
            {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    func onTimer()
    {
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            
            if error == nil
            {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        let post = posts[indexPath.row] as! PFObject
        print (post)
        
        if let user = post["user"] as? PFUser
        {
            cell.username.text = user.username
        }
        else
        {
            cell.username.text = "🐙"
        }
        cell.message.text = post["text"] as? String
        
        
        return cell
    }
    
    

}
