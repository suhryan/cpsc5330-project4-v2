//
//  ViewController.swift
//  cpsc5330-project4-v2
//
//  Created by ryan suh on 11/9/23.
//

import UIKit

class ViewController: UIViewController {

    var buttonToRemove: UIButton? // to remove button later
    
    @IBOutlet weak var stackViewButtons: UIStackView!
    
    @IBOutlet weak var atticButton: UIButton!
    
    @IBOutlet weak var garageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add 3rd button dynamically.
        let button3 = UIButton(type: .system)
        button3.setTitle("closet", for: .normal)
        button3.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button3.layer.borderWidth = 2.0
        button3.layer.borderColor = UIColor.black.cgColor
        button3.setTitleColor(UIColor.black, for: .normal)
        stackViewButtons.addArrangedSubview(button3)
        buttonToRemove = button3 // keep reference to 3rd button for later removal
    }

    func removeButton() {
        buttonToRemove?.removeFromSuperview()
        buttonToRemove = nil // Clear the reference if we're done with the button
    }
}

