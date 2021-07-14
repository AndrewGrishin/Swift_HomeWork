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
for i in 0..<array.count {
    // Принудительное извлечение, так как до начала цикла все элементы array не nil
    if (isDivided(array[i]!, by: 2) || !isDivided(array[i]!, by: 3)) {
        array[i] = nil
    }
}

// Освобождение ячеек массива
for _ in 0..<array.count {
    guard let index = array.firstIndex(of: nil) else { break }
    array.remove(at: index)
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
