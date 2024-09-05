//
//  LevelDetailViewController.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 05.09.2024.
//

import UIKit

class LevelDetailViewController: UITableViewController {

    let level = HSKLevel.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "LEVEL DETAIL"
        if #available(iOS 13.0, *) {
            tableView = UITableView(frame: .zero, style: .insetGrouped)
        } else {
            tableView = UITableView(frame: .zero, style: .grouped)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return level.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return level[section].titleLevel
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        print(indexPath.section, indexPath.row)
        var detail = ""
        switch indexPath.row {
        case 0:
            detail = level[indexPath.section].description
        case 1:
            detail = level[indexPath.section].object
        case 2:
            detail = level[indexPath.section].content
        case 3:
            detail = level[indexPath.section].structure
        case 4:
            detail = level[indexPath.section].resultsReport
        default:
            break
        }
        cell.textLabel?.text = detail
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        return cell
    }
}
