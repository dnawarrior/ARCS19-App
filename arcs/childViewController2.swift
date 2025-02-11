//
//  ChildViewController2.swift
//  testest
//
//  Created by Aakarsh S on 07/01/19.
//  Copyright © 2019 Aakarsh. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ChildViewController2: UIViewController, IndicatorInfoProvider ,UICollectionViewDataSource,UICollectionViewDelegate{
    
   

    @IBOutlet weak var collectionDay2: UICollectionView!
    var events:[String]=[]
    var eventName:[String] = []
    var iconName:[String] = []
    var timings:[String]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchFirebaseData()
    }
    func fetchFirebaseData(){
        (UIApplication.shared.delegate as! AppDelegate).ref1.child("timelineIOS").child("Day2").observe(.value) { (snapshot) in
            let value=snapshot.value as? NSDictionary
           
            self.events=value?.allKeys as! [String]
            self.events = self.events.sorted()
            
            for name in self.events
            {
                (UIApplication.shared.delegate as! AppDelegate).ref1.child("timelineIOS").child("Day2").child(name).observe(.value, with: { (snapshot1) in
                    let value1 = snapshot1.value as? NSDictionary
                    
                    self.eventName.append(value1?["name"] as! String)
                    self.timings.append(value1?["time"] as! String)
                    self.iconName.append(value1?["icon"] as! String)
                    
                    
                    
                    (UIApplication.shared.delegate as! AppDelegate).ref1.keepSynced(true)
                    print(self.eventName)
                    self.collectionDay2.reloadData()
                    
                })
                
                
                
                
            }
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventName.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID1", for: indexPath) as! scheduleCollectionViewCell
        cell.eventTitle.text?=eventName[indexPath.row]
        
        cell.eventImage.image=UIImage(named: iconName[indexPath.row])
        cell.eventTiming.text?=timings[indexPath.row]
        //This creates the shadows and modifies the cards a little bit
        
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.masksToBounds = false
        
        
        return cell
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title:"Day 2")
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
