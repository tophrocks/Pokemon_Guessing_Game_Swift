//  DifficultyController.swift
//  Pokemon Guessing Game
//
//  Created by Christopher Watson on 3/20/25.
//
// Our File For The Second Screen: Our Controller For Difficulty.

import UIKit

class DifficultyController: UIViewController {
    // Main Variables
    let easy_button   = UIButton()
    let medium_button = UIButton()
    let hard_button   = UIButton()
    
    // Main Loading Function
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        createButtons()
    }
    
    // Function 1: Creates all 3 buttons (easy, medium, and hard), sets all of their parameters, and gives them logic.
    func createButtons() {
        // Easy Button
        easy_button.frame = CGRect(x: 50, y: 150, width: 300, height: 80)
        easy_button.setTitle("Easy", for: .normal)
        easy_button.backgroundColor = .systemGreen
        easy_button.layer.cornerRadius = 10
        view.addSubview(easy_button)
        
        // Calls 'go to guessing' function.
        easy_button.addTarget(self, action: #selector(goToGuessing), for: .touchUpInside)
        
        // Medium Button
        medium_button.frame = CGRect(x: 50, y: 400, width: 300, height: 80)
        medium_button.setTitle("Medium", for: .normal)
        medium_button.backgroundColor = .systemOrange
        medium_button.layer.cornerRadius = 10
        view.addSubview(medium_button)
        
        // Calls 'go to guessing' function.
        medium_button.addTarget(self, action: #selector(goToGuessing), for: .touchUpInside)

        
        // Hard Button
        hard_button.frame = CGRect(x: 50, y: 650, width: 300, height: 80)
        hard_button.setTitle("Hard", for: .normal)
        hard_button.backgroundColor = .systemRed
        hard_button.layer.cornerRadius = 10
        view.addSubview(hard_button)
        
        // Calls 'go to guessing' function.
        hard_button.addTarget(self, action: #selector(goToGuessing), for: .touchUpInside)
    }
    
    // Objc Function 1: Our logic for which difficulty controller to send the player to, depending on which button is clicked.
    @objc func goToGuessing(sender: UIButton) {
        var guessingVC: UIViewController
        
        // If statement for deciding which button is clicked.
        if sender == easy_button {
            guessingVC = GuessingControllerEasy()
        } else if sender == medium_button {
            guessingVC = GuessingControllerMedium()
        } else if sender == hard_button {
            guessingVC = GuessingControllerHard()
        } else {
            guessingVC = GuessingControllerEasy()
        }
        
        // Navigates to our last screen: Our main game.
        self.navigationController?.pushViewController(guessingVC, animated: true)
    }
    
} // End Of File
