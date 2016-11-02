//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var state = ""
    let images = [#imageLiteral(resourceName: "hangman1.gif"), #imageLiteral(resourceName: "hangman2.gif"), #imageLiteral(resourceName: "hangman3.gif"), #imageLiteral(resourceName: "hangman4.gif"), #imageLiteral(resourceName: "hangman5.gif"), #imageLiteral(resourceName: "hangman6.gif"), #imageLiteral(resourceName: "hangman7.gif")]
    var numIn = 0
    var abs = ""
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var CurrentState: UITextField!
    @IBOutlet weak var Guess: UITextField!
    @IBOutlet weak var Check: UITextField!
    var final = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        abs = phrase!
        // Do any additional setup after loading the view.
        state = GetState(phrase: phrase!)
        CurrentState.text = state
        Image.image = images[numIn]
        Guess.text = String(numIn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Reset(_ sender: UIButton) {
        final = false
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        abs = phrase!
        // Do any additional setup after loading the view.
        state = GetState(phrase: phrase!)
        CurrentState.text = state
        numIn = 0
        Image.image = images[numIn]
        Guess.text = String(numIn)
    }
    

    
    @IBAction func UPDATE(_ sender: UIButton) {
        if final{
            Annoy()
            return
        }
        let new = UpdateState(Actual: abs, Curr: state, letter: Check.text!)
        if new == CurrentState.text {
            numIn += 1
            Guess.text = String(numIn)
            Image.image = images[numIn]
            if numIn > 5{
                GameLoss()
            }
        }
            
        else{
            CurrentState.text = new
            state = new
            if CurrentState.text?.range(of: "_") == nil{
                GameWin()
            }
        }
    }
    
    func Annoy(){
        let alert = UIAlertController(title: "The Game has already ended.", message: "Please Press Start Over to Play Again", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

    
    
    func GameLoss(){
        // create the alert
        final = true
        let alert = UIAlertController(title: "You Lost", message: "The Answer was " + abs + ". Please Press Start Over to Try Again", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func GameWin() {
        // create the alert
        final = true
        let alert = UIAlertController(title: "Congradulations, you won.", message: "If you like to play again, press Start Over", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func GetState(phrase:String) -> String{
        var Cur = ""
        for character in phrase.characters {
            if character == " "{
                Cur.append(" ")
            }
            else{
                Cur.append("_")
            }
        }
        return Cur
    }
    func UpdateState(Actual:String, Curr:String, letter:String) -> String{
        var indexs = [Int]()
        var count = 0
        for character in Actual.characters {
            if character == " "{
                count += 1
                continue
            }
            else if character == letter[letter.startIndex]{
                indexs.append(count)
            }
            count = count + 1
        }
        var want = NSMutableString(string: Curr)
        for i in indexs{
            let todo = NSMakeRange(i, 1)
            want.replaceCharacters(in: todo, with: String(letter[letter.startIndex]))
        }
        return want as String
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
