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
    private var _pokemonDesc: String!
    private var _pokemonType: String!
    private var _pokemonHeight: String!
    private var _pokemonWeight: String!
    private var _pokemonDefense: String!
    private var _pokemonBaseAttack: String!
    private var _pokemonNextEvo: String!
    
    public var pokemonDesc: String{
        if _pokemonDesc == nil{
            _pokemonDesc = ""
        }
        return _pokemonDesc
    }
    
    public var pokemonType:String{
        if _pokemonType == nil{
            _pokemonType = ""
        }
        return _pokemonType
    }
    
    public var pokemonHeight: String{
        if _pokemonHeight == nil{
            _pokemonHeight = ""
        }
        return _pokemonHeight
    }
    
    public var pokemonWeight: String{
        if _pokemonWeight == nil{
            _pokemonWeight = ""
        }
        return _pokemonWeight
    }
    
    public var pokemonDefense: String{
        if _pokemonDefense == nil{
            _pokemonDefense = ""
        }
        return _pokemonDefense
    }
    
    public var pokemonBaseAttack: String{
        if _pokemonBaseAttack == nil{
            _pokemonBaseAttack = ""
        }
        return _pokemonBaseAttack
    }
    
    public var pokemonNextEvo: String{
        return _pokemonNextEvo
    }
    
    
    
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
