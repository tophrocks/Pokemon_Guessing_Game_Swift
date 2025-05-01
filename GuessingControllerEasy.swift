//  GuessingControllerEasy.swift
//  Pokemon Guessing Game
//
//  Created by Christopher Watson on 4/02/25.
//
// Our File For The Third Screen: Our Main Game: Easy Mode.

import UIKit

class GuessingControllerEasy: UIViewController {
    // Main Variables
    let choiceButtons: [UIButton] = (0..<4).map { _ in UIButton() } // Controls which buttons will be able to be selected.
    let pokemonImageView       = UIImageView()
    let repeatButton           = UIButton()
    let timerLabel             = UILabel()
    let pokemon_list: [String] = ["pikachu", "charizard", "bulbasaur", "squirtle", "jigglypuff"] // List of Pokemon to choose from.
    
    var pokemon_chosen: String?
    var timeLeft = 15
    var timer: Timer?
    
    // Main Loading Function
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupImageView()
        setupChoiceButtons()
        setupRepeatButton()
        setupTimerLabel()
    }
    
    // Function 1: Setup our Pokemon images, giving parameters and randomly choosing which pokemon is selected each time.
    func setupImageView() {
        pokemon_chosen               = randomPokemon()
        pokemonImageView.frame       = CGRect(x: 50, y: 150, width: 300, height: 300)
        pokemonImageView.contentMode = .scaleAspectFit
        pokemonImageView.image       = UIImage(named: pokemon_chosen ?? "pikachu") // Nil-coalescing used to unwrap pokemon_chosen string.
        view.addSubview(pokemonImageView)
        
        configureChoices() // Calls 'configureChoices' function.
        startTimer() // Calls 'startTimer' function.
    }
    
    // Function 2: Logic and parameters for the buttons on screen, placing them into frame and choosing which names will be presented.
    func setupChoiceButtons() {
        for (index, button) in choiceButtons.enumerated() {
            button.frame              = CGRect(x: 50, y: 470 + index * 60, width: 300, height: 50)
            button.backgroundColor    = .systemGreen
            button.layer.cornerRadius = 10
            button.tag                = index
            button.setTitleColor(.white, for: .normal)
            view.addSubview(button)
            
            // Calls 'choiceSelected' function.
            button.addTarget(self, action: #selector(choiceSelected(_:)), for: .touchUpInside)

        }
    }
    
    // Function 3: Logic for how we get the correct button choices, making sure the correct option is always one of the options.
    func configureChoices() {
        guard let correctAnswer = pokemon_chosen else { return }
        
        // Our set for which options will be displayed.
        var options = Set<String>()
        
        // This garuntees the correctAnswer will always be an option.
        options.insert(correctAnswer)
        
        // Takes random elements from the pokemon_list and adds it to our set until we reach 4.
        while options.count < 4 {
            if let random = pokemon_list.randomElement() { options.insert(random) }
        }
        
        // Shuffles up the options.
        let shuffledOptions = Array(options).shuffled()
        
        // Capitalizes all of the options (just so it looks nicer).
        for (index, button) in choiceButtons.enumerated() {
            button.setTitle(shuffledOptions[index].capitalized, for: .normal)
        }
    }
    
    // Function 4: Sets up the repeat button parameters and logic.
    func setupRepeatButton() {
        repeatButton.frame              = CGRect(x: 125, y: 720, width: 150, height: 50)
        repeatButton.backgroundColor    = .systemCyan
        repeatButton.layer.cornerRadius = 10
        repeatButton.setTitle("Repeat", for: .normal)
        view.addSubview(repeatButton)
        
        // Calls 'submitRepeat' function.
        repeatButton.addTarget(self, action: #selector(sumbitRepeat), for: .touchUpInside)
    }
    
    // Function 5: Sets up the timer parameters and logic.
    func setupTimerLabel() {
        timerLabel.frame         = CGRect(x: 125, y: 80, width: 150, height: 40)
        timerLabel.textAlignment = .center
        timerLabel.font          = UIFont.boldSystemFont(ofSize: 20)
        timerLabel.textColor     = .black
        timerLabel.text          = "Time left: \(timeLeft)"
        view.addSubview(timerLabel)
    }
    
    // Function 6: Calls a random pokemon element from our list of pokemon.
    func randomPokemon() -> String { return pokemon_list.randomElement() ?? "pikachu" }
    
    // Function 7: Timer logic, starts the timer and begins to countdown.
    func startTimer() {
        // Used to prevent multiple timers from running at the same time.
        timer?.invalidate()
        timer = nil
        
        // Easy mode has a time of 15 seconds.
        timeLeft = 15
        timerLabel.text = "Time left: \(timeLeft)"
        
        // Main timer logic, calls 'updateTimer' function.
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    // Objc Function 1: Updates the timer every second that goes by, counting down until 0. Once it reaches 0, it ends the game.
    @objc func updateTimer() {
        timeLeft -= 1
        timerLabel.text = "Time left: \(timeLeft)"
        
        // Once time runs out, this statement takes effect.
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            submitGuess(guess: nil)
        }
    }
    
    // Objc Function 2: When any guess is selected, calls this function to see which option was selected.
    @objc func choiceSelected(_ sender: UIButton) {
        let guess = sender.title(for: .normal)?.lowercased()
        submitGuess(guess: guess) // Calls 'submitGuess' function
    }

    // Function 8: Takes the button selected, and decides if said guess is correct or incorrect.
    func submitGuess(guess: String?) {
        let correctAnswer = pokemon_chosen ?? "pikachu"
        let isCorrect = guess == correctAnswer.lowercased()
        let message = isCorrect ? "Correct!" : "Oops! It was \(correctAnswer.capitalized)."
        
        // Alert used to show if the guess is correct or incorrect, based on previous logic above.
        let alert = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.setupImageView()
        }))
        
        // Presents alert.
        present(alert, animated: true)
        timer?.invalidate()
    }
    
    // Objc Function 3: When repeat button is clicked, calls setupImageView to run the game again.
    @objc func sumbitRepeat() { setupImageView() }
    
} // End Of File
