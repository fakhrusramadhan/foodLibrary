//
//  WelcomeViewController.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 16/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var sv_welcomeScroll: UIScrollView!
    @IBOutlet weak var pc_pageIndicator: UIPageControl!
    

    @IBOutlet weak var st_loginRegister: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sv_welcomeScroll.delegate = self
        
        let slides:[WelcomePage] = createSlide()
        setupSlideView(slides: slides)
        
        // Scroll View Pagination ini terdapat bug untuk gambar yang menggunakan aspect fill crop
        // solusi menggunakan Page View Controller
        
        pc_pageIndicator.numberOfPages = slides.count
        pc_pageIndicator.currentPage = 0
        
        view.bringSubview(toFront: pc_pageIndicator)
        
        st_loginRegister.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createSlide () -> [WelcomePage] {
        
        let slide1:WelcomePage = Bundle.main.loadNibNamed("WelcomePage", owner: self, options: nil)?.first as! WelcomePage
        
        slide1.lb_pageNumber.text = "Page 1"
        slide1.iv_icon.image = UIImage(named: "ic_pizza");
        slide1.lb_notice.text = "Delicious"
        
        
        let slide2:WelcomePage = Bundle.main.loadNibNamed("WelcomePage", owner: self, options: nil)?.first as! WelcomePage
        
        slide2.lb_pageNumber.text = "Page 2"
        slide2.iv_icon.image = UIImage(named: "ic_coffee");
        slide2.lb_notice.text = "Relaxing"
        
        let slide3:WelcomePage = Bundle.main.loadNibNamed("WelcomePage", owner: self, options: nil)?.first as! WelcomePage
        
        slide3.lb_pageNumber.text = "Page 3"
        slide3.iv_icon.image = UIImage(named: "ic_noodle");
        slide3.lb_notice.text = "Enjoy"
        
        return [slide1, slide2, slide3]
    }
    
    func setupSlideView (slides : [WelcomePage]) {
        sv_welcomeScroll.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        sv_welcomeScroll.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        
        sv_welcomeScroll.isPagingEnabled = true
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            
            sv_welcomeScroll.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        
        pc_pageIndicator.currentPage = Int(pageIndex)
        
        if pageIndex == 2 {
            st_loginRegister.isHidden = false
        }else {
            st_loginRegister.isHidden = true
        }
        
       
    }
    
    
 
    @IBAction func goToLogin(_ sender: Any) {
        performSegue(withIdentifier: "goToLoginFromVC", sender: self)
    }
    
    @IBAction func goToRegister(_ sender: Any) {
        performSegue(withIdentifier: "goToRegisterFromVC", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
