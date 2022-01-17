//
//  SettingsViewController.swift
//  App-News
//
//  Created by Bruno Vieira Souza on 17/12/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var lbSecons: UILabel!
    @IBOutlet weak var switchAutomatic: UISwitch!
    @IBOutlet weak var sliderTemp: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonVoltar(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}
