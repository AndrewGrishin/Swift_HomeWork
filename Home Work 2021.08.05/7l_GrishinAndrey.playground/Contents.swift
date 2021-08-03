import UIKit

enum ArrayErrors: Error {
    case indexOutOfRange
    case indexLessThanZero
}

// Задание 1: Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?.
// Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.

class Array<T> {
    private var array = [T]()
    
    init(fillArrayWith sequence: [T]) {
        self.array = sequence
    }
    
    func getElement(at index: Int) -> (T?,ArrayErrors?) {
        if index >= self.array.count {
            return (nil, ArrayErrors.indexOutOfRange)
        }
        if index < 0 {
            return (nil, ArrayErrors.indexLessThanZero)
        }
        return (self.array[index],nil)
    }
    
    subscript(_ indexes: ClosedRange<Int>) -> ([T]?,ArrayErrors?) {
        get {
            var elementToReturn = [T]()
            for index in indexes {
                if index < 0 {
                    return (nil,ArrayErrors.indexLessThanZero)
                }
                if index >= self.array.count {
                    return (nil,ArrayErrors.indexOutOfRange)
                }
                elementToReturn.append(self.array[index])
            }
            return (elementToReturn,nil)
        }
    }
}

let array = Array<Int>(fillArrayWith: [4,6,1,8,9,6,0,1])
let range = -1...5
let index = 6

if let element = array.getElement(at: index).0 {
    print("At index \(index) is \(element)")
} else if let element = array.getElement(at: index).1 {
    print("Exception occured: \(element)")
}


if let newArray = array[range].0 {
    print("Got new array: \(newArray)")
} else if let error = array[range].1 {
    print("Exception occured: \(error)")
}

print()
// Задание 2: Придумать класс, методы которого могут выбрасывать ошибки.
// Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

enum SongErrors: Error {
    case invalidDuration(song: String, artist: String)
}

enum PersonErrors: Error {
    case invalidAge(of: String)
}

enum PeopleErrors: Error {
    case notListed(person: String)
}

struct Song: CustomStringConvertible {
    let title: String
    let artist: String
    let duration: Double
    let genre: String
    
    var description: String {
        var length: String {
            get {
                return "\(Int(self.duration)) min. \(Int(self.duration.truncatingRemainder(dividingBy: 1) * 100)) sec."
            }
        }
        return "Title: \(self.title)\nArtist: \(self.artist)\nDuration: \(length)\nGenre: \(self.genre)"
    }
    
    init(title: String, artist: String, duration: Double, genre: String) throws {
        guard duration >= 0 else {
            throw SongErrors.invalidDuration(song: title, artist: artist)
        }
        self.title = title
        self.artist = artist
        self.duration = duration
        self.genre = genre
    }
}

struct Person: CustomStringConvertible {
    let name: String
    let age: Int
    let favoriteSongs: [Song]?
    
    var description: String {
        var a =  "Personal Infomation\nName: \(self.name)\nAge: \(self.age)"
        
        guard let songs = self.favoriteSongs else {
            return a
        }
        
        a += "\nSongs Information\n"
        for song in songs {
            a = a + song.description + "\n\n"
        }
        a += "---"
        
        return a
    }
    
    init(name: String, age: Int, favoriteSongs: [Song]) throws {
        guard age >= 0 else {
            throw PersonErrors.invalidAge(of: name)
        }
        self.name = name
        self.age = age
        self.favoriteSongs = favoriteSongs
    }
    
}

class People {
    private var peopleList: [Person]
    
    init(_ peopleList: [Person] = []) {
        self.peopleList = peopleList
    }
    
    private func isListed(_ name: String) -> Int? {
        let names = self.peopleList.map{ $0.name }
        for (ind,el) in names.enumerated() {
            if name == el {
                return ind
            }
        }
        return nil
    }
    
    func getList() -> [Person] {
        return self.peopleList
    }
    
    func listIn(_ people: Person ...) {
        for person in people {
            self.peopleList.append(person)
        }
    }
    
    func getFavoriteSongs(of name: String) throws -> [Song]? {
        guard let indexOrPerson = isListed(name) else {
            throw PeopleErrors.notListed(person: name)
        }
        return self.peopleList[indexOrPerson].favoriteSongs
    }
}

// Примеры работы написанного выше.

var people = People()

do {
    let jodie = try Person(name: "Jodie",
                           age: 19,
                           favoriteSongs: [
                            Song(title: "Believe", artist: "Elton John", duration: 4.56, genre: "Pop"),
                            Song(title: "Already Gone", artist: "Eagles", duration: 6.31, genre: "Rock"),
                            Song(title: "Listen to your heart", artist: "Roxette", duration: 5.28, genre: "Rock"),
                            Song(title: "Hotel California", artist: "Eagles", duration: 4.15, genre: "Rock"),
                            Song(title: "Fall of the Empire", artist: "Accept", duration: 5.45, genre: "Metal"),
                            Song(title: "Suspicious Minds",artist: "Elvis Presley", duration: 4.23, genre: "Rock"),
                            Song(title: "Dragula", artist: "Rob Zombie", duration: 3.43, genre: "Hard Rock")
                           ])
    let sofi = try Person(name: "Sofi",
                          age: 19,
                          favoriteSongs: [
                            Song(title: "Watching the planes go by", artist: "Elton John",duration: 4.10, genre: "Rock"),
                            Song(title: "Take on me", artist: "A-ha",duration: 3.04, genre: "Pop"),
                          ])
    let robert = try Person(name: "Robert",
                            age: 19,
                            favoriteSongs: [
                                Song(title: "The Curse",artist: "Accept", duration: 5.53, genre: "Alternative"),
                                Song(title: "Poison", artist: "Alice Cooper",duration: 4.30, genre: "Hard Rock")
                            ])
    
    people.listIn(jodie,sofi,robert)
    
} catch let error {
    print("Exception occured: \(error)")
}

do {
    let songs = try people.getFavoriteSongs(of: "Jodie") ?? []
    for song in songs {
        print(song,"\n")
    }
    print("---\n")
} catch let error {
    print(error)
}

do {
    let songs = try people.getFavoriteSongs(of: "Alice") ?? []
    for song in songs {
        print(song,"\n")
    }
} catch let error {
    print(error)
}
