//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Frederico Schnekenberg on 28/12/15.
//  Copyright © 2015 Frederico Schnekenberg. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController
{
    // MARK: --- Properties ---
    var pokemon: Pokemon!
    
    // MARK: --- IBOutlets ---
    @IBOutlet weak var solidTitleLabel: UILabel!
    @IBOutlet weak var hollowTitleLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokeIdLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!

    // MARK: --- VC Lifecycle ---
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: --- IBAction ---
    @IBAction func backButtonTapped(sender: UIButton)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
