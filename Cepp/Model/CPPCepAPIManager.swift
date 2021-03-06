 //
//  CPPCepAPIManager.swift
//  Cepp
//
//  Created by Filipe Alvarenga on 14/11/14.
//  Copyright (c) 2014 Filipe Alvarenga. All rights reserved.
//

import UIKit

class CPPCepAPIManager {
    
    let apiManager = AFHTTPRequestOperationManager()
    let baseURL = "http://cep.correiocontrol.com.br/%@.json"
    
    func getAddressWithCep(cep: String, success: (JSONAddress: AnyObject!) -> Void, failure: (error: NSError!) -> Void) -> Void {
        //Adding the parameter CEP to the baseURL
        let requestURL = String(format: self.baseURL, cep)
        //Calling the GET method of AFNetworking through the manager
        self.apiManager.GET(requestURL, parameters: nil,success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
            //The closure below allow us to get the responseObject where the method was called
            success(JSONAddress: responseObject)
        }) {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            //The closure below allow us to get the error where the method was called
            failure(error: error)
        }
    }
    
     func geocodeAddress(address: CPPAddress!, callback: (placemark: SVPlacemark!) -> Void) -> Void {
        //Configuring the completeAddress variable
        var completeAddress = address.streetAddress + ", " + address.city + ", " + address.state
        
        //Calling the SVGeocoder method to geocode the address
        SVGeocoder.geocode(completeAddress, completion: { (placemarks, urlResponse, error) -> Void in
            if ((error) != nil) {
                //TODO: Treat error
                NSLog("Geocode error")
            }
            //Getting the placemark and passing by parameter on the callback method
            var placemark: SVPlacemark = placemarks[0] as! SVPlacemark
            callback(placemark: placemark)
        })
    }
    
}
