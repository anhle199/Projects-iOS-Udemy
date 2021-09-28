//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by Le Hoang Anh on 16/09/2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct QuizBrain {
    let quiz = [
        Question(
            text: "Which is the largest organ in the human body?",
            answers: ["Heart", "Skin", "Large Intestine"],
            correctAnswer: "Skin"
        ),
        Question(
            text: "Five dollars is worth how many nickels?",
            answers: ["25", "50", "100"],
            correctAnswer: "100"
        ),
        Question(
            text: "What do the letters in the GMT time zone stand for?",
            answers: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"],
            correctAnswer: "Greenwich Mean Time"
        ),
        Question(
            text: "What is the French word for 'hat'?",
            answers: ["Chapeau", "Écharpe", "Bonnet"],
            correctAnswer: "Chapeau"
        ),
        Question(
            text: "In past times, what would a gentleman keep in his fob pocket?",
            answers: ["Notebook", "Handkerchief", "Watch"],
            correctAnswer: "Watch"
        ),
        Question(
            text: "How would one say goodbye in Spanish?",
            answers: ["Au Revoir", "Adiós", "Salir"],
            correctAnswer: "Adiós"
        ),
        Question(
            text: "Which of these colours is NOT featured in the logo for Google?",
            answers: ["Green", "Orange", "Blue"],
            correctAnswer: "Orange"
        ),
        Question(
            text: "What alcoholic drink is made from molasses?",
            answers: ["Rum", "Whisky", "Gin"],
            correctAnswer: "Rum"
        ),
        Question(
            text: "What type of animal was Harambe?",
            answers: ["Panda", "Gorilla", "Crocodile"],
            correctAnswer: "Gorilla"
        ),
        Question(
            text: "Where is Tasmania located?",
            answers: ["Indonesia", "Australia", "Scotland"],
            correctAnswer: "Australia"
        )
    ]
    
    var questionNumber = 0
    var score = 0
    
    func getAnswers() -> [String] {
        return quiz[questionNumber].answers
    }
    
    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        if userAnswer == quiz[questionNumber].correctAnswer {
            self.score += 1
            return true
        } else {
            return false
        }
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getQuestionText() -> String {
        return quiz[questionNumber].text
    }
    
    func getProgress() -> Float {
        return Float(questionNumber + 1) / Float(quiz.count)
    }
    
    mutating func nextQuestion() {
        if questionNumber + 1 < quiz.count {
            self.questionNumber += 1
        } else {
            self.questionNumber = 0
            self.score = 0
        }
    }
}
