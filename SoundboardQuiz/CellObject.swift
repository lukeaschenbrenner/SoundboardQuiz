//
//  CellObject.swift
//  SoundboardQuiz
//
//  Created by Luke A Aschenbrenner on 4/27/23.
//

import Foundation

public class CellObject{
    public var cellID: Int
    public var cellName: String
    
    init(cellID: Int, cellName: String) {
        self.cellID = cellID
        self.cellName = cellName
    }
}
