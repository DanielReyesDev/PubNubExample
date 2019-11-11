//
//  ChannelViewController.swift
//  PubNubExample
//
//  Created by Daniel Reyes on 11/11/19.
//  Copyright © 2019 Daniel Reyes. All rights reserved.
//

import UIKit
import PubNub

struct Message {
    var message: String
    var username: String
    var uuid: String
}

final class ChannelViewController: UIViewController {
    
    //Our PubNub object that we will use to publish, subscribe, and get the history of our channel
    private var client: PubNub!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let channelName: String
    
    private var messages: [Message] = []
    
    init(channelName: String) {
        self.channelName = channelName
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupClient()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupClient() {
        let configuration = PNConfiguration(publishKey: "pub-c-955af0d5-f7cd-4e4c-83df-03081bee0778",
                                            subscribeKey: "sub-c-f0ed332a-04b0-11ea-a577-b207d7d0b791")
        configuration.uuid = UUID().uuidString
        client = PubNub.clientWithConfiguration(configuration)
        client.addListener(self)
        client.subscribeToChannels([channelName], withPresence: true)
    }
    
    private func loadMessages() {
        client.historyForChannel(channelName, start: nil, end: nil, limit: 20) { (result, status) in
            guard let result = result, status == nil, let messages = result.data.messages as? [[String: String]] else { return }
            
            for m in messages {
                let message = Message(message: m["message"]!, username: m["username"]!, uuid: m["uuid"]!)
                self.messages.append(message)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func publishMessage() {
        
        let messageObject : [String:Any] =
            [
                "message" : "Test Message",
                "username" : "User",
                "uuid": client.uuid()
        ]
        
        client.publish(messageObject, toChannel: channelName) { (status) in
            print(status.data.information)
        }
        
    }
}

extension ChannelViewController: PNObjectEventListener {
    
}

extension ChannelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = messages[indexPath.row].message
        cell.detailTextLabel?.text = messages[indexPath.row].username
        return cell
    }
}
