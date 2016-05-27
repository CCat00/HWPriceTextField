//
//  PriceTextField.h
//  CustomhouseDriver
//
//  Created by 韩威 on 16/5/27.
//  Copyright © 2016年 AndLiSoft. All rights reserved.
//

#import <UIKit/UIKit.h>



//typedef NS_ENUM(NSInteger, PriceTextFieldType) {
//
//    /**
//     *  Default
//     */
//    PriceTextFieldTypeDefault = 0,
//    /**
//     *  0~9 .
//     */
//    PriceTextFieldTypePrice = 1,
//
//    /**
//     *  0~9
//     */
//    PriceTextFieldTypeNumber = 2,
//};

IB_DESIGNABLE
@interface PriceTextField : UITextField

/**
 Default value is `PriceTextFieldTypePrice`.
 */
//@property (nonatomic, assign) PriceTextFieldType priceTextFieldType;

@property (nonatomic, assign) IBInspectable BOOL isPriceType;

@end
