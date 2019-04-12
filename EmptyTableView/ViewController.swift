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
    
	private let image = UIImage(named: "star-large")!.withRenderingMode(.alwaysTemplate)
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
		tableView = UITableView.newAutoLayout()
        tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
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
			tableView.autoPin(toTopLayoutGuideOf: self, withInset: 0)
			tableView.autoPin(toBottomLayoutGuideOf: self, withInset: 0)
			tableView.autoPinEdge(toSuperviewEdge: .leading)
			tableView.autoPinEdge(toSuperviewEdge: .trailing)
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if rows.count == 0 {
			tableView.separatorStyle = .none
			tableView.backgroundView?.isHidden = false
        } else {
			tableView.separatorStyle = .singleLine
			tableView.backgroundView?.isHidden = true
        }
        
        return rows.count
    }

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath)
		cell.textLabel?.text = rows[indexPath.row]
		return cell
	}
}
