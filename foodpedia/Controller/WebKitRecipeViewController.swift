//
//  WebKitRecipeViewController.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 10/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

import UIKit
import WebKit

class WebKitRecipeViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate {
    
    var foodName : String?
    
    @IBOutlet weak var wk_searchRecipe: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        urlTextField.delegate = self
        wk_searchRecipe.navigationDelegate = self
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear( animated )
        
        let keyword = "\(self.foodName!)+recipe"
        let trimmedString = keyword.replacingOccurrences(of: " ", with: "+")


        let urlString = "http://www.google.com/search?q=\(trimmedString)"
        print("\(urlString)")
        
        let myURL = URL(string: urlString)!
        let myRequest = URLRequest(url: myURL)
        print("\(myRequest)")
        wk_searchRecipe.load(myRequest)
        
        urlTextField.text = urlString
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString:String = urlTextField.text!
        let url:URL = URL(string: urlString)!
        let urlRequest:URLRequest = URLRequest(url: url)
        wk_searchRecipe.load(urlRequest)
        
        textField.resignFirstResponder()
        
        return true
    }
    
 
    @IBAction func backButtonWebKit(_ sender: Any) {
        
        wk_searchRecipe.goBack()
        print("back button pressed")
        

    }
    
    @IBAction func forwardButtonWebKit(_ sender: Any) {
        
        wk_searchRecipe.goForward()
        print("forward button pressed")
        
        
    }
    

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = wk_searchRecipe.canGoBack
        forwardButton.isEnabled = wk_searchRecipe.canGoForward
        
        urlTextField.text = wk_searchRecipe.url?.absoluteString
    }

}

