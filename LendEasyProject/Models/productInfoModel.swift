//
//  productInfoModel.swift
//  LendEasyProject
//
//  Created by Apple on 2023/10/20.
//

import UIKit
import SwiftyJSON
class productInfoModel: NSObject {
    var pantry : pantryModel?
    var cloud : cloudModel?
    var forthcoming : forthcomingModel?
    var tearing : homeTearingModel?
    var napkin : String?
    init(jsondata: JSON){
        let pantryDic = jsondata["pantry"]
        pantry = pantryModel(jsondata: pantryDic)
        let cloudDic = jsondata["cloud"]
        cloud = cloudModel(jsondata: cloudDic)
        let forthcomingDic = jsondata["forthcoming"]
        forthcoming = forthcomingModel(jsondata: forthcomingDic)
        let tearingDic = jsondata["tearing"]
        tearing = homeTearingModel(jsondata: tearingDic)
        napkin = jsondata["napkin"].stringValue
    }
}

/**************************************************************/
class pantryModel : NSObject {
    var sooner : String?
    var slice : sliceModel?
    init(jsondata: JSON){
        sooner = jsondata["sooner"].stringValue
        let sliceDic = jsondata["slice"]
        slice = sliceModel(jsondata: sliceDic)
    }
}

class sliceModel : NSObject {
    var helplessly : String?
    var stifled : String?
    var mouthful : String?
    var loosening : String?
    var shivered : String?
    var potato : String?
    var repeating : String?
    var beforehand : String?
    var jabbed : String?
    var sobbed : String?
    var smoking : String?
    var hoping : String?
    init(jsondata: JSON){
        helplessly = jsondata["helplessly"].stringValue
        stifled = jsondata["stifled"].stringValue
        mouthful = jsondata["mouthful"].stringValue
        loosening = jsondata["loosening"].stringValue
        shivered = jsondata["shivered"].stringValue
        potato = jsondata["potato"].stringValue
        repeating = jsondata["repeating"].stringValue
        beforehand = jsondata["beforehand"].stringValue
        jabbed = jsondata["jabbed"].stringValue
        sobbed = jsondata["sobbed"].stringValue
        smoking = jsondata["smoking"].stringValue
        hoping = jsondata["hoping"].stringValue
    }
}


/*********************************************************/
class cloudModel : NSObject {
    var sooner : String?
    var sliceArr = [cloudSliceModel]()
    init(jsondata: JSON){
        sooner = jsondata["sooner"].stringValue
        let slices = jsondata["slice"].arrayValue
        for sliceDic in slices {
            let sliceModel : cloudSliceModel = cloudSliceModel(jsondata: sliceDic)
            sliceArr.append(sliceModel)
        }
    }
}

class cloudSliceModel : NSObject {
    var recklessly : String?
    var clamoring : String?
    init(jsondata: JSON){
        recklessly = jsondata["recklessly"].stringValue
        clamoring = jsondata["clamoring"].stringValue
    }
}

/*******************************************************/

class forthcomingModel : NSObject {
    var sooner : String?
    var sliceArr = [forthcomingSliceModel]()
    init(jsondata: JSON){
        sooner = jsondata["sooner"].stringValue
        let slices = jsondata["slice"].arrayValue
        for sliceDic in slices {
            let sliceModel : forthcomingSliceModel = forthcomingSliceModel(jsondata: sliceDic)
            sliceArr.append(sliceModel)
        }
    }
}

class forthcomingSliceModel : NSObject {
    var stories : String?
    var clamoring : String?
    var recklessly : String?
    var disappearing : String?
    var astonishment : String?
    var enjoyment : String?
    init(jsondata: JSON){
        stories = jsondata["stories"].stringValue
        clamoring = jsondata["clamoring"].stringValue
        recklessly = jsondata["recklessly"].stringValue
        disappearing = jsondata["disappearing"].stringValue
        astonishment = jsondata["astonishment"].stringValue
        enjoyment = jsondata["enjoyment"].stringValue
    }
}

/*******************************************************/

class homeTearingModel : NSObject {
    var sooner : String?
    var sliceArr = [tearinSliceModel]()
    init(jsondata: JSON){
        sooner = jsondata["sooner"].stringValue
        let slices = jsondata["slice"].arrayValue
        for sliceDic in slices {
            let sliceModel : tearinSliceModel = tearinSliceModel(jsondata: sliceDic)
            sliceArr.append(sliceModel)
        }
    }
}

class tearinSliceModel : NSObject {
    var amountMax : String?
    var pushing : String?
    var matters : String?
    var productDesc : String?
    var buttonStatus : String?
    var isCopyPhone : String?
    var todayClicked : String?
    var hoping : String?
    var buttoncolor : String?
    var titleText : String?
    var upset : String?
    var sobbed : String?
    var smoking : String?
    var mouthful : String?
    var helplessly : String?
    var loanTermText : String?
    var stifled : String?
    var jabbed : String?
    var buttonExplain : String?
    var expansive : String?
    var thisnx : String?
    var beforehand : String?
    var recklessly : String?
    var loan_rate : String?
    var todayApplyNum : String?
    var potato : String?
    init(jsondata: JSON){
        amountMax = jsondata["amountMax"].stringValue
        pushing = jsondata["pushing"].stringValue
        matters = jsondata["matters"].stringValue
        productDesc = jsondata["productDesc"].stringValue
        buttonStatus = jsondata["buttonStatus"].stringValue
        isCopyPhone = jsondata["isCopyPhone"].stringValue
        todayClicked = jsondata["todayClicked"].stringValue
        hoping = jsondata["hoping"].stringValue
        buttoncolor = jsondata["buttoncolor"].stringValue
        titleText = jsondata["titleText"].stringValue
        upset = jsondata["upset"].stringValue
        sobbed = jsondata["sobbed"].stringValue
        smoking = jsondata["smoking"].stringValue
        mouthful = jsondata["mouthful"].stringValue
        helplessly = jsondata["helplessly"].stringValue
        loanTermText = jsondata["loanTermText"].stringValue
        stifled = jsondata["stifled"].stringValue
        jabbed = jsondata["jabbed"].stringValue
        buttonExplain = jsondata["buttonExplain"].stringValue
        expansive = jsondata["expansive"].stringValue
        thisnx = jsondata["thisnx"].stringValue
        beforehand = jsondata["beforehand"].stringValue
        recklessly = jsondata["recklessly"].stringValue
        loan_rate = jsondata["loan_rate"].stringValue
        todayApplyNum = jsondata["todayApplyNum"].stringValue
        potato = jsondata["potato"].stringValue
    }
}
