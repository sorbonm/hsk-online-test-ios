//
//  ViewController.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 04.09.2024.
//

import UIKit

class MainViewController: UITableViewController {
    let tests = [
        HSKSection(level: .level1, tests: HSKTests.getTests(for: .level1)),
        HSKSection(level: .level2, tests: HSKTests.getTests(for: .level2)),
        HSKSection(level: .level3, tests: HSKTests.getTests(for: .level3))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "HSK"
        
        if #available(iOS 13.0, *) {
            tableView = UITableView(frame: .zero, style: .insetGrouped)
        } else {
            tableView = UITableView(frame: .zero, style: .grouped)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TestCell")
        
        let detail = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(levelDetail))
        navigationItem.rightBarButtonItem = detail
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tests.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tests[section].tests.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tests[section].level.rawValue // Display the level (e.g., "HSK 1")
    }

    // Creating each cell for the test
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TestCell")
        let level = tests[indexPath.section].level
        let test = tests[indexPath.section].tests[indexPath.row]
        cell.textLabel?.text = test.name
        cell.detailTextLabel?.text = level.titleChinese
        cell.accessoryType = .detailDisclosureButton
        return cell
    }

    // Handling row selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let level = tests[indexPath.section].level
        let test = tests[indexPath.section].tests[indexPath.row]
        let testDetailVC = TestViewController()
        testDetailVC.level = level
        testDetailVC.test = test
        navigationController?.pushViewController(testDetailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let level = tests[indexPath.section].level
        print(level.description)
    }
    
    
    
    @objc func levelDetail(){
//        let detailVC = LevelDetailViewController()
//        navigationController?.pushViewController(detailVC, animated: true)
        
        let detailVC = QuestionViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

