//
//  ViewController.swift
//  Avant
//
//  Created by Shuailin Lyu on 3/5/18.
//  Copyright © 2018 Shuailin Lyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController  ,UITableViewDelegate, UITabBarControllerDelegate, UITableViewDataSource,UINavigationControllerDelegate , UITextFieldDelegate{
    
    @IBOutlet weak var cardTable: UITableView!
    @IBOutlet weak var balanceDate: UITextField!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardArray.sharedCards.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CardTableViewCell  else {
            fatalError("The dequeued cell is not an instance of card table view cell.")
        }
        cell.nameLabel.text = cardArray.sharedCards.array[indexPath.row].cardName
        let rawBalance = cardArray.sharedCards.array[indexPath.row].balance
        let roundedBalance = Double(round(rawBalance*100)/100)
        cell.balanceLabel.text = String(roundedBalance)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cardToDetail", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cardToDetail" {
            // go to card detail view
            let destination = segue.destination as? CardDetailViewController, cardIndex = cardTable.indexPathForSelectedRow?.row
            let destinationCard = cardArray.sharedCards.array[cardIndex!]
            destination?.Card = destinationCard
            destination?.cardIndex = cardIndex!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cardTable.dataSource = self
        cardTable.delegate = self
        balanceDate.delegate = self
        cardTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func inquireBalance(_ sender: Any) {
        if let dateCheck = Int(balanceDate.text!) {
            let cardResult =  balanceCheck(actualDate: dateCheck, cardDataArr: cardArray.sharedCards.array)
            cardArray.sharedCards.array = cardResult
            cardTable.reloadData()
        }else{
            alert(messageFromAlert: "please enter a valid date " )
        }
    }
}
extension UIViewController {
    func balanceCheck(actualDate: Int,  cardDataArr : [cardData] )->[cardData]{
        
        var cardDataArrResult = cardDataArr
        for i in 0..<cardDataArrResult.count{
            var card = cardDataArrResult[i]
            let dailyInterest = card.APR / 365/100
            var balance = 0.0
            var interest = 0.0
            
            for a in 0..<actualDate+1{
                if (a%30 == 0){
                    // now we are at monthly caliber date, change balance accoringly
                    balance += interest
                    interest = 0
                }
                if let dailyTrans = card.Transaction[a]{
                    // if I have daily transaction in this date
                    for singleTrans in dailyTrans{
                        // now we first need to add all daily transactions to balance
                        balance += singleTrans
                        
                    }
                    // now calcaulte daily accrued interest
                    interest += balance * dailyInterest
                } else{
                    // now at Day a, there is no transaction,
                    // we simply need to accrue daily interest based on the balance before
                    interest += balance * dailyInterest
                }
            }
            
            card.accruedInterest = interest
            card.balance = balance
            
            cardDataArrResult[i] = card
            
        }
        return cardDataArrResult
    }
    
    func alert(messageFromAlert: String){
        
        let myalert = UIAlertController(title: "not complete", message: messageFromAlert, preferredStyle: UIAlertControllerStyle.alert)
        
        myalert.addAction(UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            print("Selected")
        })
        myalert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel")
        })
        
        self.present(myalert, animated: true)
    }
    
    
}
