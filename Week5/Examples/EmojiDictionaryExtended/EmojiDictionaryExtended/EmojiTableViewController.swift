//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Néstor I. Martínez Ostoa on 26/10/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    //Datos
    var emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grining Face", description: "A typical smiley face", usage: "happiness"),
        Emoji(symbol: "😂", name: "Tears of joy", description: "A face to denote someone is laughing", usage: "laughter"),
        Emoji(symbol: "😍", name: "Heart eyes", description: "A smiley face with hearts for eyes.", usage: "in love"),
        Emoji(symbol: "🥵", name: "Hot face", description: "A face that is burning", usage: "spicy food"),
        Emoji(symbol: "🥶", name: "Cold face", description: "A face that is getting cold", usage: "cold weather"),
        Emoji(symbol: "🤯", name: "Exploding head", description: "A face whose head just exploded.", usage: "amazed by something"),
        Emoji(symbol: "🤓", name: "Nerdy face", description: "A face conveying intelligence", usage: "study time"),
        Emoji(symbol: "🤢", name: "Nauseated face", description: "A face that is about to vomit.", usage: "Disgusting"),
        Emoji(symbol: "😰", name: "Worried face", description: "A face that denotes worrisome", usage: "worried"),
        Emoji(symbol: "😎", name: "Cool face", description: "A face por something cool", usage: "cool"),
        Emoji(symbol: "😇", name: "Angel face", description: "A face with a halo", usage: "angel face"),
        Emoji(symbol: "😕", name: "Confused face", description: "A confused, puzzled face. ", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "🤔", name: "Thinking face", description: "A thinking face with an idea in mind.", usage: "light and ilumination"),
        Emoji(symbol: "😱", name: "Screaming face", description: "A face that screams", usage: "when you see a ghost"),
        Emoji(symbol: "🤑", name: "Money face", description: "A face that denotes a lot of money", usage: "when you are feeling lucky"),
        Emoji(symbol: "🤒", name: "Sick face", description: "A face when you are sick", usage: "sickness")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Emoji Dictionary"
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    //Mark - Data Source methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1. crear celda
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath)
        //2. contenido de la celda
        let emoji = emojis[indexPath.row]
        cell.textLabel?.text = "\(emoji.symbol) - \(emoji.name)"
        cell.detailTextLabel?.text = emoji.description
        cell.showsReorderControl = true
        //3. regresar celda
        return cell
    }
    
    //MARK - delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(emojis[indexPath.row].symbol)")
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let emojiToMove = emojis.remove(at: sourceIndexPath.row)
        emojis.insert(emojiToMove, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditEmoj" {
            //get emoji that user clicked
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let emoji = emojis[indexPath.row]
            
            //send emoji to AddEditTableViewController
            let navigationController = segue.destination as! UINavigationController
            let addEditEmojiTableViewController = navigationController.topViewController as! AddEditTableViewController
            addEditEmojiTableViewController.emoji = emoji
            
        }
    }
    
    @IBAction func unwindToEmojiTableViewController(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "unwindToEmojiTableVC" {
            let sourceVC = unwindSegue.source as! AddEditTableViewController
            guard let emoji = sourceVC.emoji else {return}
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                emojis[selectedIndexPath.row] = emoji
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            }
            else {
                let newIndexPath = IndexPath(row: emojis.count, section: 0)
                emojis.append(emoji)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
}

