//
//  PokemonDetailsVC.swift
//  Pokedex
//
//  Created by Sahadev Tandur on 10/09/17.
//  Copyright © 2017 Sahadev Tandur. All rights reserved.
//

import UIKit

class PokemonDetailsVC: UIViewController {

    @IBOutlet weak var PokeLb: UILabel!
    @IBOutlet weak var PokeImg: UIImageView!
    @IBOutlet weak var PokeDisLb: UILabel!
    
    @IBOutlet weak var PokeTypeLb: UILabel!
    @IBOutlet weak var PokeDefence: UILabel!
    
    @IBOutlet weak var PokeHeightLb: UILabel!
    @IBOutlet weak var PokeID: UILabel!
    
    @IBOutlet weak var PokeAttack: UILabel!
    @IBOutlet weak var PokeWeightLb: UILabel!
    
    @IBOutlet weak var PokeEvoLb: UILabel!
    @IBOutlet weak var PokeCurEvoImg: UIImageView!
    @IBOutlet weak var PokeNextEvoImg: UIImageView!
    @IBOutlet weak var PokePowerUpimg: UIImageView!
    
    var pokemon : Pokemon!
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemon.DownloadData {
            print("completed")
            self.UpdateUI()
        }

        PokeLb.text = pokemon.Name.capitalized
        PokeImg.image = UIImage(named: "\(pokemon.Id)")
        
        
    }
    
    func UpdateUI() {
        PokeDisLb.text = pokemon.Dis
        PokeTypeLb.text = pokemon.Tp
        PokeDefence.text = pokemon.Defense
        PokeHeightLb.text = pokemon.Height
        PokeID.text = "\(pokemon.Id)"
        PokeAttack.text = pokemon.Attack
        PokeWeightLb.text = pokemon.Weight
        PokeCurEvoImg.image = UIImage(named: "\(pokemon.Id)")
        if pokemon.Evo != "" {
        PokeEvoLb.text = pokemon.Evo + " LVL " + pokemon.Evolvl
        PokeNextEvoImg.isHidden = false
        PokePowerUpimg.isHidden = false
        PokeNextEvoImg.image = UIImage(named: "\(pokemon.EvoId)")
        }else{
            PokeEvoLb.text = "Max Evolution"
            PokeNextEvoImg.isHidden = true
            PokePowerUpimg.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
