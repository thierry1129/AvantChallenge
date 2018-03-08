//
//  NewCardViewController.swift
//  Avant
//
//  Created by Shuailin Lyu on 3/5/18.
//  Copyright © 2018 Shuailin Lyu. All rights reserved.
//

import UIKit

class NewCardViewController: UIViewController,  UITabBarControllerDelegate {
 

    @IBOutlet weak var CreditField: UITextField!
    @IBOutlet weak var APRField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    
    @IBAction func submitButton(_ sender: UIButton) {
// check if things are empty
        if ((CreditField.text?.isEmpty)! || (APRField.text?.isEmpty)! || (nameField.text?.isEmpty)!){
                alert(messageFromAlert: "please enter all required field")
                return
        }
        let newName = nameField.text
        // I use cardname as a unique identifier for cards.
        // normally credit card number would do the trick
        
        for card in cardArray.sharedCards.array{
            if card.cardName == newName{
                alert(messageFromAlert: "please enter a unique name for card")
                return
            }
        }
        // for now as long as APR and Credit limit is not below 0 then it's fine.
        if let APR =  Double(APRField.text!){
            if let cdLimit = Double(CreditField.text!){
                if (APR >= 0 && cdLimit >= cdLimit){
                    // cardArray.sharedCards.array is a singleton object shared by all vc.
                    let newCardHistory = [Int:[Double]] ()
                cardArray.sharedCards.array.append(cardData(cardName: nameField.text!, APR:APR, creditLimit: cdLimit, balance: 0, accruedInterest: 0, Transaction: newCardHistory))
                
                CreditField.text = ""
                APRField.text = ""
                nameField.text = ""
                // should go to the card list page
            self.tabBarController?.selectedIndex = 1
                }else{
                    alert(messageFromAlert: "please enter a positive number ")
                    return
                }
            }else{
                alert(messageFromAlert: "enter a valid number for credit limit")
                return
            }
        }else{
                alert(messageFromAlert: "enter a valid number for APR" )
            return
            }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
