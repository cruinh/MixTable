//
//  FirstViewController.swift
//  MixTable
//
//  Created by Matthew Hayes on 3/15/17.
//  Copyright © 2017 Matthew Hayes. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet var tableView : UITableView!
    
    var hasInjectedCell : Bool = true
    var injectCellAtRowIndex : Int = 3
    var regularContentCells : Int = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(toggleHasInjectedCell))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }

    func toggleHasInjectedCell() {
        hasInjectedCell = !hasInjectedCell
        tableView.reloadData()
    }
}

extension FirstViewController : UITableViewDataSource, UITableViewDelegate {
    
    //If we're injecting a cell into the middle of the table, split the regular content into sections 0 and 2, put the injected content in-between in section 1
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + (hasInjectedCell ? 2 : 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            if hasInjectedCell == true {
                let numberOfCells = injectCellAtRowIndex
                return numberOfCells
            } else {
                return regularContentCells
            }
        case 1:
            if hasInjectedCell == true {
                return 1
            }
        case 2:
            if hasInjectedCell == true {
                return regularContentCells - self.tableView(tableView, numberOfRowsInSection: 0)
            }
        default:
            break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell", for: indexPath)
            cell.textLabel?.text = "Common + \(indexPath.row)"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommonCell", for: indexPath)
            cell.textLabel?.text = "Common + \(indexPath.row + injectCellAtRowIndex)"
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "InjectedCell", for: indexPath)
        }
    }
    
}
