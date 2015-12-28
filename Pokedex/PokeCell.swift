//
//  PokeCell.swift
//  Pokedex
//
//  Created by Frederico Schnekenberg on 26/12/15.
//  Copyright © 2015 Frederico Schnekenberg. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell
{
    // MARK: --- Properties ---
    var pokemon : Pokemon!
    
    // MARK: --- IBOutlets ---
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: --- Initializers ---
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
    
    // MARK: --- Class Fucntions ---
    func configureCell(pokemon: Pokemon)
    {
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalizedString
        thumbImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
