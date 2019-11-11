//
//  ConnectViewController.swift
//  PubNubExample
//
//  Created by Daniel Reyes on 11/11/19.
//  Copyright © 2019 Daniel Reyes. All rights reserved.
//

import UIKit
import PubNub

final class ConnectViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()    
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
}

extension ConnectViewController: PNObjectEventListener {
    func client(_ client: PubNub, didReceive status: PNStatus) {
        if status.category == .PNConnectedCategory || status.category == .PNReconnectedCategory {
            if status.category == .PNConnectedCategory {
                print("Subscribed Successfully")
                self.performSegue(withIdentifier: "connectSegue", sender: self)
            }
        } else if status.operation == .unsubscribeOperation && status.category == .PNDisconnectedCategory{
            print("unsubscribed successfully")
        } else{
            print("Something went wrong subscribing")
        }
    }
    
    func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
        print("Received message in ConnectVC:", message.data)
    }
}
