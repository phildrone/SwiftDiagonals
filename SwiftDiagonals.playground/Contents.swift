//: Playground - noun: a place where people can play

import UIKit

/*
 
 This was my favorite question from a recent interview. Given a 2D array like:
 */
let a = [[ 1, 2, 3 ],
         [ 4, 5, 6 ],
         [ 7, 8, 9 ]]
 /*
 Compute an array which is the sum of the entries on the diagonal starting in
 the lower left corner. For the above array it should return:
 
 b = [ 7, 4+8, 1+5+9, 2+6, 3]
   = [ 7, 12, 15, 8, 3]
 
 Great question, clean, concise, and reveals a lot about how the person thinks.
 */


// For my solution I went the direction of functional programming since I was 
// doing it Swift anyway. To start I extended array with a function that returns
// the diagonal from a starting entry.

// This was the only way I could think of to extend an array where each element
// was itself an array that was subscriptable. I wish it were easier to deal
// with all of the Array types in one.
protocol Subscriptable:RandomAccessCollection {
    var count: Int { get }
    subscript(index: Int) -> Iterator.Element { get set }
}
extension Array : Subscriptable {}
extension Array where Element:Subscriptable {
    func diagonal(row:Index, column:Index) -> [Element.Iterator.Element] {
        //if !self.indices.contains(row) { return [] }
        
        var j = column
        var result:[Element.Iterator.Element] = []
        for i in row..<self.count {
            if (j >= self[i].count) { break }
            result.append( self[i][j] )
            j += 1
        }
        return result
    }
}

// with that, I just need to walk up the first column
var results:[Int] = []
for i in (0..<a.count).reversed() {
    results.append( a.diagonal(row:i, column:0).reduce(0,+) )
}
results

// and then down the first row
for j in 1..<a[0].count {
    results.append( a.diagonal(row:0, column: j).reduce(0,+) )
}
results

