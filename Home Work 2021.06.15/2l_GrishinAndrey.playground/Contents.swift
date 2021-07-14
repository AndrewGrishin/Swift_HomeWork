import UIKit

// Написать функцию, которая определяет, четное число или нет.
// оператора % (нахождения остатка от деления не применяется к числам с плавающей точкой)
func isEven(_ number: Double, by: Double = 2) -> Bool {
    return number.truncatingRemainder(dividingBy: 2) == 0
}



isEven(20)
isEven(22.2)
