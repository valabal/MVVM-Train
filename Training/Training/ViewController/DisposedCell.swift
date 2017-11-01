//
//  DisposedCell.swift
//  Training
//
//  Created by Fransky on 11/1/17.
//  Copyright © 2017 Emveep. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DisposedCell : UITableViewCell {
    
    private(set) var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag() // because life cicle of every cell ends on prepare for reuse
    }

}
