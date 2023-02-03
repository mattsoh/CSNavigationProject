//
//  ViewController.swift
//  CSNavigationProject
//
//  Created by Matthew Soh on 1/2/23.
//

import UIKit

class WelcomeVC: UIViewController {
    @IBOutlet weak var DCSGLogo: UIImageView!
    @IBOutlet weak var DCSGBackground: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func unwindFromFloorMapVC(unwindSegue: UIStoryboardSegue){
        
    }
    
}

