//
//  AddEditTableViewController.swift
//  EmojiDictionaryExtended
//
//  Created by Néstor I. Martínez Ostoa on 26/10/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import UIKit

class AddEditTableViewController: UITableViewController {
    
    @IBOutlet weak var symbolTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var usageTF: UITextField!
    
    var emoji: Emoji?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillFields()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fillFields()
    }
    
    func fillFields() {
        guard let emoji = self.emoji else {return}
        symbolTF.text = emoji.symbol
        nameTF.text = emoji.name
        descriptionTF.text = emoji.description
        usageTF.text = emoji.usage
    }

    @IBAction func tappedOnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToEmojiTableVC" {
            emoji = Emoji(symbol: symbolTF.text ?? "" , name: nameTF.text ?? "", description: descriptionTF.text ?? "", usage: usageTF.text ?? "")
        }
    }
}
