//
//  DictionaryTableViewController.swift
//  TA_UI
//
//  Created by King Kraul on 11/01/2017.
//  Copyright © 2017 Taschenanwalt. All rights reserved.
//

import UIKit

class DictionaryTableViewController: UITableViewController, UISearchResultsUpdating {
    
    // Arrays für zu durchsuchende Elemente und gefundene Elemente anlegen
    var usecases = ["Autounfall", "Zugverspätung", "Zugausfall"]
    var filteredUsecases = [String] ()
    
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.separatorStyle = .none
        self.view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bei Eintippen in Suchleiste wird TableView quasi durch neue TableView ersetzt (für die der ResultsController zuständig ist)
        self.searchController = UISearchController(searchResultsController: self.resultsController)
        
        // Resultscontroller mitteilen, wo er nach den Daten schauen soll
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
        
        // Suchleiste im Header einfügen
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        // Zuständig für Update der Ergebnisse nach Eingabe in Suchleiste
        self.searchController.searchResultsUpdater = self
        
        // Animationseinstellungen
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    // Funktion, die bei jeder Eingabe in Suchleiste aufgerufen wird
    func updateSearchResults(for searchController: UISearchController) {
        // Alle Elemente durchsuchen und Ergebnisse in Filterarray speichern
        self.filteredUsecases = self.usecases.filter { (usecase:String) -> Bool in
            if usecase.lowercased().contains(self.searchController.searchBar.text!.lowercased()) {
                return true
            } else {
                return false
            }
        }
        // TableView mit Ergebnissen updaten
        self.resultsController.tableView.reloadData()
        self.resultsController.tableView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
    }
    
    // Anzahl der Reihen in TableView festlegen
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return self.usecases.count
        } else {
            return self.filteredUsecases.count
        }
    }
    
    // Elemente aus jeweiligem Array in jeweils eine Reihe der TableView schreiben
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        if tableView == self.tableView {
            cell.textLabel?.text = self.usecases[indexPath.row]
        } else {
            cell.textLabel?.text = self.filteredUsecases[indexPath.row]
        }
        return cell
    }
    
    /*// Funktion, die bei Auswahl eines Usecases aufgerufen wird
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
     }*/
    
}
