//
//  ViewController.swift
//  ImgRecoCoreML
//
//  Created by DRUMARE on 13/11/2017.
//  Copyright © 2017 DRUMARE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // create variable pictureImageView and titleLabel
    @IBOutlet weak var pictureImageView:UIImageView!
    @IBOutlet weak var titleLabel:UILabel!
    
    // create the model
    private var model : Inceptionv3 = Inceptionv3()
    
    // import the images
    let images = ["cat.jpg","dog.jpg","rat.jpg","banana.jpg"]
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // create an action by clicking on the Button
    @IBAction func nextButtonPressed(){
        
        // click on Next ~ index+1 ~ from cat.jpg to dog.jpg
        if index > self.images.count-1 {
            index = 0
        }
      
        // load the image as clicking on the Next Button
        let img = UIImage(named:images[index])
        // put the image loaded into pictureImageView
        self.pictureImageView.image = img
        
        // resize the image waited by the model is Image (Color 299 x 299)
        let resizedImage = img?.resizeTo(size:CGSize(width:299,height:299))
        
        //convert the UIImage to a CV pixel buffer (optimize the transfer of the pixel)
        let buffer=resizedImage?.toBuffer()
        
        // pass the image to the model and make the prediction
        let prediction = try! self.model.prediction(image: buffer!)
        
        // the CoreML model return classLabel
        // put classLabel into titleLabel
        self.titleLabel.text=prediction.classLabel
    
        index=index+1
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

