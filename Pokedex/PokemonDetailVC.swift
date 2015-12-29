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
    @IBOutlet weak var nextEvoLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!

    // MARK: --- VC Lifecycle ---
    override func viewDidLoad()
    {
        super.viewDidLoad()

        solidTitleLabel.text = pokemon.name.capitalizedString
        hollowTitleLabel.text = pokemon.name.capitalizedString
        avatarImage.image = UIImage(named: "\(pokemon.pokedexId)")
        currentEvoImage.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetails { () -> () in
            // called after download is done
            self.updateUI()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: --- IBAction ---
    @IBAction func backButtonTapped(sender: UIButton)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: --- Utility Functions ---
    func updateUI()
    {
        descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        pokeIdLabel.text = "\(pokemon.pokedexId)"
        weightLabel.text = pokemon.weight
        attackLabel.text = "\(pokemon.attack)"
        
        if pokemon.nextEvoId == "" {
            nextEvoLabel.text = "No Evolutions"
            nextEvoImage.hidden = true
        } else {
            nextEvoImage.hidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvoId)
            var str = "Next Evolution: \(pokemon.nextEvoText)"
            
            if pokemon.nextEvoLevel != "" {
                str += " - LVL \(pokemon.nextEvoLevel)"
            }
            
            nextEvoLabel.text = str
        }
    }
}
