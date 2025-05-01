//  GuessingControllerMedium.swift
//  Pokemon Guessing Game
//
//  Created by Christopher Watson on 4/02/25.
//
// Our File For The Third Screen: Our Main Game: Hard Mode.

import UIKit

class GuessingControllerHard: UIViewController {
    // Main Variables
    let pokemonImageView       = UIImageView()
    let guessTextField         = UITextField()
    let submitButton           = UIButton()
    let repeatButton           = UIButton()
    let timerLabel             = UILabel()
    let pokemon_list: [String] = ["pikachu", "charizard", "bulbasaur", "squirtle", "jigglypuff"] // List of pokemon to choose from.
    
    var pokemon_chosen: String?
    var timeLeft = 10
    var timer: Timer?
    
    // Main Loading Function
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupImageView()
        setupTextField()
        setupSubmitButton()
        setupRepeatButton()
        setupTimerLabel()
    }
    
    // Function 1: Setup our Pokemon images, giving parameters and randomly choosing which pokemon is selected each time.
    func setupImageView() {
        pokemon_chosen               = randomPokemon()
        pokemonImageView.frame       = CGRect(x: 50, y: 150, width: 300, height: 300)
        pokemonImageView.contentMode = .scaleAspectFit
        pokemonImageView.image       = UIImage(named: pokemon_chosen ?? "pikachu")
        view.addSubview(pokemonImageView)
        
        startTimer() // Calls 'starTimer' function.
    }
    
    // Function 2: Setup our text field parameters, allowing people to type in their guess.
    func setupTextField() {
        guessTextField.frame       = CGRect(x: 50, y: 470, width: 300, height: 50)
        guessTextField.placeholder = "Guess the Pokémon"
        guessTextField.borderStyle = .roundedRect
        view.addSubview(guessTextField)
    }
    
    // Function 3: Setup our submit button logic and parameters.
    func setupSubmitButton() {
        submitButton.frame              = CGRect(x: 125, y: 540, width: 150, height: 50)
        submitButton.backgroundColor    = .systemBlue
        submitButton.layer.cornerRadius = 10
        submitButton.setTitle("Submit", for: .normal)
        view.addSubview(submitButton)
        
        // Calls 'submitGuess' function.
        submitButton.addTarget(self, action: #selector(submitGuess), for: .touchUpInside)
    }
    
    // Function 4: Setup our repeat button logic and parameters.
    func setupRepeatButton() {
        repeatButton.frame              = CGRect(x: 125, y: 600, width: 150, height: 50)
        repeatButton.backgroundColor    = .systemCyan
        repeatButton.layer.cornerRadius = 10
        repeatButton.setTitle("Repeat", for: .normal)
        view.addSubview(repeatButton)
        
        // Calls 'submitRepeat' function.
        repeatButton.addTarget(self, action: #selector(sumbitRepeat), for: .touchUpInside)
    }
    
    // Function 5: Sets up the timer parameters.
    func setupTimerLabel() {
        timerLabel.frame         = CGRect(x: 125, y: 80, width: 150, height: 40)
        timerLabel.textAlignment = .center
        timerLabel.font          = UIFont.boldSystemFont(ofSize: 20)
        timerLabel.textColor     = .black
        timerLabel.text          = "Time left: \(timeLeft)"
        view.addSubview(timerLabel)
    }
    
    // Function 6: Timer logic, starts the timer and begins to countdown.
    func startTimer() {
        // Used to prevent multiple timers from running at the same time.
        timer?.invalidate()
        timer = nil
        
        // Hard mode has a time of 10 seconds.
        timeLeft = 10
        timerLabel.text = "Time left: \(timeLeft)"
        
        // Main timer logic, calls 'updateTimer' function.
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    // Function 7: Used to automatically submit your guess when time runs out.
    func timeIsUp() { submitGuess() }
    
    // Function 8: Calls a random pokemon element from our list of pokemon.
    func randomPokemon() -> String { return pokemon_list.randomElement() ?? "pikachu" }
    
    // Objc Function 1: Updates the timer every second that goes by, counting down until 0. Once it reaches 0, it ends the game.
    @objc func updateTimer() {
        timeLeft -= 1
        timerLabel.text = "Time left: \(timeLeft)"
        
        // Once time runs out, this statement takes effect.
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            timeIsUp() // Calls 'timeIsUp' function.
        }
    }
    
    // Objc Function 2: Automatically submits guess in text box, and presents if the answer is correct or incorrect.
    @objc func submitGuess() {
        let guess = guessTextField.text?.lowercased()
        let correctAnswer = pokemon_chosen ?? "pikachu"
        let message = guess == correctAnswer ? "Correct!" : "Oops! It was \(correctAnswer.capitalized)."
        
        let alert = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.setupImageView()
        }))
        
        present(alert, animated: true)
        guessTextField.text = "" // Resets our guess textfield to nothing, so the game feels smoother.
        timer?.invalidate()
    }
    
    // Objc Function 3: Automatically resets the game when repeat button is pressed.
    @objc func sumbitRepeat() { setupImageView() }
    
} // End Of File
