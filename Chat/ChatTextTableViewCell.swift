//
//  ChatTextTableViewCell.swift
//  Chat
//
//  Created by Christine Hong on 2/17/16.
//  Copyright © 2016 christinehong. All rights reserved.
//

import UIKit
import Parse

class ChatTextTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var chatTextLabel: UILabel!
    
    var message: PFObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func renderCell(){
        if let _message = message {
            if let text = _message["text"] as? String {
                chatTextLabel.text = text
            }
            
            print("message")
            print(message)
            
            if let user = _message["user"] as? PFUser {
                print("user")
                print(user)                
                
                if let username = user.username {
                    print("username")
                    print(username)
                    usernameLabel.text = username
                }
            } else {
                // usernameLabel.hidden = true
            }
        }
    }
    
}
