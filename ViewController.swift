//  ViewController.swift
//  Pokemon Guessing Game
//
//  Created by Christopher Watson on 3/13/25.
//
// Our File For The First Screen: Our Start Button Screen.

import UIKit

class ViewController: UIViewController {
    // Main Variables
    let start_button = UIButton()
    let welcome = UILabel()
    
    // Main Loading Function
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonCreator()
        welcomeCreator()
        view.backgroundColor = .white
    }
    
    // Function 1: Create our button and set parameters.
    func buttonCreator() {
        start_button.frame = CGRect(x: 50, y: 350, width: 300, height: 100)
        start_button.setTitle("START", for: .normal)
        start_button.backgroundColor = .systemRed
        start_button.layer.cornerRadius = 10
        view.addSubview(start_button)
        
        // Calls @objc func startButtonPress()
        start_button.addTarget(self, action: #selector(startButtonPress), for: .touchUpInside)
    }
    
    // Function 2: Create our welcome label and set parameters.
    func welcomeCreator() {
        welcome.frame = CGRect(x: 50, y: 130, width: 300, height: 100)
        welcome.text = "Welcome to the Pokémon Guessing Game!"
        welcome.backgroundColor = .white
        welcome.textColor = .black
        welcome.textAlignment = .center
        welcome.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        welcome.layer.cornerRadius = 12
        welcome.layer.masksToBounds = true
        welcome.numberOfLines = 0
        welcome.adjustsFontSizeToFitWidth = true
        view.addSubview(welcome)
    }
    
    // Objc Function 1: Logic for what happens when our button is pressed.
    @objc func startButtonPress() {
        let difficultyVC = DifficultyController()
        
        // Navigates to our second screen: The Difficulty Controller.
        self.navigationController?.pushViewController(difficultyVC, animated: true)
    }
    
} // End Of File
