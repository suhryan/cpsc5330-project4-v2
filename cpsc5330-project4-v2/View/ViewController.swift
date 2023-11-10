//
//  ViewController.swift
//  cpsc5330-project4-v2
//
//  Created by ryan suh on 11/9/23.
//

import UIKit

class ViewController: UIViewController {

    // Variable to keep a reference to a dynamically added button for later removal
    var buttonToRemove: UIButton? // to remove button later
    
    // Outlets for UI components
    @IBOutlet weak var stackViewButtons: UIStackView!
    
    @IBOutlet weak var gameTextLabel: UILabel!
    
    @IBOutlet weak var optionButton1: UIButton!
    
    @IBOutlet weak var optionButton2: UIButton!
    
    // Instance of the TreasureHuntModel to manage the game state
    let model = TreasureHuntModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayer0()
        
        // add 3rd button dynamically.
//        let button3 = UIButton(type: .system)
//        button3.setTitle("closet", for: .normal)
//        button3.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        button3.layer.borderWidth = 2.0
//        button3.layer.borderColor = UIColor.black.cgColor
//        button3.setTitleColor(UIColor.black, for: .normal)
//        stackViewButtons.addArrangedSubview(button3)
//        buttonToRemove = button3 // keep reference to 3rd button for later removal
//
//        let button4 = UIButton(type: .system)
//        button4.setTitle("closet", for: .normal)
//        button4.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        button4.layer.borderWidth = 2.0
//        button4.layer.borderColor = UIColor.black.cgColor
//        button4.setTitleColor(UIColor.black, for: .normal)
//        stackViewButtons.addArrangedSubview(button4)
//        buttonToRemove = button4 // keep reference to 3rd button for later remova
//
    }

//    func removeButton() {
//        buttonToRemove?.removeFromSuperview()
//        buttonToRemove = nil // Clear the reference if we're done with the button
//    }
    
    
//    @IBAction func optionButton1Pressed(_ sender: UIButton) {
//
//    }
//
//    @IBAction func optionButton2Pressed(_ sender: UIButton) {
//    }
    
    // Function to set up the initial game state (Layer 0)
    private func setupLayer0() {
        gameTextLabel.text = model.layer0Text
        optionButton1.setTitle("Start Game", for: .normal)
        optionButton2.isHidden = true  // Hide the second button

        // Setting up the target action for the 'Start Game' button
        optionButton1.removeTarget(nil, action: nil, for: .allEvents)
        optionButton1.addTarget(self, action: #selector(startGame), for: .touchUpInside)
    }

    // Function called when the 'Start Game' button is pressed
    @objc private func startGame() {
        initializeGame() // Transitioning to the main game initialization
    }

    // Function to initialize the main game (Layer 1)
    private func initializeGame() {
        gameTextLabel.text = model.initialText
        optionButton1.setTitle("Castle", for: .normal)
        optionButton2.setTitle("Forest", for: .normal)
        optionButton1.isHidden = false
        optionButton2.isHidden = false

        // Setting up target actions for the choice buttons
        optionButton1.removeTarget(nil, action: nil, for: .allEvents)
        optionButton1.addTarget(self, action: #selector(optionButton1Pressed), for: .touchUpInside)
        
        optionButton2.removeTarget(nil, action: nil, for: .allEvents)
        optionButton2.addTarget(self, action: #selector(optionButton2Pressed), for: .touchUpInside)
    }

    @IBAction func optionButton1Pressed(_ sender: UIButton) {
        if let currentLocation = model.currentLocation {
            switch currentLocation {
            case .castle:
                model.makeCastleChoice(.hall)
            case .forest:
                model.makeForestChoice(.river)
            }
        } else {
            model.makeLocationChoice(.castle)
            updateUIForSecondLayer(location: .castle)
        }
        checkGameOutcome()
    }

    @IBAction func optionButton2Pressed(_ sender: UIButton) {
        if let currentLocation = model.currentLocation {
            switch currentLocation {
            case .castle:
                model.makeCastleChoice(.dungeon)
            case .forest:
                model.makeForestChoice(.footprints)
            }
        } else {
            model.makeLocationChoice(.forest)
            updateUIForSecondLayer(location: .forest)
        }
        checkGameOutcome()
    }

    // Function to update UI for the second layer based on the player's location choice
    private func updateUIForSecondLayer(location: TreasureHuntModel.Location) {
        gameTextLabel.text = model.getTextForCurrentState()
        switch location {
        case .castle:
            optionButton1.setTitle("Hall", for: .normal)
            optionButton2.setTitle("Dungeon", for: .normal)
        case .forest:
            optionButton1.setTitle("River", for: .normal)
            optionButton2.setTitle("Footprints", for: .normal)
        }
    }

    // Function to check the game's outcome and update the UI accordingly
    private func checkGameOutcome() {
        if model.currentLocation != nil && (model.castleChoice != nil || model.forestChoice != nil) {
            gameTextLabel.text = model.checkOutcome()
            optionButton1.setTitle("Restart", for: .normal)
            optionButton1.removeTarget(nil, action: nil, for: .allEvents)
            optionButton1.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
            optionButton2.isHidden = true // Hide the second button
        }
    }

    // Function to restart the game when the 'Restart' button is pressed
    @objc private func restartGame() {
        model.resetGame()
        initializeGame()
    }


}


