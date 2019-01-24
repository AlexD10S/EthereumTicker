//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/ETH"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencySymbol = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var finalURL = ""
    var symbol = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        finalURL = baseURL + currencyArray[0]
        symbol = currencySymbol[0]
        var emptyDictionary = [String: String]()
        getAPIData(url: finalURL, parameters: emptyDictionary)
        
       
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    //When the currency is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = baseURL + currencyArray[row]
        symbol = currencySymbol[row]
        var emptyDictionary = [String: String]()
        getAPIData(url: finalURL, parameters: emptyDictionary)
    }
    
    

    
    func getAPIData(url: String, parameters: [String : String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    let responseJSON : JSON = JSON(response.result.value!)

                    self.updatePrice(json: responseJSON)

                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Error with the server connection"
                }
            }

    }

    
    
    
    func updatePrice(json : JSON) {
       let result = json["last"].stringValue
       print("here")
       self.bitcoinPriceLabel.text = symbol + " " + result

        
//        if let tempResult = json["main"]["temp"].double {
//
//        weatherData.temperature = Int(round(tempResult!) - 273.15)
//        weatherData.city = json["name"].stringValue
//        weatherData.condition = json["weather"][0]["id"].intValue
//        weatherData.weatherIconName =    weatherData.updateWeatherIcon(condition: weatherData.condition)
//        }
//
//        updateUIWithWeatherData()
    }
    




}

