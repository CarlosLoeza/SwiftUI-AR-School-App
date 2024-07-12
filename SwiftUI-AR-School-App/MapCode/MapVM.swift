//
//  MapVM.swift
//  SwiftUI-AR-School-App
//
//  Created by Carlos on 3/11/24.
//


import SwiftUI
import MapKit

struct Locations: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

class MapVM: ObservableObject {
    @Published var vPath : [Locations] = []
    let size = 32
    var path : [Int] = []
    
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
    
    let locations = [
        Locations(name: "Admissions", coordinate: CLLocationCoordinate2D(latitude: 37.721500, longitude: -122.476796)), //0
        Locations(name: "Business", coordinate: CLLocationCoordinate2D(latitude: 37.721540, longitude: -122.476963)),   //1
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.721614, longitude: -122.477128)),           //2
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.721517, longitude: -122.477228)),           //3
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.721606, longitude: -122.477456)),           //4
        Locations(name: "J. Paul Leonard Library", coordinate: CLLocationCoordinate2D(latitude: 37.721662, longitude: -122.477724)), //5
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.721695, longitude: -122.477275)),           //6
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.721751, longitude: -122.477425)),           //7
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.721785, longitude: -122.477626)),           //8
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.721812, longitude: -122.477962)),           //9
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.721941, longitude: -122.477988)),           //10
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.722142, longitude: -122.478017)),           //11
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.722147, longitude: -122.478211)),           //12
        Locations(name: "Cesar Chavez Student Center", coordinate: CLLocationCoordinate2D(latitude: 37.722159, longitude: -122.478459)), //13
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.721810, longitude: -122.478289)),           //14
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.721805, longitude: -122.478608)),           //15
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.721768, longitude: -122.479000)),           //16
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.721807, longitude: -122.479179)),           //17
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.721754, longitude: -122.479203)),           //18
        Locations(name: "Creative Arts", coordinate: CLLocationCoordinate2D(latitude: 37.721797, longitude: -122.479372)), //19
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.721920, longitude: -122.478940)),           //20
        Locations(name: "Fine Arts", coordinate: CLLocationCoordinate2D(latitude: 37.721964, longitude: -122.479100)),  //21
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.722024, longitude: -122.478895)),           //22
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.722123, longitude: -122.479024)),           //23
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.722220, longitude: -122.479157)),           //24
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.722314, longitude: -122.479107)),           //25
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.722421, longitude: -122.479055)),           //26
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.722527, longitude: -122.478991)),           //27
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.722558, longitude: -122.479136)),           //28
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.722558, longitude: -122.479307)),           //29
        Locations(name: "", coordinate: CLLocationCoordinate2D(latitude: 37.722717, longitude: -122.479372)),           //30
        Locations(name: "Burk Hall", coordinate: CLLocationCoordinate2D(latitude: 37.722847, longitude: -122.479420)),  //31
    ]
    let destinations: [String] = [ "-- Select One --",
                                   "Admissions",
                                   "Burk Hall",
                                   "Business",
                                   "Creative Arts",
                                   "Cesar Chavez Student Center",
                                   "Fine Arts",
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
                            "J. Paul Leonard Library": 5
                         ]
    
    func findClassRoute(startingPointText: String, destinationPointText: String, currentLocation: CLLocationCoordinate2D?) -> [Locations]{
        var pathResult: [Locations] = []
        let startingVertex : Int
    
        
        print("location: \(currentLocation)")
        if currentLocation == nil {
            startingVertex = locationVertex[startingPointText] ?? -1
        } else {
            startingVertex = findClosestLocationIndex(to: CLLocationCoordinate2D(latitude: 37.722421, longitude: -122.479055), from: locations) ?? -1
            print("sVertex: \(startingVertex)")
 
        }
        
        let destinationVertex = locationVertex[destinationPointText] ?? -1
        print("starting: \(startingVertex)")
        print("destination: \(destinationPointText)")
        let startTime = DispatchTime.now()
        pathResult = dijkstra(graph: updatedGraph, src: startingVertex, dest: destinationVertex, size: size)
        let endTime = DispatchTime.now()
        let nanoseconds = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
        let milliseconds = Double(nanoseconds) / 1_000_000
//            print("find class: \(pathResult)")
        print("Runtime: \(milliseconds) milliseconds")
        return pathResult
 
    }

    func findClosestLocationIndex(to userLocation: CLLocationCoordinate2D, from locations: [Locations]) -> Int? {
        guard !locations.isEmpty else { return nil }
        
        var closestIndex: Int?
        var smallestDistance: CLLocationDistance = .greatestFiniteMagnitude
        
        let userCLLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        
        for (index, location) in locations.enumerated() {
            let locationCLLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let distance = userCLLocation.distance(from: locationCLLocation)
            
            if distance < smallestDistance {
                smallestDistance = distance
                closestIndex = index
            }
        }
        
        return closestIndex
    }


    
    func getPath(parent: [Int], src: Int, dest: Int, size: Int, distance: [Int]) -> [Locations] {
        var currentVertex = dest
        var path: [Locations] = []
        while currentVertex != src {
            path.insert(locations[currentVertex], at: 0)
            currentVertex = parent[currentVertex]
            if currentVertex == -1 {
                print("No path exists from \(src) to \(dest)")
            }
        }
        path.insert(locations[src], at: 0)
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
    func dijkstra(graph: [[Int]], src: Int, dest: Int, size: Int) -> [Locations] {
        print("source \(src)")
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
        let pathResult = getPath(parent: parent, src: src, dest: dest, size: size, distance: distance)
        
        return pathResult
    }
    
    @available(iOS 17.0, *)
    func decideAnnotationType(i: Int)-> Annotation<Text, some View>{
        if (i == 0) {
            return Annotation(vPath[i].name, coordinate: vPath[i].coordinate,
                        anchor: .bottom
            ) {
                Image(systemName: "building.2.crop.circle.fill")
                    .padding (4)
                    .foregroundStyle(.white)
                    .background(Color.indigo)
                    .cornerRadius (5)
            }
        } else if (i == vPath.count-1) {
            return Annotation(vPath[i].name, coordinate: vPath[i].coordinate,
                        anchor: .bottom
            ) {
                Image(systemName: "building.2.crop.circle.fill")
                    .padding (4)
                    .foregroundStyle(.white)
                    .background(Color.indigo)
                    .cornerRadius (5)
            }
        } else {
            return Annotation( "", coordinate: vPath[i].coordinate,
                        anchor: .bottom
            ) {
                Image(systemName: "figure.walk.circle.fill")
                    .padding (4)
                    .foregroundStyle(.white)
                    .background(Color.yellow)
                    .cornerRadius (15)
            }
        }
    }
}

