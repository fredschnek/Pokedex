//
//  Pokemon.swift
//  Pokedex
//
//  Created by Frederico Schnekenberg on 26/12/15.
//  Copyright © 2015 Frederico Schnekenberg. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon
{
    // MARK: --- Properties ---
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoId: String!
    private var _nextEvoText: String!
    private var _nextEvoLevel: String!
    private var _urlForPokemon: String!
    
    // MARK: --- Getters ---
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvoId: String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoText: String {
        if _nextEvoText == nil {
            _nextEvoText = ""
        }
        return _nextEvoText
    }
    
    var nextEvoLevel: String {
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    
    // MARK: --- Initializers ---
    init(name: String, pokedexId: Int)
    {
        self._name = name
        self._pokedexId = pokedexId
        
        _urlForPokemon = "\(baseURL)\(pokemonURL)\(self.pokedexId)/"
    }
    
    // MARK: --- Class Functions ---
    func downloadPokemonDetails(completed: DownloadComplete)
    {
        let url = NSURL(string: _urlForPokemon)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? [String: AnyObject] {
                
                // Attributes
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                // Types
                if let types = dict["types"] as? [[String: String]] where types.count > 0 {

                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += " / \(name.capitalizedString)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                // Description
                if let descArray = dict["descriptions"] as? [[String: String]] where descArray.count > 0 {
                    
                    if let url = descArray[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(baseURL)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            let descResult = response.result
                            if let descDict = descResult.value as? [String: AnyObject] {
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                }
                            }
                            completed()
                        }
                    }
                } else {
                    self._description = ""
                }
                
                // Next Evolution
                if let evolutions = dict["evolutions"] as? [[String: AnyObject]] where evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String {
                        // If it's not a Mega
                        if to.rangeOfString("mega") == nil {
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")

                                self._nextEvoId = num
                                self._nextEvoText = to
                                
                                if let level = evolutions[0]["level"] as? Int {
                                    self._nextEvoLevel = "\(level)"
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}