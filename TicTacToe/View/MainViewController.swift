//
//  ViewController.swift
//  TicTacToe
//
//  Created by Jane Zhu on 12/31/21.
//

import UIKit

class MainViewController: UIViewController, TicTacToeModelDelegate {

    // MARK: IBOutlets
    @IBOutlet private weak var bottomLabel: UILabel!
    @IBOutlet private weak var restartButton: UIButton!
    @IBOutlet private var allGameButtons: [GameButton]!

    // MARK: Properties
    private var game: TicTacToeModel!
    private var currentPlayerString: String {
        return "\(game.currentPlayer.properName),\nit's your turn 🙂"
    }

    // MARK: Object Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        game = TicTacToeModel()
        game.delegate = self

        setUpViews()
    }

    // MARK: IBActions
    @IBAction func pressGameButton(sender button: GameButton) {
        button.isEnabled = false
        button.setTitle(game.currentPlayer.rawValue, for: .normal)
        button.setTitleColor(game.currentPlayer.color, for: .disabled)
        game.player(didChoose: (button.row, button.column))
    }

    @IBAction func pressRestartButton() {
        game.reset()
        setUpViews()
    }

    // MARK: Private Methods
    private func setUpViews() {
        allGameButtons.forEach{
            $0.isEnabled = true
            $0.setTitleColor(.black, for: .disabled)
            $0.setTitle("", for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: 90)
        }
        bottomLabel.text = currentPlayerString
    }

    // MARK: TicTacToeModelDelegate
    func gameContinues(with nextPlayer: TicTacToeModel.Player) {
        bottomLabel.text = currentPlayerString
    }

    func gameOver(winner: TicTacToeModel.Player?) {
        allGameButtons.forEach { $0.isEnabled = false }
        if let winner = winner {
            bottomLabel.text = "\(winner.properName.capitalized),\nYOU WIN! 🎉"
        } else {
            bottomLabel.text = "DRAW! Play again?"
        }
    }
}
