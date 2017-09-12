//
//  Pokemon.swift
//  Pokedex
//
//  Created by Sahadev Tandur on 09/09/17.
//  Copyright © 2017 Sahadev Tandur. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _Name : String!
    private var _Id : Int!
    private var _Dis : String!
    private var _Tp : String!
    private var _Defense : String!
    private var _Height : String!
    private var _Weight : String!
    private var _Attack : String!
    private var _Evo : String!
    private var _Evolvl : String!
    private var _EvoId : Int!
    
    var Name : String {
    get {
        return _Name
    }
    set
    {
        _Name = newValue
    }
    }
    
    var Id : Int {
    get {
        return _Id
    }
    set
    {
        _Id = newValue
    }
    }
    var Dis : String {
    get {
        if _Dis == nil{
            return ""
        }
        return _Dis
    }
    set
    {
        _Dis = newValue
    }
    }

    var Tp : String {
        get {
            if _Tp == nil{
                return ""
            }

            return _Tp
        }
        set
        {
            _Tp = newValue
        }
    }
    
    var Defense : String {
        get {
            if _Defense == nil{
                return ""
            }

            return _Defense
        }
        set
        {
            _Defense = newValue
        }
    }

    var Height : String {
        get {
            if _Height == nil{
                return ""
            }

            return _Height
        }
        set
        {
            _Height = newValue
        }
    }
    
    var Weight : String {
        get {
            if _Weight == nil{
                return ""
            }

            return _Weight
        }
        set
        {
            _Weight = newValue
        }
    }

    var Attack : String {
        get {
            if _Attack == nil{
                return ""
            }

            return _Attack
        }
        set
        {
            _Attack = newValue
        }
    }
    
    var Evo : String {
        get {
            if _Evo == nil{
                return ""
            }

            return _Evo
        }
        set
        {
            _Evo = newValue
        }
    }
    
    var Evolvl : String {
        get {
            if _Evolvl == nil{
                return ""
            }
            
            return _Evolvl
        }
        set
        {
            _Evolvl = newValue
        }
    }

    var EvoId : Int {
        get {
            if _EvoId == nil{
                return -99
            }
            
            return _EvoId
        }
        set
        {
            _EvoId = newValue
        }
    }


    
    
    init(PokemonName : String, PokemonId : Int)
    {
        self.Name = PokemonName
        self.Id = PokemonId
              
    }

    func DownloadData(completed : @escaping DownloadComplete) {
        Alamofire.request(Base_URL + "pokemon/\(self.Id)").responseJSON { (response) in
            //print(response.result.value)
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String{
                    self.Weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self.Height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self.Attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self.Defense = "\(defense)"
                }
                print(self.Weight)
                print(self.Height)
                print(self.Attack)
                print(self.Defense)
                
                if let types = dict["types"] as? [Dictionary<String, String>] {
                    self.Tp = ""
                    for type in types {
                        self.Tp += type["name"]!.capitalized + "/"
                    }
                    self.Tp = String(self.Tp.characters.dropLast())
                    
                }
                
                if let description = dict["descriptions"] as? [Dictionary<String, String>] {
                   // print(description)
                    //print(description[0]["resource_uri"]!)
                    Alamofire.request("http://pokeapi.co" + description[0]["resource_uri"]!).responseJSON(completionHandler: { (res) in
                       // print(res.result.value)
                        if let desdict = res.result.value as? Dictionary<String, AnyObject> {
                           // print(desdict)
                            if let dis = desdict["description"] as? String {
                                self.Dis = dis.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                print(dis)
                            }
                        }
                        completed()
                    })
                    
                }
                
                if let evolution = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolution.count > 0 {
                    
                    if let next = evolution[0]["to"] as? String {
                        if next.range(of: "mega") == nil {
                        
                            self.Evo = next.capitalized
                            if let level = evolution[0]["level"] as? Int {
                                self.Evolvl = "\(level)"
                            }
                        
                            
                        }
                        if let res = evolution[0]["resource_uri"] as? String {
                            var newStr = res.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                            newStr = newStr.replacingOccurrences(of: "/", with: "")
                            self.EvoId = Int(newStr)!
                        }
                    }else{
                        print("Else")
                    }
                    
                }
              //  completed()

            }
            completed()
        }
        //completed()
    }
    
//    func DownloadDiscription(completed : DownloadComplete, desc : [Dictionary<String, String>] ) {
//        Alamofire.request(desc[0]["resource_uri"]!).responseJSON(completionHandler: { (res) in
//            
//            print(res.result.value)
//        })
//        completed()
//    }
}
