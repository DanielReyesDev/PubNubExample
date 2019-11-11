//
//  ChannelViewController.swift
//  PubNubExample
//
//  Created by Daniel Reyes on 11/11/19.
//  Copyright © 2019 Daniel Reyes. All rights reserved.
//

import UIKit
import PubNub

final class ChannelViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
}

extension ChannelViewController: PNObjectEventListener {
    
}

extension ChannelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
}
