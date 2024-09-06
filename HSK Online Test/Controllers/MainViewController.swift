//
//  ViewController.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 04.09.2024.
//

import UIKit
import SnapKit

class MainViewController: UITableViewController {
    let level = HSKLevel.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "HSK"
        
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TestCell")
        
        let detail = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(levelDetail))
        navigationItem.rightBarButtonItem = detail
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return level.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }

    // Creating each cell for the test
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TestCell")
        cell.textLabel?.text = level[indexPath.row].title
        cell.detailTextLabel?.text = level[indexPath.row].titleChinese
        cell.accessoryType = .detailDisclosureButton
        return cell
    }

    // Handling row selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let levelVC = LevelViewController()
        levelVC.test = HSKSection(level: level[indexPath.row], tests: HSKTests.getTests(for: level[indexPath.row]))
        navigationController?.pushViewController(levelVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print(level[indexPath.row].description)
    }
    
    @objc func levelDetail(){
        let detailVC = LevelDetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

