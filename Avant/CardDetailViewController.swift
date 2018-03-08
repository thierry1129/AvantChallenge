//
//  CardDetailViewController.swift
//  Avant
//
//  Created by Shuailin Lyu on 3/5/18.
//  Copyright © 2018 Shuailin Lyu. All rights reserved.
//

import UIKit


class CardDetailViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate

{
    var Card : cardData!
    var cardIndex : Int!
    var transactions : [Transaction] = []
    @IBOutlet weak var cardNameLabel: UILabel!
    
    @IBOutlet weak var transactionTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        transactions = []
        // set up the card and card table
        self.Card = cardArray.sharedCards.array[cardIndex]
        for (date, tranArr) in self.Card.Transaction{
            for amount in tranArr{
                transactions.append(Transaction(Date: date, amount: amount))
            }
        }
        transactionTable.delegate = self;
        transactionTable.dataSource = self
   
        cardNameLabel.text = self.Card.cardName
        
        transactionTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CardDetailTableViewCell  else {
            fatalError("The dequeued cell is not an instance of card detailed cell.")
        }
        cell.Date.text = String(transactions[indexPath.row].Date)
        cell.transaction.text = String(transactions[indexPath.row].amount)
        
      return cell
    }
    
    @IBAction func newTransaction(_ sender: Any) {
        // user want to create a new transaction. 
        performSegue(withIdentifier: "newTransaction", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newTransaction" {
            let destination = segue.destination as? newTransactionViewController
            destination?.index = self.cardIndex
        }
    }

}
