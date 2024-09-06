//
//  HSKLevel.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 05.09.2024.
//

import Foundation

enum HSKLevel: String, CaseIterable {
    
    case level1 = "HSK 1"
    case level2 = "HSK 2"
    case level3 = "HSK 3"
    case level4 = "HSK 4"
    case level5 = "HSK 5"
    case level6 = "HSK 6"
    
    var title: String {
        return self.rawValue
    }
    
    var directory: String {
        switch self {
        case .level1:
            return "HSK1"
        case .level2:
            return "HSK2"
        case .level3:
            return "HSK3"
        case .level4:
            return "HSK4"
        case .level5:
            return "HSK5"
        case .level6:
            return "HSK6"
        }
    }
    
    var titleLevel: String {
        switch self {
        case .level1:
            return "HSK Level Ⅰ"
        case .level2:
            return "HSK Level Ⅱ"
        case .level3:
            return "HSK Level Ⅲ"
        case .level4:
            return "HSK Level IV"
        case .level5:
            return "HSK Level Ⅴ"
        case .level6:
            return "HSK Level Ⅵ"
        }
    }
    
    var titleChinese: String {
        switch self {
        case .level1:
            return "HSK（一级）样卷"
        case .level2:
            return "HSK（二级）样卷"
        case .level3:
            return "HSK（三级）样卷"
        case .level4:
            return "HSK（四级）样卷"
        case .level5:
            return "HSK（五级）样卷"
        case .level6:
            return "HSK（六级）样卷"
        }
    }
    
    var answerJSONFilename: String {
        switch self {
        case .level1:
            return "hsk_1_correct_answers"
        case .level2:
            return "hsk_2_correct_answers"
        case .level3:
            return "hsk_3_correct_answers"
        case .level4:
            return "hsk_4_correct_answers"
        case .level5:
            return "hsk_5_correct_answers"
        case .level6:
            return "hsk_6_correct_answers"
        }
    }
    
    var duration: Int {
        switch self {
        case .level1: return 40
        case .level2: return 55
        case .level3: return 90
        case .level4: return 105
        case .level5: return 125
        case .level6: return 140
        }
    }
    
    var answerOption: [Answer] {
        switch self {
        case .level1:
            return TestAnswer.level1
        case .level2:
            return TestAnswer.level2
        case .level3:
            return TestAnswer.level3
        case .level4:
            return TestAnswer.level4
        case .level5:
            return TestAnswer.level5
        case .level6:
            return TestAnswer.level6
        }
    }
    
    var description: String {
        switch self {
        case .level1:
            return "HSK (Level 1) focuses on the ability of candidates to understand and use simple Chinese words and sentences."
        case .level2:
            return "HSK (Level 2) focuses on the ability of candidates to communicate simply and directly on some common topics in life by using Chinese."
        case .level3:
            return "HSK (Level 3) focuses on the ability of candidates to use Chinese to complete basic communication tasks in life, study and work."
        case .level4:
            return "HSK (Level 4) focuses on the ability of candidates to use Chinese to conduct basically complete, coherent and effective social communication on more complicated topics such as life, study and work."
        case .level5:
            return "HSK (Level 5) focuses on the ability of candidates to use Chinese to conduct relatively complete, smooth and effective social communication on complex topics such as life, study and work."
        case .level6:
            return "HSK (Level 6) focuses on the ability of candidates to use Chinese to conduct rich, smooth and decent social communication on some professional topics."
        }
    }
    
    var object: String {
        switch self {
        case .level1:
            return "HSK (Level 1) is mainly aimed at beginners with preliminary Chinese listening and reading abilities."
        case .level2:
            return "HSK (Level 2) is mainly for beginners who have basic Chinese listening and reading skills."
        case .level3:
            return "HSK (Level 3) is mainly aimed at beginners with general Chinese listening, reading and writing skills."
        case .level4:
            return "HSK (Level 4) is mainly for intermediate Chinese learners and users who have certain Chinese listening, reading and writing skills."
        case .level5:
            return "HSK (Level 5) is mainly for intermediate Chinese learners and users who have certain Chinese listening, reading and writing skills."
        case .level6:
            return "HSK (Level 6) is mainly for intermediate Chinese learners and users who have certain Chinese listening, reading and writing skills."
        }
    }
    
    var content: String {
        switch self {
        case .level1:
            return "HSK (Level 1) focuses on Chinese listening and reading ability, as well as the corresponding topics, tasks, grammar and 300 Chinese words."
        case .level2:
            return "HSK (Level 2) focuses on Chinese listening and reading ability, as well as the corresponding topics, tasks, grammar and 500 Chinese words."
        case .level3:
            return "HSK (Level 3) focuses on Chinese listening, reading and writing skills, as well as the corresponding topics, tasks, grammar and 1000 Chinese words."
        case .level4:
            return "HSK (Level 4) focuses on Chinese listening, reading and writing ability, corresponding topics, tasks, grammar and 2000 Chinese words, as well as related Chinese culture and China's national conditions."
        case .level5:
            return "HSK (Level 5) focuses on Chinese listening, reading and writing skills, corresponding topics, tasks, grammar and 4,000 Chinese words, as well as related Chinese culture and China's national conditions."
        case .level6:
            return "HSK (Level 6) focuses on Chinese listening, reading and writing ability, corresponding topics, tasks, grammar and 5,400 Chinese words, as well as related Chinese culture and China's national conditions."
        }
    }
    
    var structure: String {
        switch self {
        case .level1:
            return "HSK (Level 1) consists of 40 questions, which are divided into two sections: listening and reading. The test lasts about 40 minutes (including 5 minutes for candidates to complete the personal information form)."
        case .level2:
            return "HSK (Level 2) consists of 60 questions, which are divided into two sections: listening and reading. The test lasts about 55 minutes (including 5 minutes for candidates to complete the personal information form)."
        case .level3:
            return "HSK (Level 3) consists of 80 questions, which are divided into three sections: listening, reading and writing. The test lasts about 90 minutes (including 5 minutes for candidates to complete the personal information form)."
        case .level4:
            return "HSK (Level 4) consists of 100 questions, which are divided into three sections: listening, reading and writing. The test lasts about 105 minutes (including 5 minutes for candidates to complete the personal information form)."
        case .level5:
            return "HSK (Level 5) consists of 100 questions, which are divided into three sections: listening, reading and writing. The test lasts about 125 minutes (including 5 minutes for candidates to complete the personal information form)."
        case .level6:
            return "HSK (Level 6) consists of 101 questions, which are divided into three sections: listening, reading and writing. The test lasts about 140 minutes (including 5 minutes for candidates to complete the personal information form)."
        }
    }
    
    var resultsReport: String {
        switch self {
        case .level1:
            return "HSK (Level 1) report provides three scores: listening, reading and total score. Out of 200, the total score of 120 is qualified."
        case .level2:
            return "HSK (Level 2) report provides three scores: listening, reading and total score. Out of 200, the total score of 120 is qualified."
        case .level3:
            return "HSK (Level 3) report provides four scores: listening, reading, writing and total score. Out of 300, the total score of 180 is qualified."
        case .level4:
            return "HSK (Level 4) report provides four scores: listening, reading, writing and total score. Out of 300, the total score of 180 is qualified."
        case .level5:
            return "HSK (Level 5) report provides four scores: listening, reading, writing and total score. Out of 300, the total score of 180 is qualified."
        case .level6:
            return "HSK (Level 6) report provides four scores: listening, reading, writing and total score. Out of 300, the total score of 180 is qualified."
        }
    }
}
