import UIKit

// Priority Queue
// Full binary tree

class Queue<T> {
    private var queue: [T]
    private let condition: (T,T) -> Bool
    
    init(elements: [T], queueType condition: @escaping (T,T) -> Bool ) {
        self.queue = []
        self.condition = condition
        self.generateQueue(elements)
    }
    
    private func generateQueue(_ elements: [T]) {
        for element in elements {
            insert(element)
        }
    }
    
    func insert(_ element: T) {
        self.queue.append(element)
        var childInd = self.queue.count - 1
        
        while self.condition(self.queue[childInd],self.queue[childInd / 2]) && childInd != 0 {
            let a = self.queue[childInd]
            self.queue[childInd] = self.queue[childInd / 2]
            self.queue[childInd / 2] = a
            
            childInd /= 2
        }
    }
    
    func popZeroIndexElement() -> T? {
        guard self.queue.count > 0 else {
            return nil
        }
        let extracted = self.queue[0]
        self.queue[0] = self.queue.removeLast()
        
        var parentInd = 0
        while 2 * parentInd + 1 < self.queue.count || (parentInd + 1) * 2 < self.queue.count {
            if 2 * parentInd + 1 < self.queue.count && (parentInd + 1) * 2 >= self.queue.count {
                if self.condition(self.queue[2 * parentInd + 1],self.queue[parentInd]) {
                    let a = self.queue[2 * parentInd + 1]
                    self.queue[2 * parentInd + 1] = self.queue[parentInd]
                    self.queue[parentInd] = a
                
                    parentInd = 2 * parentInd + 1
                }
            } else {
                if self.condition(self.queue[2 * parentInd + 1],self.queue[(parentInd + 1) * 2]) {
                    if self.condition(self.queue[2 * parentInd + 1],self.queue[parentInd]) {
                        let a = self.queue[2 * parentInd + 1]
                        self.queue[2 * parentInd + 1] = self.queue[parentInd]
                        self.queue[parentInd] = a
                        
                        parentInd = 2 * parentInd + 1
                    }
                } else {
                    if self.condition(self.queue[(parentInd + 1) * 2],self.queue[parentInd]) {
                        let a = self.queue[(parentInd + 1) * 2]
                        self.queue[(parentInd + 1) * 2] = self.queue[parentInd]
                        self.queue[parentInd] = a
                        
                        parentInd = (parentInd + 1) * 2
                    }
                }
            }
        }
        
        return extracted
    }
    
    func filter(by condition: (T) -> Bool) {
        let newQueue = self.queue.filter(condition)
        self.empty()
        self.generateQueue(newQueue)
    }
    
    func empty() {
        self.queue = []
    }
    
    func getZeroIndexElement() -> T? {
        return self.queue.count > 0 ? self.queue[0] : nil
    }
    
    func getQueue() -> [T] {
        return self.queue
    }
    
    func count() -> Int {
        return self.queue.count
    }
    
    subscript(_ indxes: Int ...) -> [T?] {
        get {
            var array = [T?]()
            for ind in indxes {
                if !(abs(ind) < self.queue.count || ind == -self.queue.count) {
                    array.append(nil)
                } else {
                    array.append(ind < 0 ? self.queue[self.queue.count + ind] : self.queue[ind])
                }
            }
            return array
        }
    }
    subscript(_ range: ClosedRange<Int>) -> [T?] {
        get {
            var array = [T?]()
            for ind in range {
                if !(abs(ind) < self.queue.count || ind == -self.queue.count) {
                    array.append(nil)
                } else {
                    array.append(ind < 0 ? self.queue[self.queue.count + ind] : self.queue[ind])
                }
            }
            return array
        }
    }
}

let maxHeapCondtion: (Double,Double) -> Bool = { $0 >= $1 }
let minHeapCondition: (Double,Double) -> Bool = { $0 <= $1 }

var maxQueue = Queue<Double>(elements: [1,3,5,7,9,8,6,4,2], queueType: maxHeapCondtion)
print(maxQueue.getQueue())
print(maxQueue.popZeroIndexElement() ?? "Nothing to print")
print(maxQueue.getQueue())
maxQueue.filter{ $0.truncatingRemainder(dividingBy: 2) == 0.0 }
print(maxQueue.getQueue())
print(maxQueue.popZeroIndexElement() ?? "Nothing to print")
print(maxQueue.getQueue())
print(maxQueue[0,1,2,-1,-2,-3,-4,20,-20,-5])
print(maxQueue[0...2])
print(maxQueue[2...3])
