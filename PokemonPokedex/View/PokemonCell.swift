//
//  PokemonCell.swift
//  PokemonPokedex
//
//  Created by Velkei Miklós on 2017. 10. 17..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonNameLbl: UILabel!
    @IBOutlet weak var pokemonImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView(){
        //Kerekített legyen
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func configureCell(pokemon: Pokemon){
        pokemonNameLbl.text = pokemon.pokemonName
        pokemonImg.image = UIImage(named: "\(pokemon.pokemonId)")
    }
}
