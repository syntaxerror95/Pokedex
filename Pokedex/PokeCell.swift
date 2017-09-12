//
//  PokeCell.swift
//  Pokedex
//
//  Created by Sahadev Tandur on 10/09/17.
//  Copyright © 2017 Sahadev Tandur. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var PokeImg: UIImageView!
    
    @IBOutlet weak var PokeLb: UILabel!
    
    func configureCell(_ pokemon : Pokemon)
    {
        PokeLb.text = pokemon.Name
        PokeImg.image = UIImage(named: "\(pokemon.Id)")
    }
}
