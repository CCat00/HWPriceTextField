//
//  PriceTextField.m
//  CustomhouseDriver
//
//  Created by 韩威 on 16/5/27.
//  Copyright © 2016年 AndLiSoft. All rights reserved.
//

#import "PriceTextField.h"

#define myDotNumbers        @"0123456789.\n"
#define myNumbers           @"0123456789\n"

@interface PriceTextField () <UITextFieldDelegate>

@end

@implementation PriceTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    //    self.priceTextFieldType = PriceTextFieldTypePrice;
    self.isPriceType = YES;
    //    self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.delegate = self;
}


#pragma mark - setter

//- (void)setPriceTextFieldType:(PriceTextFieldType)priceTextFieldType {
//    _priceTextFieldType = priceTextFieldType;
//    if (_priceTextFieldType == PriceTextFieldTypePrice) {
//        self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    } else if (_priceTextFieldType == PriceTextFieldTypeNumber) {
//        self.keyboardType = UIKeyboardTypeNumberPad;
//    } else {
//        self.keyboardType = UIKeyboardTypeDefault;
//    }
//}

- (void)setIsPriceType:(BOOL)isPriceType {
    _isPriceType = isPriceType;
    
    if (_isPriceType) {
        self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    } else {
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *cs;
    if (!_isPriceType) {
        cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if (!basicTest) {
            [self showMsg:@"只能输入数字"];
            return NO;
        }
    }
    else {
        NSUInteger nDotLoc = [textField.text rangeOfString:@"."].location;
        if (NSNotFound == nDotLoc && 0 != range.location) {
            cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
        }
        else {
            cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
        }
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if (!basicTest) {
            [self showMsg:@"只能输入数字和小数点"];
            return NO;
        }
        if (NSNotFound != nDotLoc && range.location > nDotLoc + 2) {
            [self showMsg:@"小数点后最多两位"];
            return NO;
        }
    }
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0) {
        return;
    }
    
    if (_isPriceType) {
        if (![textField.text checkIsFloat]){
            [self showMsg:@"价格格式不正确!"];
            textField.text = nil;
        }
        else
        {
            NSString *floatStr = [NSString stringWithFormat:@"%.2f",[textField.text floatValue]];
            textField.text = floatStr;
        }
    } else {
        if (![textField.text checkIsInteger]) {
            [self showMsg:@"格式不正确!"];
            textField.text = nil;
        }
    }
    
    //    if (!_isPriceType) {
    //        return;
    //    }
    //    //处理 00000.8 ==>  0.80
    //    if (![textField.text checkIsFloat]) {
    //        return;
    //    }
    //
    //    NSString *floatStr = [NSString stringWithFormat:@"%.2f",[textField.text floatValue]];
    //
    //    textField.text = floatStr;
}


#pragma mark - private

- (void)showMsg:(NSString *)msg {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}


@end
