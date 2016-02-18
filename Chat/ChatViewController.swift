//
//  ChatViewController.swift
//  Chat
//
//  Created by Christine Hong on 2/17/16.
//  Copyright © 2016 christinehong. All rights reserved.
//

import UIKit
import Parse

let parseClassName = "Message_iOSFeb2016"

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var messages: [PFObject]?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatTextField: UITextField!
    
    @IBAction func addChatText(sender: AnyObject) {
        var chat = PFObject(className: parseClassName)
        chat["text"] = chatTextField.text
        chat["user"] = PFUser.currentUser()
        
        print(PFUser.currentUser())
        
        chat.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("text success")
            } else {
                // There was a problem, check error.description
                print("text failure")
            }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
     
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:
            "pollForMessages", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func pollForMessages(){
        var query = PFQuery(className:parseClassName)
        query.includeKey("user")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                self.messages = objects
                self.tableView.reloadData()
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatTextTableViewCell", forIndexPath: indexPath) as! ChatTextTableViewCell
        
        if let _messages = messages {
            if let message = _messages[indexPath.row] as? PFObject {
                cell.message = message
                cell.renderCell()
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
