//
//  QuestionViewController.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 05.09.2024.
//

import UIKit

class QuestionViewController: UITableViewController {
    
    var questions: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Регистрируем ячейки
        tableView.register(TrueFalseCell.self, forCellReuseIdentifier: "TrueFalseCell")
        tableView.register(ThreeOptionsCell.self, forCellReuseIdentifier: "ThreeOptionsCell")
        tableView.register(SixOptionsCell.self, forCellReuseIdentifier: "SixOptionsCell")
        tableView.register(TextInputCell.self, forCellReuseIdentifier: "TextInputCell")
        
        
        // Инициализация вопросов
        questions = [
            Answer(number: 1, type: .trueFalse, userAnswer: .trueFalse(nil)),
            Answer(number: 2, type: .trueFalse, userAnswer: .trueFalse(nil)),
            Answer(number: 3, type: .trueFalse, userAnswer: .trueFalse(nil)),
            Answer(number: 4, type: .trueFalse, userAnswer: .trueFalse(nil)),
            Answer(number: 5, type: .trueFalse, userAnswer: .trueFalse(nil)),
            
            Answer(number: 6, type: .threeOptions(options: ["A", "B", "C"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 7, type: .threeOptions(options: ["A", "B", "C"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 8, type: .threeOptions(options: ["A", "B", "C"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 9, type: .threeOptions(options: ["A", "B", "C"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 10, type: .threeOptions(options: ["A", "B", "C"]), userAnswer: .multipleChoice(nil)),
            
            Answer(number: 11, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 12, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 13, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 14, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 15, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            
            Answer(number: 16, type: .threeOptions(options: ["A", "B", "C"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 17, type: .threeOptions(options: ["A", "B", "C"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 18, type: .threeOptions(options: ["A", "B", "C"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 19, type: .threeOptions(options: ["A", "B", "C"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 20, type: .threeOptions(options: ["A", "B", "C"]), userAnswer: .multipleChoice(nil)),
            
            Answer(number: 21, type: .trueFalse, userAnswer: .trueFalse(nil)),
            Answer(number: 22, type: .trueFalse, userAnswer: .trueFalse(nil)),
            Answer(number: 23, type: .trueFalse, userAnswer: .trueFalse(nil)),
            Answer(number: 24, type: .trueFalse, userAnswer: .trueFalse(nil)),
            Answer(number: 25, type: .trueFalse, userAnswer: .trueFalse(nil)),
            
            Answer(number: 26, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 27, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 28, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 29, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 30, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            
            Answer(number: 31, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 32, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 33, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 34, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 35, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            
            Answer(number: 36, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 37, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 38, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 39, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            Answer(number: 40, type: .sixOptions(options: ["A", "B", "C", "D", "E", "F"]), userAnswer: .multipleChoice(nil)),
            
            Answer(number: 41, type: .textInput, userAnswer: .textInput(nil))
        ]
    }

    
    // Количество секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Количество строк в секции
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    
    // Создание ячейки для каждого вопроса
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let question = questions[indexPath.row]
        switch question.type {
        case .trueFalse:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrueFalseCell", for: indexPath) as! TrueFalseCell
            if case let .trueFalse(userAnswer) = question.userAnswer {
                cell.configure(questionNumber: question.number, userAnswer: userAnswer)
            } else {
                cell.configure(questionNumber: question.number, userAnswer: nil)
            }
            cell.onAnswerSelected = { [weak self] isTrue in
                print("onAnswerSelected")
                self?.questions[indexPath.row].userAnswer = .trueFalse(isTrue)
            }
            return cell
        case .threeOptions(options: let options):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeOptionsCell", for: indexPath) as! ThreeOptionsCell
            cell.configure(questionNumber: question.number, options: options)
            return cell
        case .fourOptions(options: let options):
            return UITableViewCell()
        case .sixOptions(options: let options):
            let cell = tableView.dequeueReusableCell(withIdentifier: "SixOptionsCell", for: indexPath) as! SixOptionsCell
            cell.configure(questionNumber: question.number, options: options)
            return cell
        case .textInput:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextInputCell", for: indexPath) as! TextInputCell
            cell.configure(questionNumber: question.number)
            return cell
        }
    }
}
