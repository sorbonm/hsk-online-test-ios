//
//  Question.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 05.09.2024.
//

import Foundation

enum AnswerType {
    case trueFalse
    case threeOptions(options: [String])
    case fourOptions(options: [String])
    case sixOptions(options: [String])
    case textInput
}

enum UserAnswer {
    case trueFalse(Bool?)
    case multipleChoice(String?)
    case textInput(String?)
    case none
}

struct Answer {
    let number: Int
    let type: AnswerType
    var userAnswer: UserAnswer
}
