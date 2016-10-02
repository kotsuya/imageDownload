//
//  ViewController.swift
//  imageDownload
//
//  Created by Yoo SeungHwan on 2016/10/02.
//  Copyright © 2016年 kotsuya00. All rights reserved.
//

import UIKit

class ViewController: UIViewController/*, URLSessionDownloadDelegate */{
    
    //NSURLConnection -> URLSession
    //AFNetworking -> thirdParty Library
    
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var imgView: UIImageView!
    
    var downloadTask:URLSessionDownloadTask!
    
    @IBAction func downloadAction(_ sender: AnyObject) {
        
        self.imgView.image = nil
        progressView.setProgress(0.0, animated: false)
        indicator.startAnimating()
        
        let sessionConfigration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfigration, delegate: nil/*self*/, delegateQueue: OperationQueue.main)
        
        //1.delegate
//        downloadTask = session.downloadTask(with: URL(string:"https://raw.githubusercontent.com/ChoiJinYoung/iphonewithswift2/master/sample.jpeg")!)
        
        //2.closure -> c,objectiveC:block//javascript:closure
        downloadTask = session.downloadTask(with: URL(string:"https://raw.githubusercontent.com/ChoiJinYoung/iphonewithswift2/master/sample.jpeg")!, completionHandler: {(data,response,error) -> Void in
            
            //self 省略できません
            self.imgView.image = UIImage(data:try! Data(contentsOf: data!))
            self.indicator.stopAnimating()
        
        })
        
        downloadTask.resume()
        
    }
    /*
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let tempProgress:Float = Float(totalBytesWritten/totalBytesExpectedToWrite)
        progressView.setProgress(tempProgress, animated: true)
        
//        print("bytesWritten:\(bytesWritten)")
//        print("totalBytesWritten:\(totalBytesWritten)")
//        print("totalBytesExpectedToWrite:\(totalBytesExpectedToWrite)")
    
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        let tempData:Data = try! Data(contentsOf: location)
        self.imgView.image = UIImage(data: tempData)
        
        indicator.stopAnimating()
    }*/
    
    @IBAction func suspendAction(_ sender: AnyObject) {
        downloadTask.suspend()
    }
    
    @IBAction func resumeAction(_ sender: AnyObject) {
        downloadTask.resume()
    }
    
    @IBAction func cancelAction(_ sender: AnyObject) {
        indicator.stopAnimating()
        progressView.setProgress(0.0, animated: false)
        
        downloadTask.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

