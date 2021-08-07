//
//  ViewController.swift
//  pathodev1
//
//  Created by erdem öden on 26.07.2021.
//

import UIKit
import SDWebImage
import CoreData
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //var data : [String:[Any]]? = ["image":[],"name":[],"dateofbirth":[],"actor":[]];
    var harryarray = [harrypotter]()
    var favarray = [Favourites]()
    var imgstring:String = ""
    var row = 0;
    var olusdu = false;
    //let control = kontrol();
    public static var data2 = [Dictionary<String,Any>]();
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        apicall()
        if let navigationBar = self.navigationController?.navigationBar {
            let firstFrame = CGRect(x: navigationBar.frame.width/2-120, y: navigationBar.frame.height/2-15, width: 240, height: 30)

            let firstLabel = UILabel(frame: firstFrame)
            firstLabel.text = "HARRY POTTER"
            firstLabel.font = UIFont.systemFont(ofSize:30,weight: .black)
            navigationBar.addSubview(firstLabel)
        }
//        let appdelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appdelegate.persistentContainer.viewContext
//        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favs")
//        fetch.returnsObjectsAsFaults = false
//        do{
//            let results = try context.fetch(fetch)
//            for result in results as! [NSManagedObject]{
//                context.delete(result)
//            }
//            do{
//                try context.save()
//            }
//            catch{
//                print("error")
//            }
//        }
//        catch{
//            print("error")
//        }
        
    }
    func apicall(){
        let url = URL(string: "http://hp-api.herokuapp.com/api/characters")!
        let request = URLSession.shared.dataTask(with: url){(data,response,error) in 
            if(error != nil){
                let alert = UIAlertController(title: "HATA", message: "Bir Hata İle Karşılaştık", preferredStyle: UIAlertController.Style.alert)
                let action = UIAlertAction(title: "TAMAM", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(action);
                self.present(alert, animated: true, completion: nil)
            }
            else{
                if(data != nil){
                    do{
                        self.harryarray = try JSONDecoder().decode([harrypotter].self, from: data!)
                        DispatchQueue.main.async { [self] in
                            let appdelegate = UIApplication.shared.delegate as! AppDelegate
                            let context = appdelegate.persistentContainer.viewContext
                            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favs")
                            fetch.returnsObjectsAsFaults = false
                            do{
                               let results = try context.fetch(fetch)
                                for result in results as![NSManagedObject]{
                                    if(result.value(forKey: "image") != nil){
                                    let Forward = Favourites(character: (result.value(forKey: "image") as! String))
                                        favarray.append(Forward)
                                        print(result.value(forKey: "image"))
                                        
                                    }
                                }
                            }
                            catch{
                                print("error")
                            }
                            self.tableview.reloadData()
                        }
                    }
                    catch{
                        print("error")
                    }
                }
            }
        }
        request.resume()
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return harryarray.count
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? cellTableViewCell
        if(harryarray.count > 0){
            let gec = NSURL(string: harryarray[indexPath.row].image);
            cell?.resim.sd_setImage(with: gec as URL?, placeholderImage: UIImage(named:"select"), options: SDWebImageOptions.progressiveLoad, completed: nil)
        cell?.name.text = harryarray[indexPath.row].name
            cell?.dateofbirth.text = harryarray[indexPath.row].dateOfBirth
            cell?.actor.text = harryarray[indexPath.row].actor
            
            cell?.heartbut.character = harryarray[indexPath.row].name
//            if(favarray.count > indexPath.row){
//                if(favarray[indexPath.row].character == cell?.heartbut.character){
//                    cell?.heartbut.setImage(UIImage(named: "heart-red"), for: .normal)
//                }
//            }
//            else{
//                cell?.heartbut.setImage(UIImage(named: "heart-empty"), for: .normal)
//            }
            var sender = Favourites(character: cell?.heartbut.character)
            if favarray.contains(sender){
                cell?.heartbut.setImage(UIImage(named: "heart-red"), for: .normal)
            }
            else{
                cell?.heartbut.setImage(UIImage(named: "heart-empty"), for: .normal)
            }
//            if(favarray.count > 0){
//                for i in favarray.indices{
//                    if(cell?.heartbut.character == favarray[i].character){
//                        cell?.heartbut.setImage(UIImage(named: "heart-red"), for: .normal)
//                    }
//                }
//            }
//            if(favarray[indexPath.row]?.image != "empty" && favarray[indexPath.row]?.image != "red"){
//                cell?.heartbut.setImage(UIImage(named: "heart-empty"), for: .normal)
//                cell?.heartbut.addTarget(self, action: #selector(clicked), for: .touchUpInside)
//                cell?.heartbut.tag = indexPath.row
//                print(cell?.heartbut.tag)
//            }
//            else if (favarray[indexPath.row]?.image == "empty"){
//                cell?.heartbut.setImage(UIImage(named: "heart-empty"), for: .normal)
//                cell?.heartbut.addTarget(self, action: #selector(clicked), for: .touchUpInside)
//                cell?.heartbut.tag = indexPath.row
//                print(cell?.heartbut.tag)
//            }
//            else if(favarray[indexPath.row]?.image == "red"){
//                cell?.heartbut.setImage(UIImage(named: "heart-red"), for: .normal)
//                cell?.heartbut.addTarget(self, action: #selector(clicked), for: .touchUpInside)
//                cell?.heartbut.tag = indexPath.row
//                print(cell?.heartbut.tag)
//            }
            
            cell?.heartbut.addTarget(self, action: #selector(clicked), for: .touchUpInside)
            }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row = indexPath.row
        tableview.deselectRow(at: indexPath, animated: true)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let second = storyBoard.instantiateViewController(withIdentifier: "tosecondvc") as! secondvc
        second.modalPresentationStyle = .fullScreen
        second.delegate = self
        second.actorname = harryarray[row].actor
        second.namename = harryarray[row].name
        second.birth = harryarray[row].dateOfBirth
        second.imagename = harryarray[row].image
        let favs = Favourites(character: harryarray[row].name)
        if(favarray.contains(favs)){
            second.fav = "it is in your favourites"
            second.imagename2 = "heart-red"
        }
        else{
            second.fav = "it is not in your favourites"
            second.imagename2 = "heart-empty"
        }
        navigationController?.pushViewController(second, animated: true)
        
        //performSegue(withIdentifier: "tosecond", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "tosecond"){
            if let object = segue.destination as? secondvc{
                object.imagename = harryarray[row].image
                object.actorname = harryarray[row].actor
                object.birth = harryarray[row].dateOfBirth
                object.namename = harryarray[row].name
                let favs = Favourites(character: harryarray[row].name)
                if(favarray.contains(favs)){
                    object.fav = "it is in your favourites"
                    object.imagename = "heart-red"
                }
                else{
                    object.fav = "it is not in your favourites"
                    object.imagename = "heart-empty"
                }
                object.delegate = self
//                if (favarray.count > 0){
//                for i in favarray.indices{
//                    if(favarray[i].character == harryarray[row].name){
//                        object.fav = "it is in your favourites"
//                    }
//                    else if (favarray[i].character != harryarray[row].name && i == favarray.count-1){
//                        object.fav = "it is not in your favourites"
//                        print(favarray[i].character)
//                    }
//                }
//                }
//                else{
//                    object.fav = "it is not in your favourites"
//                }
//                if(favarray[row]?.image != "red" && favarray[row]?.image != "empty"){
//                    object.fav = "it is not in your favourites"
//                    print(row)
//                }
//                else if(favarray[row]?.image == "red"){
//                    object.fav = "it is in your favourites"
//                    print(row)
//                }
//                else if (favarray[row]?.image == "empty"){
//                    object.fav = "it is not in your favourites"
//                    print(row)
//                }
               
            }
        }
    }
    @objc func clicked(sender:SubclassedUIButton){
            var IsRed = false
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appdelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.insertNewObject(forEntityName: "Favs", into: context);
        if(favarray.count > 0){
        for i in favarray.indices{
            
            if(favarray[i].character == sender.character){
                UIView.animate(withDuration: 0.5, animations: {
                                sender.transform = CGAffineTransform(scaleX: 2, y: 2)
                                sender.setImage(UIImage(named: "heart-empty"), for: .normal)
                            }, completion: {
                                done in
                                if done {
                                    UIView.animate(withDuration: 0.5, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                
                                }
                            })
                favarray.remove(at: i);
                let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favs")
                fetch.predicate = NSPredicate(format: "image == %@", sender.character)
                            fetch.returnsObjectsAsFaults = false
                    do{
                                let results = try context.fetch(fetch)
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
                            catch{
                                print("error")
                            }
                
            }
            if(i == favarray.count - 1 && favarray[i].character != sender.character){
                let fav = Favourites(character: sender.character);
                favarray.append(fav);
                entity.setValue(sender.character, forKey: "image")
                
                do{
                    try context.save()
                }
                catch{
                    print("error")
                }
                
                print("boş-dolu")
                UIView.animate(withDuration: 0.5, animations: {
                                sender.transform = CGAffineTransform(scaleX: 2, y: 2)
                                sender.setImage(UIImage(named: "heart-red"), for: .normal)
                            }, completion: {
                                done in
                                if done {
                                    UIView.animate(withDuration: 0.5, animations: {
                                        sender.transform = CGAffineTransform.identity
                                    })
                
                                }
                            })
            }
            
            
        }
            
        }
        else{
            let fav = Favourites(character: sender.character);
            favarray.append(fav);
            entity.setValue(sender.character, forKey: "image")
            
            do{
                try context.save()
            }
            catch{
                print("error")
            }
            UIView.animate(withDuration: 0.5, animations: {
                            sender.transform = CGAffineTransform(scaleX: 2, y: 2)
                            sender.setImage(UIImage(named: "heart-red"), for: .normal)
                        }, completion: {
                            done in
                            if done {
                                UIView.animate(withDuration: 0.5, animations: {
                                    sender.transform = CGAffineTransform.identity
                                })
            
                            }
                        })
            print("boş")
        }
        
//        if(favarray[sender.tag]?.image != "red" && favarray[sender.tag]?.image != "empty"){
//            let entity = NSEntityDescription.insertNewObject(forEntityName: "Favs", into: context)
//            entity.setValue(sender.tag, forKey: "row")
//            entity.setValue("red", forKey: "image")
//            let gonder = Favourites(row: sender.tag, image: "red");
//            favarray[sender.tag] = gonder
//            do{
//                try context.save()
//            }
//            catch{
//                print("error")
//            }
//            UIView.animate(withDuration: 0.5, animations: {
//                sender.transform = CGAffineTransform(scaleX: 2, y: 2)
//                sender.setImage(UIImage(named: "heart-red"), for: .normal)
//            }, completion: {
//                done in
//                if done {
//                    UIView.animate(withDuration: 0.5, animations: {
//                        sender.transform = CGAffineTransform.identity
//                    })
//
//                }
//            })
//            print("merhaba")
//        }
//        else if(favarray[sender.tag]?.image == "empty" && favarray[sender.tag]?.image != "red"){
//            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favs")
//            fetch.predicate = NSPredicate(format: "row = %i", sender.tag as Int)
//            fetch.returnsObjectsAsFaults = false
//            do{
//                let results = try context.fetch(fetch)
//                for result in results as! [NSManagedObject]{
//                    result.setValue("red", forKey: "image")
//                }
//                do{
//                    try context.save()
//                }
//                catch{
//                    print("error")
//                }
//            }
//            catch{
//                print("error")
//            }
//            UIView.animate(withDuration: 0.5, animations: {
//                sender.transform = CGAffineTransform(scaleX: 2, y: 2)
//                sender.setImage(UIImage(named: "heart-red"), for: .normal)
//            }, completion: {
//                done in
//                if done {
//                    UIView.animate(withDuration: 0.5, animations: {
//                        sender.transform = CGAffineTransform.identity
//                    })
//
//                }
//            })
//            favarray[sender.tag]?.image = "red"
//            favarray[sender.tag]?.row = sender.tag
//            print("merhaba2")
//        }
//
//        else if(favarray[sender.tag]?.image == "red" && favarray[sender.tag]?.image != "empty"){
//            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favs")
//            fetch.predicate = NSPredicate(format: "row == %i",sender.tag)
//            fetch.returnsObjectsAsFaults = false
//            do{
//                let results = try context.fetch(fetch)
//                if(results.count > 0 ){
//                for result in results as! [NSManagedObject]{
//                    result.setValue("empty", forKey: "image")
//                }
//                try context.save()
//
//            }
//                else{
//                    print("olmadı")
//                }
//            }
//            catch{
//                print("error")
//            }
//
//            favarray[sender.tag]?.image = "empty"
//            favarray[sender.tag]?.row = sender.tag
//            UIView.animate(withDuration: 0.5, animations: {
//                sender.transform = CGAffineTransform(scaleX: 2, y: 2)
//                sender.setImage(UIImage(named: "heart-empty"), for: .normal)
//            }, completion: {
//                done in
//                if done {
//                    UIView.animate(withDuration: 0.5, animations: {
//                        sender.transform = CGAffineTransform.identity
//                    })
//
//                }
//            })
//            print("merhaba3")
//
//        }
   }
}
extension ViewController:GoingBackFromDetail{
    func UpdateTable() {
        favarray.removeAll()
        apicall()
    }
    
        
    }

