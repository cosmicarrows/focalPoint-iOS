//
//  ViewController.swift
//  focalPoint
//
//  Created by Laurence Wingo on 10/23/17.
//  Copyright © 2017 Laurence Wingo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabel: UILabel!
    var fishImageView: UIImageView!
    var bikerImageView: UIImageView!
    var skyImageView: UIImageView!
    
    let questions: [String] = ["Where did we first meet?", "Why is this so complicated?", "What's the answer to get her to love you?"]
    
    let answers: [String] = ["10 10th Street", "Because she IS love", "Let her go"]
    
    var currentQuestionIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.cyan
        currentQuestionLabel.text = questions[currentQuestionIndex]
        
        //add sky image to the background of the screen
        let skyImageName = "bert.png"
        let skyImage = UIImage.init(named: skyImageName)
        //skyImage?.withHorizontallyFlippedOrientation()
        //skyImageView = UIImageView.init(image: skyImage)
        //view.addSubview(skyImageView)
        view.backgroundColor = UIColor.init(patternImage: skyImage!)
        
        //add electric car image to the screen
        let fishImageName = "elecar.png"
        let fishImage = UIImage.init(named: fishImageName)
        fishImageView = UIImageView.init(image: fishImage)
        let fishImageFrame = CGRect.init(x: self.view.center.x - 200, y: self.view.center.y + 270, width: 150, height: 100)
        fishImageView.frame = fishImageFrame
        view.addSubview(fishImageView)
        
        //add motorcycle image to the screen
        let motorcycleImageName = "fish.png"
        let motoImage = UIImage.init(named: motorcycleImageName)
        bikerImageView = UIImageView.init(image: motoImage)
        let bikerImageFrame = CGRect.init(x: self.view.center.x, y: self.view.center.y + 303, width: 150 / 1.5, height: 100 / 1.5)
        bikerImageView.frame = bikerImageFrame
        view.addSubview(bikerImageView)
        
        //creating bubbles from tapping the screen
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(createBubble))
        singleTap.numberOfTapsRequired = 1
        fishImageView.isUserInteractionEnabled = true
        fishImageView.addGestureRecognizer(singleTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nextQuestionLabel.alpha = 0
        //answerLabel.alpha = 0
    }

    func animateLabelTransitions(){
        //UIView.animate(withDuration: 3.5, animations: { self.currentQuestionLabel.alpha = 0; self.nextQuestionLabel.alpha = 1})
        
        UIView.animate(withDuration: 2.5, delay: 0, options: [], animations: {self.currentQuestionLabel.alpha = 0; self.nextQuestionLabel.alpha = 1}, completion: {_ in swap(&self.currentQuestionLabel, &self.nextQuestionLabel)})
    }
    
    @IBAction func showNextQuestion(sender: AnyObject) {
        currentQuestionIndex+=1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    //function on how to create bubbles and add them to the screen
    @objc func createBubble() {
        let bubblePictureFileName = UIImage.init(named: "bubble.png")
        let bubbleImageView = UIImageView.init(image: bubblePictureFileName)
        bubbleImageView.frame = CGRect.init(x: self.fishImageView.frame.width / 10, y: self.fishImageView.frame.origin.y, width: 25, height: 25)
        view.addSubview(bubbleImageView)
        
        //start defining the bubble animation here
        let zigzagPath = UIBezierPath.init()
        let oX: CGFloat = bubbleImageView.frame.origin.x
        let oY: CGFloat = bubbleImageView.frame.origin.y
        let eX: CGFloat = oX
        let eY: CGFloat = oY - 200
        let t: CGFloat = 40
        let cp1: CGPoint = CGPoint.init(x: oX - t, y: ((oY + eY) / 2))
        let cp2: CGPoint = CGPoint.init(x: oX + t, y: cp1.y)
        //the movePoint method sets the starting point of the bezier line
        zigzagPath.move(to: CGPoint.init(x: oX, y: oY))
        //add the end point and the control points
        zigzagPath.addCurve(to: CGPoint.init(x: eX, y: eY), controlPoint1: cp1, controlPoint2: cp2)
        
        let pathAnimation: CAKeyframeAnimation = CAKeyframeAnimation.init(keyPath: "position")
        pathAnimation.duration = 2
        pathAnimation.path = zigzagPath.cgPath
        pathAnimation.fillMode = kCAFillModeForwards
        pathAnimation.isRemovedOnCompletion = false
        bubbleImageView.layer.add(pathAnimation, forKey: "movingAnimation")
        
        
    }
    
}

