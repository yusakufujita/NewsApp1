//
//  Page2ViewController.swift
//  NewsApp1
//
//  Created by 藤田優作 on 2020/09/03.
//  Copyright © 2020 藤田優作. All rights reserved.
//
//
//  Page1ViewController.swift
//  NewsApp1
//
//  Created by 藤田優作 on 2020/09/02.
//  Copyright © 2020 藤田優作. All rights reserved.
//

import UIKit
import SegementSlide

class Page6ViewController: UITableViewController,SegementSlideContentScrollViewDelegate,XMLParserDelegate{
    
    //XMLParserのインスタンスを作成
    var parser = XMLParser()
    
    var newsItems = [NewsItems]()
    
    //RSSのパース中の現在の要素名
    var currentElementName:String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .clear
        
        
        //画像を貼る
        let image = UIImage(named: "5.jpg")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height))
        imageView.image = image
        self.tableView.backgroundView = imageView
        
        let urlString:String = "https://news.yahoo.co.jp/rss/topics/local.xml"
        let url:URL = URL(string: urlString)!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        
        //解析スタート(XMLデリゲートメソッドが呼ばれる)
        parser.parse()
        
        // Do any additional setup after loading the view.
    }
    
    @objc var scrollView: UIScrollView {
         
         return tableView
     }
     
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.view.frame.size.height/5
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newsItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.backgroundColor = .clear
        let newsItem = self.newsItems[indexPath.row]
        
        cell.textLabel?.text = newsItem.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 3

        
        cell.detailTextLabel?.text = newsItem.url
        cell.detailTextLabel?.textColor = .white
        
        return cell
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElementName = nil
        if elementName == "item" {
            self.newsItems.append(NewsItems())
        } else {
            currentElementName = elementName
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if self.newsItems.count > 0 {
            
            //1が必ず存在するので、1を引かなくてはいけない
            let lastItem = self.newsItems[self.newsItems.count - 1]
            
            switch self.currentElementName {
                
            case "title":
                lastItem.title = string
            case "link":
                lastItem.url = string
            case "pubDate":
                lastItem.pubDate = string
                print(lastItem.pubDate as Any)
            default:break
            }
        }
    }
    
    //全部読んだ時呼ばれる
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        self.currentElementName = nil
        
    }

    //下まで全部読んだ時呼ばれる

    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //WebViewに取得したURLを表示したい(画面遷移した先で)
        let webViewController:UIViewController = WebViewController()
        
        webViewController.modalTransitionStyle = .crossDissolve
        let newsItem = newsItems[indexPath.row]
        UserDefaults.standard.set(newsItem.url, forKey: "url")
        
        
        self.present(webViewController, animated: true, completion: nil)
        
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
