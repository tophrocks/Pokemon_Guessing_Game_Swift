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
    
    // Main Loading Function
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonCreator()
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
    
    // Objc Function 1: Logic for what happens when our button is pressed.
    @objc func startButtonPress() {
        let difficultyVC = DifficultyController()
        
        // Navigates to our second screen: The Difficulty Controller.
        self.navigationController?.pushViewController(difficultyVC, animated: true)
    }
    
} // End Of File
