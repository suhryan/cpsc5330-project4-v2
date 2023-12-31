//
//  ViewController.swift
//  cpsc5330-project4-v2
//
//  Created by ryan suh on 11/9/23.
//

import UIKit

class ViewController: UIViewController {

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
    }


    // Function to set up the initial game state (Layer 0)
    private func setupLayer0() {
        gameTextLabel.text = model.layer0Text
        optionButton1.setTitle("Start Game", for: .normal)
        optionButton1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
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
        optionButton1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        optionButton2.setTitle("Forest", for: .normal)
        optionButton2.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
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
            optionButton1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            
            optionButton2.setTitle("Dungeon", for: .normal)
            optionButton2.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        case .forest:
            optionButton1.setTitle("River", for: .normal)
            optionButton1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            
            optionButton2.setTitle("Footprints", for: .normal)
            optionButton2.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        }
    }

    // Function to check the game's outcome and update the UI accordingly
    private func checkGameOutcome() {
        if model.currentLocation != nil && (model.castleChoice != nil || model.forestChoice != nil) {
            gameTextLabel.text = model.checkOutcome()
            optionButton1.setTitle("Restart", for: .normal)
            optionButton1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            
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


