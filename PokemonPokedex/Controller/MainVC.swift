//
//  ViewController.swift
//  PokemonPokedex
//
//  Created by Velkei Miklós on 2017. 10. 17..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit
import AVFoundation
class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UISearchBarDelegate{
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //Variables
    var pokemon: Pokemon!
    var pokemons = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var searchActive : Bool = false
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Beállítások
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        //Keyboard elüntetés
        searchBar.returnKeyType = UIReturnKeyType.done
        
        //Init metódusok
        parseCSV()
        initMusic()
    }
    
    //Functions
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive{
            return filteredPokemon.count
        }else{
            return pokemons.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as? PokemonCell{
            
            //let pokemon = Pokemon(pokemonName: "Pokemon", pokemonId: indexPath.row)
            //let pokemon = pokemons[indexPath.row]
            let poke: Pokemon!
            if searchActive{
                poke = filteredPokemon[indexPath.row]
            }else{
                poke = pokemons[indexPath.row]
            }
            
            cell.configureCell(pokemon: poke)
            return cell
        }else{
            return PokemonCell()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Keyboard eltüntetése
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //keresés
        filteredPokemon = pokemons.filter{ $0.pokemonName.lowercased().contains( searchBar.text!.lowercased()) }

        if filteredPokemon.count != 0{
            self.collectionView.reloadData()
            searchActive = true
        }else{
            searchActive = false
            self.collectionView.reloadData()
            //Keyboard eltüntetése
            view.endEditing(true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke: Pokemon!
        if searchActive{
            poke = filteredPokemon[indexPath.row]
        }else{
            poke = pokemons[indexPath.row]
        }

        performSegue(withIdentifier: "toPokemonDetail", sender: poke)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPokemonDetail"{
            if let destinationVC = segue.destination as? PokemonDetailVC{
                assert(sender as? Pokemon != nil)
                destinationVC.pokemon = sender as! Pokemon
            }
        }
    }
    
    //Actions
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        //zene leállít
        if audioPlayer.isPlaying{
            audioPlayer.stop()
            sender.alpha = 0.5
        }else{
            audioPlayer.play()
            sender.alpha = 1
        }
    }
    
    //Methods
    func parseCSV(){
        //csv fájl beolvasása
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
    
    func initMusic(){
        //zene indítása
        let url = Bundle.main.url(forResource: "music", withExtension: "mp3")!
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            print("Cannot play the file")
        }
    }
}

