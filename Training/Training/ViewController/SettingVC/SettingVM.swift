//
//  SettingVCM.swift
//  Training
//
//  Created by Fransky on 11/1/17.
//  Copyright © 2017 Emveep. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


protocol SettingVMInputs {
}

protocol SettingVMOutputs {
 }

protocol SettingVMType {
    var inputs: SettingVMInputs { get  }
    var outputs: SettingVMOutputs { get }
}


class SettingVM : SettingVMType, SettingVMInputs, SettingVMOutputs{

    public var inputs: SettingVMInputs { return self }
    public var outputs: SettingVMOutputs { return self }
    
    private let disposeBag = DisposeBag()
    private let error = PublishSubject<Swift.Error>()
    
    public var sceneCoordinator: SceneCoordinatorType!
    

}




