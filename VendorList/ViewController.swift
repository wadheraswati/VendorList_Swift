//
//  ViewController.swift
//  VendorList
//
//  Created by Swati Wadhera on 10/10/17.
//  Copyright © 2017 Swati Wadhera. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let vendorCellIdentifier : String = "vendorCell"
    var activity = UIActivityIndicatorView()
    var vendorList : [vendor] = []
    var tableView = UITableView()
    var imageCache : [String : UIImage] = [:]
    
    override func viewDidLoad() {
            
        tableView.frame = CGRect(x : 0, y: 0, width : self.view.bounds.size.width, height: self.view.bounds.size.height)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(vendorCell.self, forCellReuseIdentifier: vendorCellIdentifier)
        self.view.addSubview(tableView)
        
//        let clickBtn = UIButton(type : .custom)
//        clickBtn.frame = CGRect(origin: CGPoint(x:0, y:0), size: CGSize(width: 100, height: 50))
//        clickBtn.titleLabel!.font = UIFont.boldSystemFont(ofSize: 15)
//        clickBtn.setTitle("Click Me!", for: .normal)
//        clickBtn.setTitleColor(UIColor.purple, for: UIControlState.normal)
//        clickBtn.addTarget(self, action: #selector(pressed(_:)), for: UIControlEvents.touchUpInside)
//        clickBtn.backgroundColor = UIColor.black
//        clickBtn.center = self.view.center;
//        self.view.addSubview(clickBtn)
        
        activity.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        activity.center = self.view.center
        activity.activityIndicatorViewStyle = .gray
        self.view.addSubview(activity)
        activity.startAnimating()
        tableView.isHidden = true;
        getVendorList()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func getVendorList() {
        //var url : String = "https://developmentwow.wedmegood.com/api/v1/vendor/filter?category=1&version=1.4&limit=25&offset=0&filter=1&random=7084&source=3&city=17&token=59a6b90593be35.76231701"
        //url = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        //var request = URLRequest(url: URL(string: url)!)
        //request.httpMethod = "GET"
        
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let todoEndpoint: String = "https://developmentwow.wedmegood.com/api/v1/vendor/filter?category=1&version=1.4&limit=25&offset=0&filter=1&random=7084&source=3&city=17&token=59a6b90593be35.76231701"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print("error calling GET")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? NSDictionary else {
                        print("error trying to convert data to JSON")
                        return
                }

                
                
                // now we have the todo
                // let's just print it to prove we can access it
                print("The todo is: " + todo.description)

                if let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let results : [[String : Any]] = json!["data"] as! [[String : Any]]
                    for result in results {
                        let restaurant = vendor(json: result)
                        self.vendorList.append(restaurant)
                        print(result)
                    }
                    DispatchQueue.main.async{
                        self.tableView.isHidden = false;
                        self.activity.stopAnimating()
                        self.tableView.reloadData()
                    }
                }
                
                //print("Data items count: \(dataArray.count)")
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
//                guard let todoTitle = todo["title"] as? String else {
//                    print("Could not get todo title from JSON")
//                    return
//                }
//                print("The title is: " + todoTitle)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()

        
        

    }
    
    // MARK : UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: vendorCellIdentifier, for: indexPath) as! vendorCell
        
        cell.coverPicImgV.contentMode = .scaleAspectFill
        cell.nameLbl.text = vendorList[indexPath.row].name
        cell.cityLbl.text = vendorList[indexPath.row].city
        let price : String = vendorList[indexPath.row].price
        cell.priceLbl.text = "₹ \(price)"
        
        let image : UIImage! = imageCache["\(indexPath.row)"]
        // reset reused cell image to placeholder
        cell.coverPicImgV.image = UIImage(named: "lehenga")
        
        // async image
        if image == nil {
            
            var todoEndpoint : String = vendorList[indexPath.row].imgUrl
            todoEndpoint = todoEndpoint.replacingOccurrences(of: "%%", with: "570")
            guard let url = URL(string: todoEndpoint) else {
                print("Error: cannot create URL")
                return UITableViewCell()
            }
            let urlRequest = URLRequest(url: url)
            let session = URLSession.shared
            let task = session.dataTask(with: urlRequest) { data, response, error in
                if let data = data {
                    self.imageCache["\(indexPath.row)"] = UIImage(data : data)
                    DispatchQueue.main.async{
                        cell.coverPicImgV.image = UIImage(data: data)
                    }
                }
            }
            task.resume()

        }
        else{
            cell.coverPicImgV.image = image
        }
        
        cell.layoutSubviews()
        
        return cell
        //return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return self.vendorList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height : CGFloat = 9/16
        return (tableView.bounds.size.width*height + 100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func pressed(_ sender : AnyObject) {
        print("Hello")
    }


}

