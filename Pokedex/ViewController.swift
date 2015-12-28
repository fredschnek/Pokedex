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
    // MARK: --- IBOutlets ---
    @IBOutlet weak var collection: UICollectionView!
    
    // MARK: --- VC Lifecycle ---    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
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
            // TODO: change later to reflect names from csv file
            let pokemon = Pokemon(name: "Test", pokedexId: indexPath.row + 1)
            cell.configureCell(pokemon)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        // TODO: change later to reflect Pokemon Array
        return 30
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