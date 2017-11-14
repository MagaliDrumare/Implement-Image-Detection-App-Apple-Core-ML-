
 ![alt tag](https://www.dropbox.com/s/uc97kzfdtwnsxwv/test.gif?dl=0)

# A voir et à savoir : 
* Core ML est le nouveau framework de machine learning d'Apple. 
* Core ML permet aux développeurs d'intégrer de manière simple et facile des modèles de machine learning entrainés
  dans leurs applications. 
* Core ML cible les applications fonctionnant sur des périphériques Apple (y compris iOS, watchOS, macOS et tvOS).
* Core ML models : https://developer.apple.com/machine-learning/
* Core ML démos : https://github.com/likedan/Awesome-CoreML-Models
* A Guide to Core ML on iOS by Siraj Raval : https://youtu.be/T4t73CXB7CU
* Mastering Core ML for iOS on Udemy by Mohammad Azam : http://bit.ly/2ADSykK


# Implement Image detection App Using Apple CoreML 
* load Inception v3 from https://developer.apple.com/machine-learning/
*  Inception v3 detects the dominant objects present in an image from a set of 1000 categories such as trees, animals, food, vehicles, people, and more.
* step 1 : drag and drop Inceptionv3.mlmodel inside the repository
* step 2 : create the UX interface in  Main.storyboard
* step 3 : implement the following code in ViewController.swift

```swift

//  Created by DRUMARE on 13/11/2017.
//  Credits : Mohammad Azam

// ViewController.swift
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
```
