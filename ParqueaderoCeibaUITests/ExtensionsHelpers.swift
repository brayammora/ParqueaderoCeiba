//
//  ExtensionsHelpers.swift
//  ParqueaderoCeibaUITests
//
//  Created by Brayam Alberto Mora Arias - Ceiba Software on 8/09/20.
//  Copyright © 2020 Brayam Alberto Mora Arias - Ceiba Software. All rights reserved.
//

import XCTest

extension XCUIElement
{
    enum SwipeDirection {
        case left, right
    }

    func longSwipe(_ direction : SwipeDirection) {
        let startOffset: CGVector
        let endOffset: CGVector

        switch direction {
        case .right:
            startOffset = CGVector.zero
            endOffset = CGVector(dx: 0.85, dy: 0.0)
        case .left:
            startOffset = CGVector(dx: 0.85, dy: 0.0)
            endOffset = CGVector.zero
        }

        let startPoint = self.coordinate(withNormalizedOffset: startOffset)
        let endPoint = self.coordinate(withNormalizedOffset: endOffset)
        startPoint.press(forDuration: 0, thenDragTo: endPoint)
    }
}
