//
//  AdventureModel.swift
//  cpsc5330-project4-v2
//
//  Created by ryan suh on 11/10/23.
//

class TreasureHuntModel {
    // Enumerations defining the possible locations and choices in the game
    enum Location {
        case castle, forest
    }

    enum CastleChoice {
        case hall, dungeon
    }

    enum ForestChoice {
        case river, footprints
    }

    // Variables to store the player's current location and choices
    var currentLocation: Location?
    var castleChoice: CastleChoice?
    var forestChoice: ForestChoice?

    // Texts for different layers of the game
    let layer0Text = "Explore to find the diamond you are seeking. You have two paths that can lead you to the treasure. Only the right choices will be successful."
    let initialText = "The diamond could be in a castle or a forest."
    let castleText = "Since you have chosen to enter the castle, you can enter the main hall or the dungeon."
    let forestText = "Since you have chosen to enter the forest, you can follow the river or the mysterious footprints."

    // Functions to set the player's choices
    func makeLocationChoice(_ location: Location) {
        currentLocation = location
    }

    func makeCastleChoice(_ choice: CastleChoice) {
        castleChoice = choice
    }

    func makeForestChoice(_ choice: ForestChoice) {
        forestChoice = choice
    }

    // Function to return the appropriate text based on the current game state
    func getTextForCurrentState() -> String {
        switch currentLocation {
        case .castle:
            return castleText
        case .forest:
            return forestText
        case .none:
            return initialText
        }
    }

    // Function to determine the outcome of the game based on the player's choices
    func checkOutcome() -> String {
        switch (currentLocation, castleChoice, forestChoice) {
        case (.castle, .hall, _):
            return "You are unsuccessful. The diamond you are seeking is not here."
        case (.castle, .dungeon, _):
            return "Success. You have found the diamond."
        case (.forest, _, .river):
            return "You are unsuccessful. The diamond is not here."
        case (.forest, _, .footprints):
            return "Success. The diamond is found by you."
        default:
            return ""
        }
    }

    // Function to reset the game to its initial state
    func resetGame() {
        currentLocation = nil
        castleChoice = nil
        forestChoice = nil
    }
}

