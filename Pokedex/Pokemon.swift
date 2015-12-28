//
//  Pokemon.swift
//  Pokedex
//
//  Created by Frederico Schnekenberg on 26/12/15.
//  Copyright © 2015 Frederico Schnekenberg. All rights reserved.
//

import Foundation

class Pokemon
{
    // MARK: --- Properties ---
    private var _name : String!
    private var _pokedexId : Int!
    
    // MARK: --- Getters ---
    var name : String {
        return _name
    }
    
    var pokedexId : Int {
        return _pokedexId
    }
    
    // MARK: --- Initializers ---
    init(name: String, pokedexId: Int)
    {
        self._name = name
        self._pokedexId = pokedexId
    }
}