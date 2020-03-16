//
//  DetailsWeatherViewController.swift
//  openweathermap-ios
//
//  Created by Felipe Weber on 13/03/20.
//  Copyright © 2020 Lucas Montano. All rights reserved.
//

import UIKit

class DetailsWeatherViewController: UIViewController {
    
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var minMax: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
