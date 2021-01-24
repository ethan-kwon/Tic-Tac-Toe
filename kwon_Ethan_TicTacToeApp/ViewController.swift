import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Disables all the tic tac toe buttons in the array when view loads
        for button in ticTacToeButtons {
            button.isEnabled = false
        }
        // Disables the new game button when view loads
        newGame.isEnabled = false
        // Hides the turn label when view loads
        labelTurn.isHidden = true
    }
    var playerXTurn: Bool = true
    var playerOTurn: Bool = false
    var playerDidWin: Bool = false
    @IBAction func newGamePressed(_ sender: UIButton) {
        // Sets the image for each button in tic tac toes button array to the default image. Then sets the tag of each button to 0. Changes the title of each button to ""
        for button in ticTacToeButtons {
            button.setImage(UIImage(named: "Default Image"), for: .normal)
            button.tag = 0
            button.setTitle("", for: .normal)
        }
        // Shows the buttons to choose X or O
        for button in choiceOfImage {
            button.isHidden = false
        }
        // Shows the choice label
        labelChoice.isHidden = false
        // Sets the text of the turn label to "Player 1's Turn"
        labelTurn.text = "Player 1's Turn"
        // Hides the turn label
        labelTurn.isHidden = true
        // Disables the new game button
        sender.isEnabled = false
        // Changes playerDidWin to true
        playerDidWin = false
    }
    @IBOutlet var newGame: UIButton!
    @IBOutlet var labelChoice: UILabel!
    @IBOutlet var choiceOfImage: [UIButton]!
    
    @IBAction func choiceOfImagePressed(_ sender: UIButton) {
        // Shows the turn label
        labelTurn.isHidden = false
        // If the title of the button is "ButtonX" playerXTurn is true and playerOTurn is false. Then hides the buttons to choose X or O. Hides choice label. Enables all the buttons in tic tac toe button array
        if sender.title(for: .normal) == "ButtonX" {
            playerXTurn = true
            playerOTurn = false
            for button in choiceOfImage {
                button.isHidden = true
            }
            labelChoice.isHidden = true
            for button in ticTacToeButtons {
                button.isEnabled = true
            }
        }
        // If the title of the button is "ButtonO" playerOTurn is true and playerXTurn is false. Then hides the buttons to choose X or O. Hides choice label. Enables all the buttons in tic tac toe button array.
        else if sender.title(for: .normal) == "ButtonO" {
            playerXTurn = false
            playerOTurn = true
            for button in choiceOfImage {
                button.isHidden = true
            }
            labelChoice.isHidden = true
            for button in ticTacToeButtons {
                button.isEnabled = true
            }
        }
    }
    
    
    @IBOutlet var labelTurn: UILabel!
    
    @IBOutlet var ticTacToeButtons: [UIButton]!
    
    @IBAction func ticTacToeButtonsPressed(_ sender: UIButton) {
        // Runs the checkIfPressedAndChangeImage function for the button pressed
        checkIfPressedAndChangeImage(button: sender)
        // Runs the checkIfWinner function
        checkIfWinner()
    }
    
    func checkIfWinner () {
        // Creates empty string
        var winningPlayer: String = ""
        // winArray is set to the tags of all the possible win lines.
        let winArray = [[ticTacToeButtons[0].tag, ticTacToeButtons[1].tag, ticTacToeButtons[2].tag], [ticTacToeButtons[3].tag, ticTacToeButtons[4].tag, ticTacToeButtons[5].tag], [ticTacToeButtons[6].tag, ticTacToeButtons[7].tag, ticTacToeButtons[8].tag], [ticTacToeButtons[0].tag, ticTacToeButtons[3].tag, ticTacToeButtons[6].tag], [ticTacToeButtons[1].tag, ticTacToeButtons[4].tag, ticTacToeButtons[7].tag], [ticTacToeButtons[2].tag, ticTacToeButtons[5].tag, ticTacToeButtons[8].tag], [ticTacToeButtons[0].tag, ticTacToeButtons[4].tag, ticTacToeButtons[8].tag], [ticTacToeButtons[2].tag, ticTacToeButtons[4].tag, ticTacToeButtons[6].tag]]
        
        // winningLineCheck has two elements that will check for a winning line for X or O.
        let winningLineCheck = [[1, 1, 1], [2, 2, 2]]
        
        var counter = 0
        // Check each button in tic tac toe button array if the current title has a space. If it does, add one to the counter
        for button in ticTacToeButtons {
            if button.currentTitle == " "{
                counter += 1
            }
        }
        
        for index in 0...7 {
            // If there is a line of X's, turn label's text will show "Player 2 Wins!" if the turn label was "Player 1's Turn" or show "Player 1 Wins!" if the turn label was "Player 2's Turn". The empty string will then have the text of who wins.
            if winningLineCheck[0] == winArray[index] {
                // Shows that a player did win and doesn't execute tie
                playerDidWin = true
                if labelTurn.text == "Player 1's Turn" {
                    winningPlayer = "Player 2 Wins!"
                    labelTurn.text = "Player 2 Wins!"
                } else if labelTurn.text == "Player 2's Turn" {
                    winningPlayer = "Player 1 Wins!"
                    labelTurn.text = "Player 1 Wins!"
                }
                // Creates an alert and presents it. Title is Congratulations, and message is the text of who wins
                let alert = UIAlertController(title: "Congratulations", message: winningPlayer, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    switch action.style {
                    case .default:
                        print("default")
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destructive")
                    @unknown default:
                        fatalError()
                    }}))
                self.present(alert, animated: true, completion: nil)
                // New game button is enabled
                newGame.isEnabled = true
                // All buttons in tic tac toe button array are disabled
                for button in ticTacToeButtons {
                    button.isEnabled = false
                }
                break
            }
            // If there is a line of O's, turn label's text will show "Player 2 Wins!" if the turn label was "Player 1's Turn" or show "Player 1 Wins!" if the turn label was "Player 2's Turn". The empty string will then have the text of who wins.
            else if winningLineCheck[1] == winArray[index] {
                // Shows that a player did win and doesn't execute tie
                playerDidWin = true
                if labelTurn.text == "Player 1's Turn" {
                    winningPlayer = "Player 2 Wins!"
                    labelTurn.text = "Player 2 Wins!"
                } else if labelTurn.text == "Player 2's Turn" {
                    winningPlayer = "Player 1 Wins!"
                    labelTurn.text = "Player 1 Wins!"
                }
                // Creates an alert and presents it. Title is Congratulations, and message is the text of who wins
                let alert = UIAlertController(title: "Congratulations", message: winningPlayer, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    switch action.style {
                    case .default:
                        print("default")
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destructive")
                    @unknown default:
                        fatalError()
                    }}))
                self.present(alert, animated: true, completion: nil)
                // New game button is enabled
                newGame.isEnabled = true
                // All the buttons in tic tac toe button array are disabled
                for button in ticTacToeButtons {
                    button.isEnabled = false
                }
                break
            }
        }
        
        // If the counter equals 9 and a player did not win, there is a tie, and will display an alert that says that there was a tie.
        if counter == 9 && playerDidWin == false {
            let alert = UIAlertController(title: "Congratulations", message: "You've finished the game. It's a tie! No one won.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                switch action.style {
                case .default:
                    print("default")
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                @unknown default:
                    fatalError()
                }}))
            self.present(alert, animated: true, completion: nil)
            // New game button is enabled
            newGame.isEnabled = true
            for buttons in ticTacToeButtons {
                buttons.isEnabled = false
            }
        }
    }
    
    
    func checkIfPressedAndChangeImage (button: UIButton) {
        // If there is already an image in the button, an alert box will show and say to choose another space.
        if button.currentImage == UIImage(named: "pictureX") || button.currentImage == UIImage(named: "pictureO") {
            let alert = UIAlertController(title: "Error", message: "Please choose a space that has not been chosen yet.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                switch action.style {
                case .default:
                    print("default")
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                @unknown default:
                    fatalError()
                }}))
            self.present(alert, animated: true, completion: nil)
        }
        // If playerXTurn is true and playerOTurn is false, set the image of the clicked button to an X. Set playerXTurn to false and playerOTurn to true. Changes the text of turn label to the opposite player's turn. Sets clicked button's title to a space and its tag to 1.
       else if playerXTurn == true || playerOTurn == false {
            UIView.transition(with: button, duration: 0.5, options: .transitionCrossDissolve, animations: {
                button.setImage(UIImage(named: "pictureX"), for: .normal)
            })
            playerXTurn = false
            playerOTurn = true
            if labelTurn.text == "Player 1's Turn" {
                labelTurn.text = "Player 2's Turn"
            } else if labelTurn.text == "Player 2's Turn" {
                labelTurn.text = "Player 1's Turn"
            }
            button.setTitle(" ", for: .normal)
            button.tag = 1
        }
        // If playerOTurn is true and playerXTurn is false, set the image of the clicked button to an O. Set playerOTurn to false and playerXTurn to true. Changes the text of turn label to the opposite player's turn. Sets clicked button's title to a space and its tag to 2.
        else if playerXTurn == false || playerOTurn == true {
            UIView.transition(with: button, duration: 0.5, options: .transitionCrossDissolve, animations: {
            button.setImage(UIImage(named: "pictureO"), for: .normal)
            })
            playerXTurn = true
            playerOTurn = false
            if labelTurn.text == "Player 1's Turn" {
                labelTurn.text = "Player 2's Turn"
            } else if labelTurn.text == "Player 2's Turn" {
                labelTurn.text = "Player 1's Turn"
            }
            button.setTitle(" ", for: .normal)
            button.tag = 2
        }
    }
}

