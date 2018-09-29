//
//  ViewController.swift
//  ElementTableView
//
//  Created by Ani Adhikary on 18/11/17.
//  Copyright © 2017 Ani Adhikary. All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {

    @IBOutlet weak var elementTableView: UITableView!
    
    var pt = [PeriodicTable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPeriodicTableView()
    }
    
    func setupPeriodicTableView() {
        elementTableView.estimatedRowHeight = 100.0
        elementTableView.rowHeight = UITableViewAutomaticDimension        
        
        elementTableView.delegate = self
        elementTableView.register(UINib(nibName: "ElementTableViewCell", bundle: nil), forCellReuseIdentifier: "ElementCell")
        elementTableView.register(UINib(nibName: "ElementGoToTopTableViewCell", bundle: nil), forCellReuseIdentifier: "ElementGoToTopTableViewCell")
        elementTableView.register(UINib(nibName: "PeriodicTableHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "PeriodicTableHeaderTableViewCell")
        elementTableView.register(UINib(nibName: "PeriodicTableFooterTableViewCell", bundle: nil), forCellReuseIdentifier: "PeriodicTableFooterTableViewCell")
        
        pt = getElements()
    }
    
    func getElements() -> [PeriodicTable] {
        
        var periodicTable = [PeriodicTable]()
        
        let lith­iumGroup = [
            Element(elementName: "Hydrogen", elementSymbol: "H"),
            Element(elementName: "Lithium", elementSymbol: "Li"),
            Element(elementName: "Sodium", elementSymbol: "Na"),
            Element(elementName: "Potassium", elementSymbol: "K")
        ]
        
        let beryl­liumGroup = [
            Element(elementName: "Beryllium", elementSymbol: "Be"),
            Element(elementName: "Magnesium", elementSymbol: "Mg"),
            Element(elementName: "Calcium", elementSymbol: "Ca"),
            Element(elementName: "Strontium", elementSymbol: "Sr")
        ]
        
        let scan­diumGroup = [
            Element(elementName: "Scan­dium", elementSymbol: "Sc"),
            Element(elementName: "Yttrium", elementSymbol: "Y"),
            Element(elementName: "Lanthanum", elementSymbol: "La"),
            Element(elementName: "Actinium", elementSymbol: "Ac")
        ]
        
        let titan­iumGroup = [
            Element(elementName: "Titan­ium", elementSymbol: "Ti"),
            Element(elementName: "Zirconium", elementSymbol: "Zr"),
            Element(elementName: "Hafnium", elementSymbol: "Hf"),
            Element(elementName: "Rutherfordium", elementSymbol: "Rf")
        ]
        
        periodicTable = [
            PeriodicTable(groupName: "Lith­ium group", elements: lith­iumGroup),
            PeriodicTable(groupName: "Beryl­lium group", elements: beryl­liumGroup),
            PeriodicTable(groupName: "Scan­dium Group", elements: scan­diumGroup),
            PeriodicTable(groupName: "Titan­ium Group", elements: titan­iumGroup)
        ]
        
        return periodicTable
    }

    @objc func goToTopButtonClicked(_ button: UIButton) {
        //elementTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        
        if #available(iOS 11.0, *) {
            elementTableView.setContentOffset(CGPoint(x: 0, y: -elementTableView.adjustedContentInset.top), animated: true)
        } else {
            elementTableView.setContentOffset(CGPoint(x: 0, y: -elementTableView.contentInset.top), animated: true)
        }
    }
}

extension ElementViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return pt.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pt[section].elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let element = pt[indexPath.section].elements[indexPath.row]
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        //finding last cell of table view
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let elementCell = tableView.dequeueReusableCell(withIdentifier: "ElementGoToTopTableViewCell", for: indexPath) as! ElementGoToTopTableViewCell
                       
            elementCell.elementLabel?.text = element.elementName
            elementCell.elementSymbolLabel?.text = element.elementSymbol
            elementCell.goToTopButton.addTarget(self, action: #selector(goToTopButtonClicked(_:)), for: .touchUpInside)
            elementCell.selectionStyle = .none
            return elementCell
        } else {
            let elementCell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as! ElementTableViewCell
            
            elementCell.elementLabel?.text = element.elementName
            elementCell.elementSymbolLabel?.text = element.elementSymbol
            elementCell.selectionStyle = .none
            return elementCell
        }
    }
}

extension ElementViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeriodicTableHeaderTableViewCell") as! PeriodicTableHeaderTableViewCell
        cell.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        cell.groupNameLabel.text = pt[section].groupName
        headerView.addSubview(cell)
        return headerView
    }
}

