//
//  secondvc.swift
//  pathodev1
//
//  Created by erdem öden on 2.08.2021.
//

import UIKit
import SDWebImage
import CoreData
protocol GoingBackFromDetail{
    func UpdateTable();
}
class secondvc: UIViewController {
    var imagename = "";
    var actorname = "";
    var namename = "";
    var birth = "";
    var fav = "";
    var delegate : GoingBackFromDetail!
    var imagename2 = "";
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var actor: UILabel!
    @IBOutlet weak var dateofbirth: UILabel!
    @IBOutlet weak var favorite: UILabel!
    @IBOutlet weak var heartbut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gec = NSURL(string: imagename);

        image.sd_setImage(with: gec as URL?, placeholderImage: UIImage(named:"select"), options: SDWebImageOptions.progressiveLoad, completed: nil)
        name.text = namename
        actor.text = actorname;
        dateofbirth.text = birth
        favorite.text = fav
        heartbut.setImage(UIImage(named:imagename2), for: .normal)
        
    }
    @IBAction func HeartAction(_ sender: Any) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Favs", into: context)
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favs")
        fetch.predicate = NSPredicate(format: "image == %@",name.text!)
        do{
        let results = try context.fetch(fetch)
            if(results.count > 0){
                UIView.animate(withDuration: 0.5, animations: { [self] in
                                heartbut.transform = CGAffineTransform(scaleX: 2, y: 2)
                                heartbut.setImage(UIImage(named: "heart-empty"), for: .normal)
                            }, completion: {
                                done in
                                if done {
                                    UIView.animate(withDuration: 0.5, animations: { [self] in
                                        heartbut.transform = CGAffineTransform.identity
                                    })
                
                                }
                            })
                favorite.text = "it is not in your favourites"
            for result in results as! [NSManagedObject]{
                context.delete(result)
            }
                do{
                    try context.save()
                }
                catch{
                    print("error")
                }
            }
            else{
                UIView.animate(withDuration: 0.5, animations: { [self] in
                                heartbut.transform = CGAffineTransform(scaleX: 2, y: 2)
                                heartbut.setImage(UIImage(named: "heart-red"), for: .normal)
                            }, completion: {
                                done in
                                if done {
                                    UIView.animate(withDuration: 0.5, animations: { [self] in
                                        heartbut.transform = CGAffineTransform.identity
                                    })
                
                                }
                            })
                favorite.text = "it is in your favourite"
                entity.setValue(name.text, forKey: "image")
            }
            do{
                try context.save()
            }
            catch{
                print("error")
            }
        }
        catch{
            print("error")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate.UpdateTable()
    }
    @objc func goback(){
        print("merhaba")
    }
}
