//
//  newTransactionViewController.swift
//  Avant
//
//  Created by Shuailin Lyu on 3/5/18.
//  Copyright © 2018 Shuailin Lyu. All rights reserved.
//

import UIKit

class newTransactionViewController: UIViewController {
 var Card : cardData!
    @IBOutlet weak var Balance: UILabel!
    @IBOutlet weak var CreditLimit: UILabel!
    @IBOutlet weak var AmountLabel: UITextField!
    @IBOutlet weak var DateLabel: UITextField!
    
    var index : Int!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.Card = cardArray.sharedCards.array[index]
        CreditLimit.text = String(Card.creditLimit)
        Balance.text = String(Card.balance)
       index = cardArray.sharedCards.array.index(where:{$0.cardName == self.Card.cardName})
        
    }

    @IBAction func checkBalanceAfterEnteringDate(_ sender: Any) {
         if let actualDate = Int(DateLabel.text!){
        let cardArrToCheck = [self.Card]
        let cardAfterCheckBalance  =   balanceCheck(actualDate: actualDate, cardDataArr: cardArrToCheck as! [cardData])
        self.Card = cardAfterCheckBalance.first
        cardArray.sharedCards.array[index] = self.Card
        let rawBalance = self.Card.balance
        let roundedBalance = Double(round(rawBalance*100)/100)
        Balance.text = String(roundedBalance)
            
         }else{
            alert(messageFromAlert: "please enter a valid date")
        }
    }
        
    @IBAction func submitTransaction(_ sender: Any) {
            if let actualDate = Int(DateLabel.text!){
            if let actualAmount = Double(AmountLabel.text!){
                let cdLimit = self.Card.creditLimit
                let balance = self.Card.balance
                
            if (actualAmount>(cdLimit-balance)){
                alert(messageFromAlert: "too much to spend" )
            }else{
                if (self.Card.Transaction[actualDate] == nil){
                     self.Card.Transaction[actualDate]=[actualAmount]
                }else{
                self.Card.Transaction[actualDate]?.append(actualAmount)
                }
                let cardArrToCheck = [self.Card]
                let cardAfterCheckBalance  =   balanceCheck(actualDate: actualDate, cardDataArr: cardArrToCheck as! [cardData])
                self.Card = cardAfterCheckBalance.first
                let index = cardArray.sharedCards.array.index(where:{$0.cardName == self.Card.cardName})
                cardArray.sharedCards.array[index!] = self.Card
                self.navigationController?.popViewController(animated: true)
            }
            }
            else{
                alert(messageFromAlert: "amount needs to be a number")
            }
        }else{
           alert(messageFromAlert: "date needs to be an integer")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tranToCard" {
            let destination = segue.destination as? CardDetailViewController
            destination?.cardIndex = index
            //destination?.Card = self.Card
        }
    }
}
