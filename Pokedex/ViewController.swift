//
//  ViewController.swift
//  Pokedex
//
//  Created by Frederico Schnekenberg on 26/12/15.
//  Copyright © 2015 Frederico Schnekenberg. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{
    // MARK: --- Properties ---
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()

    var inSearchMode = false
    
    var musicPlayer: AVAudioPlayer!
    
    // MARK: --- IBOutlets ---
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    // MARK: --- VC Lifecycle ---
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        
        // Setup the search bar attributes
        // TODO: Consider moving it to a View Class
        searchBar.returnKeyType = UIReturnKeyType.Done
        searchBar.setImage(UIImage(named: "img-magnifier"), forSearchBarIcon: UISearchBarIcon.Search, state: UIControlState.Normal)
        let textFieldInsideSearchBar = searchBar.valueForKey("searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.whiteColor()
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.valueForKey("placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.whiteColor()
        
        initAudio()
        parsePokemonCSV()
    }
    
    // MARK: --- IBActions ---
    @IBAction func musicButtonTapped(sender: UIButton!)
    {
        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    // MARK: --- Navigation ---
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destinationViewController as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    
    // MARK: --- Utility Functions ---
    func initAudio()
    {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
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

// MARK: --- UICollectionViewDataSource Extension ---
extension ViewController : UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            let poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
            } else {
                poke = pokemon[indexPath.row]
            }
            
            cell.configureCell(poke)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if inSearchMode {
            return filteredPokemon.count
        }
        
        return pokemon.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
}

// MARK: --- UICollectionViewDelegate Extension ---
extension ViewController : UICollectionViewDelegate
{
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
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

// MARK: --- UISearchBarDelegate Extension ---
extension ViewController : UISearchBarDelegate
{
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
            collection.reloadData()
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercaseString           
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            collection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        view.endEditing(true)
    }
}