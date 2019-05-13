//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Model에서 만든 Question Array 불러오기
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionNumber += 1
        
        nextQuestion()
    }
    
    
    func updateUI() {
        // score update
        scoreLabel.text = "Score : \(score)"
        
        // progress update
        progressLabel.text = "\(questionNumber + 1) / 13"
        
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
    }
    

    func nextQuestion() {
        if questionNumber <= 12 {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            
            // update score and progress
            updateUI()
        } else {
            
            // alert Controller 생성
            let alert = UIAlertController(title: "Awesome", message: "re?", preferredStyle: .alert)
            
            // alert Action 생성
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                // scope 고려하기
                self.startOver()
            }
            
            // Controller에 addAction
            alert.addAction(restartAction)
            
            // Alert Present 
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if pickedAnswer == correctAnswer {
            score += 1
            
            ProgressHUD.showSuccess("Correct")
        } else {
            ProgressHUD.showError("Wrong!")
        }
        
        
    }
    
    
    func startOver() {
        score = 0
        questionNumber = 0
        nextQuestion()
    }
    

    
}
