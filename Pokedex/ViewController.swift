//
//  ViewController.swift
//  Pokedex
//
//  Created by Frederico Schnekenberg on 26/12/15.
//  Copyright © 2015 Frederico Schnekenberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    // MARK: --- Properties ---
    var pokemon = [Pokemon]()
    
    // MARK: --- IBOutlets ---
    @IBOutlet weak var collection: UICollectionView!
    
    // MARK: --- VC Lifecycle ---    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        
        parsePokemonCSV()
    }
    
    // MARK: --- Utility Functions ---
    func parsePokemonCSV()
    {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            let csv = try CSVParser(contentsOfUrl: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)! // may need Optional Chaining
                let name = row["identifier"]! // may need Optional Chaining
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
}

// MARK: --- UICollectionViewDelegate Extension ---
extension ViewController : UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
    }
}

// MARK: --- UICollectionViewDataSource Extension ---
extension ViewController : UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            let poke = pokemon[indexPath.row]
            cell.configureCell(poke)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return pokemon.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
}

// MARK: --- UICollectionViewDelegateFlowLayout Extension ---
extension ViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(105, 105)
    }
}