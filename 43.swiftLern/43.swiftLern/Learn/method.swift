//
//  method.swift
//  43.swiftLern
//
//  Created by jackfrow on 2021/4/24.
//

import Foundation


struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}


// 打印“The point is now at (3.0, 4.0)”


class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

class Bicycle: Vehicle {
    
    var test = 0
    
    override init() {
        super.init()
    }
}



class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}


func test3() {
    var playerOne = Player(coins: 100)
    
    print("A new player has joined the game with \(playerOne.coinsInPurse) coins")
    // 打印“A new player has joined the game with 100 coins”
    print("There are now \(Bank.coinsInBank) coins left in the bank")
    // 打印“There are now 9900 coins left in the bank”
}
