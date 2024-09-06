//
//  TestResultViewController.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 07.09.2024.
//

import UIKit

class TestResultViewController: UIViewController {
    private lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.register(TestResultCell.self, forCellReuseIdentifier: "TestResultCell")
            tableView.delegate = self
            tableView.dataSource = self
            return tableView
        }()
        
        var questions: [Answer]
        var correctAnswers: [CorrectAnswer]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupTableView()
            setupNavigationBar()
        }
        
        init(questions: [Answer], correctAnswers: [CorrectAnswer]) {
            self.questions = questions
            self.correctAnswers = correctAnswers
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupTableView() {
            view.addSubview(tableView)
            tableView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        private func setupNavigationBar() {
            title = "Результаты теста"
        }
}

extension TestResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestResultCell", for: indexPath) as! TestResultCell
        
        let question = questions[indexPath.row]
        let correctAnswer = correctAnswers.first { $0.number == question.number }?.correctAnswer ?? .none
        print("number \(question.number) userAnswer \(question.userAnswer) correctAnswer \(correctAnswer)")
        cell.configure(questionNumber: question.number, userAnswer: question.userAnswer, correctAnswer: correctAnswer)
        
        return cell
    }
}
