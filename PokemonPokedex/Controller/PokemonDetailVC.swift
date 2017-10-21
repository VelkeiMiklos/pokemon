//
//  PokemonDetailVC.swift
//  PokemonPokedex
//
//  Created by Velkei Miklós on 2017. 10. 19..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    //Outlets
    @IBOutlet weak var pokemonNameLbl: UILabel!
    @IBOutlet weak var pokemonIdLbl: UILabel!
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var pokemonDescLbl: UILabel!
    @IBOutlet weak var pokemonTypeLbl: UILabel!
    @IBOutlet weak var pokemonHeightLbl: UILabel!
    @IBOutlet weak var pokemonWeightLbl: UILabel!
    @IBOutlet weak var pokemonDefenseLbl: UILabel!
    @IBOutlet weak var pokemonBaseAttackLbl: UILabel!
    @IBOutlet weak var pokemonNextEvoLbl: UILabel!
    @IBOutlet weak var pokemon_2_Img: UIImageView!
    @IBOutlet weak var pokemon_3_Img: UIImageView!
    
    //Variables
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData(pokemon: pokemon)
    }
    //Functions
    func configureData(pokemon: Pokemon){
        
        pokemonNameLbl.text = pokemon.pokemonName
        pokemonIdLbl.text = "\(pokemon.pokemonId)"
        
    }
    
    //Actions
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
