import UIKit

// Задание 1: Написать функцию, которая определяет, четное число или нет.

// оператора % (нахождения остатка от деления) не применяется к числам с плавающей точкой
// Выгоднее использовать метод: .truncatingRemainder(Double) -> Double
func isDivided(_ number: Double, by devider: Double) -> Bool {
    return number.truncatingRemainder(dividingBy: devider) == 0
}

// Задание 2: Написать функцию, которая определяет, делится ли число без остатка на 3.

// Ответ на предыдущее задание походит как для текущей задачи, так и для более общего случая:
// Делится ли число number на число devider без остатка? (Уточнение: оба числа принадлежат множеству вещественных чисел)

// Задание 3: Создать возрастающий массив из 100 чисел.

var array = [Double?]()

for i in 0..<100 {
    array.append(Double(i + 1))
    // для примера можно использовать иррациональные числа вида: pow((1 + 1 / Double(i + 1)), Double(i + 1))
}

// Задание 4: Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

// Удаления элементов (кратных 2-м или не кратных 3-м)
for el in array {
    // Принудительное извлечение, так как до начала цикла все элементы array не nil
    if (isDivided(el!, by: 2) || !isDivided(el!, by: 3)) {
        array.remove(at: array.firstIndex(of: el)!)
    }
}

// Задание 5: Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.

// Функция чисел Фибоначчи получена путем разрешения разностного уравнения с начальными условиями F(0) = 0 F(1) = 1
// Возвращаемый тип Double использован для увеличения разрядности чисел без ошибки переполнения
func addFibonacciNumber(to array: inout [Double?], indexOfNumberInFibonacciSequence n: Int) -> Double {
    let const = 1 / sqrt(5)
    let a = exp(Double(n) * log((1 + sqrt(5)) / 2))
    let b = (n % 2 == 0 ? 1 : -1) * exp(Double(n) * log((sqrt(5) - 1) / 2))
    let newFibonacciNumber = const * (a - b)
    array.append(newFibonacciNumber)
    return newFibonacciNumber
}

for index in 0..<50 {
    addFibonacciNumber(to: &array, indexOfNumberInFibonacciSequence: index)
}

// Задание 6: Вычислить все простые числа в дапазоне [1,n] методом "Решето Эратосфена"

var arrayPrimeNumbers = [Int?]()
let upperLimit: Int = 1000

for i in 2...upperLimit {
    arrayPrimeNumbers.append(i)
}

func eratosthenesSieve(_ arrayAndPValues: ([Int?],Int)) -> ([Int?],Int) {
    var arrayPrimeNumbers: [Int?] = arrayAndPValues.0
    var p: Int = arrayAndPValues.1
    
    for i in stride(from: arrayPrimeNumbers.firstIndex(of: p)! + p, to: arrayPrimeNumbers.count, by: p) {
        arrayPrimeNumbers[i] = nil
    }
    
    let pOldValue: Int = p
    
    for i in arrayPrimeNumbers.firstIndex(of: p)!..<arrayPrimeNumbers.count {
        if let el = arrayPrimeNumbers[i], el > p {
            p = el
            break
        }
    }
    
    guard pOldValue != p else {
        return (arrayPrimeNumbers, p)
    }
    return eratosthenesSieve((arrayPrimeNumbers, p))
    
}

var newArrayPrimeNumbers = eratosthenesSieve((arrayPrimeNumbers,2)).0.filter({$0 != nil})

