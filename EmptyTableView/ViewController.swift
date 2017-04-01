//
//  ViewController.swift
//  EmptyTableView
//
//  Created by Ben Meline on 12/1/15.
//  Copyright © 2015 Ben Meline. All rights reserved.
//

import UIKit
import PureLayout

class ViewController: UIViewController {

    private var tableView: UITableView!
    
    private let image = UIImage(named: "star-large")!.imageWithRenderingMode(.AlwaysTemplate)
    private let topMessage = "Favorites"
    private let bottomMessage = "You don't have any favorites yet. All your favorites will show up here."
    
    private var rows = [String]()
    private let cellIdentifier = "Cell"
    
    private var didSetupConstraints = false
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupEmptyBackgroundView()
    }
    
    // MARK: - Initialization
    
    func setupTableView() {
        tableView = UITableView.newAutoLayoutView()
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    func setupEmptyBackgroundView() {
        let emptyBackgroundView = EmptyBackgroundView(image: image, top: topMessage, bottom: bottomMessage)
        tableView.backgroundView = emptyBackgroundView
    }
    
    // MARK: - Layout
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            tableView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
            tableView.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
            tableView.autoPinEdgeToSuperviewEdge(.Leading)
            tableView.autoPinEdgeToSuperviewEdge(.Trailing)
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if rows.count == 0 {
            tableView.separatorStyle = .None
            tableView.backgroundView?.hidden = false
        } else {
            tableView.separatorStyle = .SingleLine
            tableView.backgroundView?.hidden = true
        }
        
        return rows.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = rows[indexPath.row]
        return cell
    }
}