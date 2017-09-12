//
//  ViewController.swift
//  Pokedex
//
//  Created by Sahadev Tandur on 09/09/17.
//  Copyright © 2017 Sahadev Tandur. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var CollectionView: UICollectionView!
    var pokemen = [Pokemon]()
    var fileredPokemen = [Pokemon]()
    var Audio : AVAudioPlayer!
    var inSearchMode = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let Blastoise = Pokemon(PokemonName: "Blastoise", PokemonId: 9)
        print(Blastoise.Name)
        print(Blastoise.Id)
        CollectionView.delegate = self
        CollectionView.dataSource = self
        SearchBar.delegate = self
        self.parsePokemonCSV()
        PlayAudio()
        SearchBar.returnKeyType = UIReturnKeyType.done
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func PlayAudio() {
        
        let URLpath = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do{
            
            Audio = try AVAudioPlayer(contentsOf: URL(string : URLpath)!)
            Audio.prepareToPlay()
            Audio.numberOfLoops = -1
            Audio.play()
        
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows  = csv.rows
//            print(rows)
            
            for row in rows {
                let id = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(PokemonName: name, PokemonId: id)
                pokemen.append(poke)
            }
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = CollectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            if inSearchMode == false{
                let pokemon = pokemen[indexPath.row]
                cell.configureCell(pokemon)}
            else
            {
                let filterpokemon = fileredPokemen[indexPath.row]
            cell.configureCell(filterpokemon)
            }
            return cell
        }else{
            return UICollectionViewCell()
        }

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode == false{
        return pokemen.count
        }
        else {
            return fileredPokemen.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke : Pokemon
        if inSearchMode == false{
            poke = pokemen[indexPath.row]
        }else {
            poke = fileredPokemen[indexPath.row]
        }
        performSegue(withIdentifier: "PokemonDetailsVC", sender: poke)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @IBAction func MusicBtnClick(_ sender: UIButton) {
        if Audio.isPlaying {
            Audio.pause()
            sender.alpha = 0.2
        }else
        {
           Audio.play()
            sender.alpha = 1.0
        }
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if SearchBar.text == nil || SearchBar.text == ""{
            inSearchMode = false
            CollectionView.reloadData()
            view.endEditing(true)
        }else{
            inSearchMode = true
            fileredPokemen = pokemen.filter({$0.Name.range(of: SearchBar.text!.lowercased()) != nil})
            CollectionView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailsVC" {
            if let destinationVC = segue.destination as? PokemonDetailsVC {
                if let poke = sender as? Pokemon {
                    destinationVC.pokemon = poke
                }
            }
        }
    }
}

