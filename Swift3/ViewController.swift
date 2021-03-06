//
//  ViewController.swift
//  Swift3
//
//  Created by Vijayalakshmi Pulivarthi on 19/09/16.
//  Copyright © 2016 sourcebits. All rights reserved.
//
import Alamofire
import UIKit
import CoreData


class ViewController: UIViewController {
    
    var jsonDict: NSDictionary = [:]
    var jsonArray: NSArray = []
    let namesData : NSDictionary = [:]
    var fetchedCards: NSMutableArray = []
    
    lazy var coreDataStack = CoreDataStack()
    var itemsObj = Items()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.callAPIForCards()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.saveDatainDatabase()
        self.fetch()
    }
    func callAPIForCards() -> Void {
        
        // The URL request sent to the server.
        let urlPath = "https://omgvamp-hearthstone-v1.p.mashape.com/cards"
        Alamofire.request(urlPath, method: .get, parameters: nil, headers: ["X-Mashape-Key": "xd90O4gfMdmshyLxk5cBvl44PPHlp1ONA3kjsnFFOAtbQnoshp", "Content-type application":"json"]).responseJSON() { response in
            
            //print(response)
            if let JSON = response.result.value {
                self.jsonDict = (JSON as? NSDictionary)!
                let jsonBasic = self.jsonDict["Basic"]
                //print("Basic..", jsonBasic)
                
                if let blogs = self.jsonDict["Basic"] as? [[String: AnyObject]] {
                    for blog in blogs {
                        if let name = blog["name"] as? String {
                            self.itemsObj.name = name
                        }
                        
                    }
                }
                
           /*   // The URL request sent to the server.
                let urlPathForcardback = "https://omgvamp-hearthstone-v1.p.mashape.com/cardbacks"
                Alamofire.request(urlPathForcardback, method: .get, parameters: nil, headers: ["X-Mashape-Key": "xd90O4gfMdmshyLxk5cBvl44PPHlp1ONA3kjsnFFOAtbQnoshp", "Content-type application":"json"]).responseJSON() { response in
                    
                    //print(response)
                    
                    // getting details one by one
                    _ = Items()
                    
                    for its in (response.result.value as? [Dictionary<String,AnyObject>])! {
                        
                        print("cardBackId....", its["cardBackId"] as? String)
                        print("name....", its["name"] as? String)
                    }
                }
                
                // The URL request sent to the server.
                let urlPathForInfo = "https://omgvamp-hearthstone-v1.p.mashape.com/info"
                Alamofire.request(urlPathForInfo, method: .get, parameters: nil, headers: ["X-Mashape-Key": "xd90O4gfMdmshyLxk5cBvl44PPHlp1ONA3kjsnFFOAtbQnoshp", "Content-type application":"json"]).responseJSON() { response in
                    
                    //print(response)
                    
                    //to get status code
                    if let status = response.response?.statusCode {
                        switch(status){
                        case 201:
                            print("success")
                        default:
                            print("error with response status: \(status)")
                        }
                    }
                    if let JSON = response.result.value {
                        self.jsonDict = (JSON as? NSDictionary)!
                        print("classes..",self.jsonDict["classes"])
                        print("sets..",self.jsonDict["sets"])
                        print("standard..",self.jsonDict["standard"])
                        print("wild..",self.jsonDict["wild"])
                        print("types..",self.jsonDict["types"])
                        print("factions..",self.jsonDict["factions"])
                        print("qualities..",self.jsonDict["qualities"])
                        print("races..",self.jsonDict["races"])
                        print("locales..",self.jsonDict["locales"])
                    }
                    
                } */
            }
        }
    }
    
    // Mark - save in database
    
    func saveDatainDatabase() {
        
        let moc = self.coreDataStack.persistentContainer.viewContext
        let allcardsNames = AllCards(context: moc)
        allcardsNames.setValue(self.itemsObj.name, forKey: "name")
        do {
            try moc.save()
            print("saved Successfully")
            //self.fetch()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
    }

    // Mark - Fetch All cards
    
    func fetch() {
        let moc = self.coreDataStack.persistentContainer.viewContext
        let personFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "AllCards")
        
        do {
            let fetchedPerson = try moc.fetch(personFetch) as! [AllCards]
            //print("name..",fetchedPerson.first?.name)
            for cards in fetchedPerson {
                print("elements..", cards.name)
            }
        } catch {
            fatalError("Failed to fetch person: \(error)")
        }
    }
    
    
}

