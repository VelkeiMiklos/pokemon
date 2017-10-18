//
//  ViewController.swift
//  PokemonPokedex
//
//  Created by Velkei Miklós on 2017. 10. 17..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //Variables
    var pokemon: Pokemon!
    var pokemons = [Pokemon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        parseCSV()
    }
    
    
    //Functions
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as? PokemonCell{
            
            //let pokemon = Pokemon(pokemonName: "Pokemon", pokemonId: indexPath.row)
            let pokemon = pokemons[indexPath.row]
            cell.configureCell(pokemon: pokemon)
            return cell
        }else{
            return PokemonCell()
        }
    }    
    
    func parseCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            // print(rows)
            for row in rows{
                let pokemonId = Int(row["id"]!)!
                let pokemonName = row["identifier"]!
                let poke = Pokemon(pokemonName: pokemonName, pokemonId: pokemonId)
                pokemons.append(poke)
            }
        }catch let error as NSError{
            print(error.debugDescription)
        }
    }
    
}

