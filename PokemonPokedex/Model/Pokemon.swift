//
//  Pokemon.swift
//  PokemonPokedex
//
//  Created by Velkei Miklós on 2017. 10. 17..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import Foundation
class Pokemon{
    
    private var _pokemonName: String!
    private var _pokemonId: Int!
    
    public var pokemonName: String{
        return _pokemonName
    }
    public var pokemonId: Int{
        return _pokemonId
    }
    
    init(pokemonName: String, pokemonId: Int){
        self._pokemonName = pokemonName.capitalized
        self._pokemonId = pokemonId
    }
    
    
}
