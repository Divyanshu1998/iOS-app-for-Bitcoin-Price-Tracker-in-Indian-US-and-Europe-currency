//
//  BitcoinViewController.swift
//  Bitcoin Price Tracker
//
//  Created by Divyanshu Upadhyay on 26/02/20.
//  Copyright © 2020 Divyanshu Upadhyay. All rights reserved.
//

import UIKit

class BitcoinViewController: UIViewController {

    @IBOutlet weak var inrLabel: UILabel!
    @IBOutlet weak var isdLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getPrice()
        
       
    }
    func getPrice()
    {
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=INR,USD,EUR")
               {
                   URLSession.shared.dataTask(with: url) { (data:Data?, response:URLResponse?, error:Error?) in
                       if error == nil
                       {
                           if data != nil{
                               if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Double] {
                                   DispatchQueue.main.async {
                                       
                                  
                                    
                                    
                                   let inr = json["INR"]
                                    let formatter = NumberFormatter()
                                    formatter.numberStyle = .currency
                                    formatter.currencyCode = "INR"
                                  let inrPrice =  formatter.string(from: NSNumber(value: inr!))
                                   let usd = json["USD"]
                                   let eur = json["EUR"]
                                       self.inrLabel.text = ("\(inrPrice!)")
                                       self.isdLabel.text = ("$ \(usd!)")
                                       self.eurLabel.text = ("€ \(eur!)")
                                   
                                       
                                       
                                   }
                                   
                               }
                               
                           }
                       }
                       else
                       {
                           print("It's not working")
                       }
                   }.resume()
               }
    }


    @IBAction func refreshButton(_ sender: Any) {
        getPrice()
    }
}

