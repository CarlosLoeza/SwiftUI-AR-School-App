//
//  DestinationVM.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/10/24.
//

import SwiftUI

class DestinationVM: ObservableObject {
    @Published var startingPointText = "Select Starting Point"
    @Published var destinationPointText = "Select Destination Point"
    @Published var isStartingButtonClicked = false
    @Published var isDestinationButtonClicked = false
    let lightPurple = Color(red: 92.0/255, green: 89.0/255, blue: 158.0/255)
    let startingPlaceholderText = "Select Starting Point"
    let destinationPlaceholderText = "Select Destination Point"
    let selectText = "Select"
    let classText = "Find Class"
    let size = 32
    
    // this will eventually replace graph[] above
    let updatedGraph: [[Int]] = [ //0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
                                   [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //0
                                   [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //1
                                   [0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //2
                                   [0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //3
                                   [0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //4
                                   [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //5
                                   [0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //6
                                   [0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //7
                                   [0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //8
                                   [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //9
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //10
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //11
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //12
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //13
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //14
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //15
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //16
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //17
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //18
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //19
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0], //20
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], //21
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0], //22
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0], //23
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0], //24
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0], //25
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0], //26
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0], //27
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0], //28
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0], //29
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1], //30
                                   [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0], //31
                                ]
    
    
    let destinations: [String] = [ "-- Select One --",
                                   "Admissions",
                                   "Burk Hall",
                                   "Business",
                                   "Creative Arts",
                                   "Cesar Chavez Student Center",
                                   "Fine Arts",
//                                   "Humanities",
                                   "J. Paul Leonard Library"
                                 ]
    
    // locationVertex is a dictionary which helps translate location name to vertex number.
    // Used for dijkstra algorithm to find shortest path.
    let locationVertex : [String: Int] = [
                            "Admissions": 0,
                            "Burk Hall": 31,
                            "Business": 1,
                            "Creative Arts": 19,
                            "Cesar Chavez Student Center": 13,
                            "Fine Arts": 21,
//                            "Humanities": 0, // change this
                            "J. Paul Leonard Library": 5
                         ]
    
    // find index of vertex with the shortest distance
    func minDistance(dist: [Int], sptSet: [Bool], size: Int)-> Int {
        // min: make it 1000 in order as a placeholder
        // min_index: index of the min index (placeholder:1111)
        var min = 1000
        var min_index = 1111
        
        // find the shortest distance edge and return index of vertex
        for i in 0...size-1 {
            // if not visited yet && shorter path than current min
            if (sptSet[i] == false && dist[i] <= min){
                min = dist[i]
                min_index = i
            }
        }
        return min_index
    }
    
    
    // print the shortest path
    func getPathToDestination(parent: [Int], s: Int, d:Int)->[Int]{
        var parentIndex: Int
        var path: [Int] = []

        // parentIndex contains what vertex is the parent
        parentIndex = d

        // loop until we reach source by the parent vertex
        while (parent[parentIndex] != -1){
            // append parent to path since it is a path to our destination
            path.append(parent[parentIndex])
            parentIndex = parent[parentIndex]
        }
        // reverse will put our path in correct order from finish to start -> start to finish
        path = path.reversed()
        // since our while loop stopped at our source, parent[parentIndex] != -1, it never got appended to path
        path.append(d)
        return path
    }
    
    func findClassAction() -> [Int]{
        var pathResult: [Int] = []
        if startingPointText != startingPlaceholderText && destinationPointText != destinationPlaceholderText {
            
            let startingVertex = locationVertex[startingPointText] ?? -1
            let destinationVertex = locationVertex[destinationPointText] ?? -1
            let startTime = DispatchTime.now()
            pathResult = dijkstra(graph: updatedGraph, src: startingVertex, dest: destinationVertex, size: size)
            let endTime = DispatchTime.now()
            let nanoseconds = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
            let milliseconds = Double(nanoseconds) / 1_000_000
            print("find class: \(pathResult)")
            print("Runtime: \(milliseconds) milliseconds")
            return pathResult
        }
        return []
    }
    
    
    func getSolution(parent: [Int], src: Int, dest: Int, size: Int, distance: [Int]) -> [Int] {
        var currentVertex = dest
        var path: [Int] = []
        while currentVertex != src {
            path.append(currentVertex)
            currentVertex = parent[currentVertex]
            if currentVertex == -1 {
                print("No path exists from \(src) to \(dest)")
            }
        }
        path.append(src)
        let formattedPath = path.map(String.init).joined(separator: " <- ")
        print("Shortest path from \(src) to \(dest): \(formattedPath)")
        print("Shortest distance: \(distance[dest])")
        return path
    }
    
    // Define a priority queue data structure
    struct PriorityQueue<T> {
        var elements: [(T, Int)] = []
        
        mutating func enqueue(_ element: T, priority: Int) {
            elements.append((element, priority))
            elements.sort { $0.1 < $1.1 }
        }
        
        mutating func dequeue() -> T? {
            return elements.isEmpty ? nil : elements.removeFirst().0
        }
        
        var isEmpty: Bool {
            return elements.isEmpty
        }
    }

    // Updated Dijkstra's algorithm using priority queue
    func dijkstra(graph: [[Int]], src: Int, dest: Int, size: Int) -> [Int] {
        var distance = [Int](repeating: Int.max, count: size)
        var parent = [Int](repeating: -1, count: size)
        distance[src] = 0
        var pq = PriorityQueue<Int>()
        pq.enqueue(src, priority: 0)
        
        while !pq.isEmpty {
            guard let minVertex = pq.dequeue() else { break }
            
            for i in 0..<size {
                if graph[minVertex][i] != 0 && distance[minVertex] != Int.max && distance[minVertex] + graph[minVertex][i] < distance[i] {
                    distance[i] = distance[minVertex] + graph[minVertex][i]
                    parent[i] = minVertex
                    pq.enqueue(i, priority: distance[i])
                }
            }
        }
        
        // Printing the solution
        let pathResult = getSolution(parent: parent, src: src, dest: dest, size: size, distance: distance)
        
        return pathResult
    }

}
