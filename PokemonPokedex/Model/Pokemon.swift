//
//  Pokemon.swift
//  PokemonPokedex
//
//  Created by Velkei Miklós on 2017. 10. 17..
//  Copyright © 2017. NeonatCore. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    
    private var _pokemonName: String!
    private var _pokemonId: Int!
    private var _pokemonDesc: String!
    private var _pokemonType: String!
    private var _pokemonHeight: String!
    private var _pokemonWeight: String!
    private var _pokemonDefense: String!
    private var _pokemonBaseAttack: String!
    private var _pokemonNextEvoTxt: String!
    private var _pokemonNextEvoName: String!
    private var _pokemonNextEvoId: String!
    private var _pokemonNextEvoLvl: String!
    private var _pokemonURL:String!
    
    public var pokemonDesc: String{
        if _pokemonDesc == nil{
            _pokemonDesc = " "
        }
        return _pokemonDesc
    }
    
    public var pokemonType:String{
        if _pokemonType == nil{
            _pokemonType = " "
        }
        return _pokemonType
    }
    
    public var pokemonHeight: String{
        if _pokemonHeight == nil{
            _pokemonHeight = " "
        }
        return _pokemonHeight
    }
    
    public var pokemonWeight: String{
        if _pokemonWeight == nil{
            _pokemonWeight = " "
        }
        return _pokemonWeight
    }
    
    public var pokemonDefense: String{
        if _pokemonDefense == nil{
            _pokemonDefense = " "
        }
        return _pokemonDefense
    }
    
    public var pokemonBaseAttack: String{
        if _pokemonBaseAttack == nil{
            _pokemonBaseAttack = " "
        }
        return _pokemonBaseAttack
    }
    
    public var pokemonNextEvoTxt: String{
        if _pokemonNextEvoTxt == nil{
            _pokemonNextEvoTxt = " "
        }
        return _pokemonNextEvoTxt
    }
    
    var pokemonNextEvoLvl: String{
        
        if _pokemonNextEvoLvl == nil{
            _pokemonNextEvoLvl = ""
        }
        return _pokemonNextEvoLvl
    }
    
    var pokemonNextEvoId: String{
        
        if _pokemonNextEvoId == nil{
            _pokemonNextEvoId = ""
        }
        return _pokemonNextEvoId
    }
    
    var pokemonNextEvoName: String{
        
        if _pokemonNextEvoName == nil{
            
            _pokemonNextEvoName = ""
        }
        return _pokemonNextEvoName
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
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokemonId)"
        
    }
    
    func downloadPokemonData(completion: @escaping DownloadComplete ){
        let url = URL(string: self._pokemonURL)!
        print(url)
        // Letölteni az adatokat
        Alamofire.request(url).responseJSON { (response) in
            if let json = response.result.value as? Dictionary<String, Any> {
                if let height = json["height"] as? String{
                    self._pokemonHeight = height
                }
                if let weight = json["weight"] as? String{
                    self._pokemonWeight = weight
                }
                if let defense = json["defense"] as? Int{
                    self._pokemonDefense = "\(defense)"
                }
                if let attack = json["attack"] as? Int{
                    self._pokemonBaseAttack = "\(attack)"
                }
                // Egy pokemon egyszerre több típushoz tartozhat, pl Poison/Grass
                //    "types":[
                //   {
                //   "name":"poison",
                //  "resource_uri":"/api/v1/type/4/"
                //  },
                //  {
                //  "name":"grass",
                // "resource_uri":"/api/v1/type/12/"
                // }
                
                if let types = json["types"] as? [Dictionary<String,String>]{
                    if let name = types[0]["name"]{
                        self._pokemonType = name.capitalized
                    }
                    if types.count > 0{
                        for x in 1..<types.count{
                            if let name = types[x]["name"]{
                                self._pokemonType! += "/\(name.capitalized)"
                            }
                        }
                    }
                }
                
                //Van következő evolució
                //"evolutions":[
                //{
                //"level":16,
                //"method":"level_up",
                //"resource_uri":"/api/v1/pokemon/2/",
                //"to":"Ivysaur"
                //},
                //{
                //"level":16,
                //"method":"level_up",
                //"resource_uri":"/api/v1/pokemon/2/",
                //"to":"Ivysaur"
                //}
                //],
                
                //Ez a legmagasabb szinten lévő evolúció ha a to-ban van "mega"
                //"evolutions":[
                //{
                //"detail":"mega",
                //"method":"other",
                //"resource_uri":"/api/v1/pokemon/10033/",
                //"to":"Venusaur-mega"
                //}
                //],
                if let evolutions = json["evolutions"] as? [Dictionary<String,AnyObject>], evolutions.count > 0{
                    if let nextEvo = evolutions[0]["to"] as? String{
                        //Legmagasabb szinten van? Ha igen akkor nincsen nextEvoLvl
                        if nextEvo.range(of: "mega") == nil{
                            self._pokemonNextEvoTxt = nextEvo
                            //Következő evolution id-t ki kell venni a linkből
                            if let uri = evolutions[0]["resource_uri"] as? String{
                                let str = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = str.replacingOccurrences(of: "/", with: "")
                                self._pokemonNextEvoId = nextEvoId
                            }
                        }else{
                            self._pokemonNextEvoLvl = ""
                        }
                    }
                }
                
                //"descriptions":[
                //{
                //"name":"ivysaur_gen_1",
                //"resource_uri":"/api/v1/description/20/"
                //},
                //{
                //"name":"ivysaur_gen_2",
                //"resource_uri":"/api/v1/description/21/"
                //},
 
                if let descArr = json["descriptions"] as? [Dictionary<String,String>], descArr.count > 0{
                    if let descriptionUrl = descArr[0]["resource_uri"]{
                        let descUrl = "\(URL_BASE)\(descriptionUrl)"
                        print(descUrl)//http://pokeapi.co/api/v1/description/4/
                        
                        Alamofire.request(descUrl).responseJSON(completionHandler: { (response_desc) in
                            if let desc_json = response_desc.result.value as? Dictionary<String, AnyObject> {
                                if let description = desc_json["description"] as? String{
                                    self._pokemonDesc = description
                                }
                            }
                            if response_desc.result.error == nil{
                                completion(true)
                            }else{
                                completion(false)
                                debugPrint(response_desc.result.error as Any)
                            }
                        })
                        
                    }
                }else{
                    self._pokemonDesc = ""
                }
                
                
            }
            
            print(self._pokemonWeight)
            print(self._pokemonHeight)
            print(self._pokemonDefense)
            print(self._pokemonBaseAttack)
            print(self._pokemonType)
            print(self._pokemonNextEvoTxt)
            print(self._pokemonNextEvoId)
            print(self._pokemonDesc)
            if response.result.error == nil{
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    } 
}

