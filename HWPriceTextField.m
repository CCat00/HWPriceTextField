///////////////////////////////////////////////////////////////////////////////
//
//
//
//
//
////////////////////////////////////////////////////////////////////////////////


#import "HWPriceTextField.h"

@interface HWPriceTextField () <UITextFieldDelegate>

@property (nonatomic, copy) NSMutableString *lastString;

@end


@implementation HWPriceTextField

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self comInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self comInit];
    }
    return self;
}

- (void)comInit
{
    //Delegate
    self.delegate = self;
    //Action
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    //Default is price
    _type = TextFieldTypePrice;
}

#pragma mark - Setter
- (void)setType:(TextFieldType)type
{
    if (_type != type) {
        _type = type;
    }
}

#pragma mark - Action
- (void)textFieldDidChange:(UITextField *)textField
{
    //判断当前字符串和之前的字符串多了什么东西
    //遍历当前字符串
    _lastString = [NSMutableString string];
    
    NSString *str = textField.text;
    if (_lastString.length > textField.text.length) {
        //点击的是删除按钮，不作处理
        return;
    }
    
    for (NSInteger i = _lastString.length; i < str.length; i++) {
        NSRange range = NSMakeRange(_lastString.length, 1);
        NSString *character = [str substringWithRange:range];
        
        if (_type == TextFieldTypePrice)
        {
            //判断是否为价格
            if ([self isPriceString:character]) {
                [_lastString appendString:character];
            }
        }
        else
        {
            if ([self isNumberString:character]) {
                [_lastString appendString:character];
            }
        }
        
    }
    textField.text = _lastString;
}

#pragma mark - Private
- (BOOL)isPriceString:(NSString *)string
{
    if (!([string isEqualToString:@"0"] ||
          [string isEqualToString:@"1"] ||
          [string isEqualToString:@"2"] ||
          [string isEqualToString:@"3"] ||
          [string isEqualToString:@"4"] ||
          [string isEqualToString:@"5"] ||
          [string isEqualToString:@"6"] ||
          [string isEqualToString:@"7"] ||
          [string isEqualToString:@"8"] ||
          [string isEqualToString:@"9"] ||
          [string isEqualToString:@"."]))
    {
        return NO;
    }
    return YES;
}

- (BOOL)isNumberString:(NSString *)string
{
    if (!([string isEqualToString:@"0"] ||
          [string isEqualToString:@"1"] ||
          [string isEqualToString:@"2"] ||
          [string isEqualToString:@"3"] ||
          [string isEqualToString:@"4"] ||
          [string isEqualToString:@"5"] ||
          [string isEqualToString:@"6"] ||
          [string isEqualToString:@"7"] ||
          [string isEqualToString:@"8"] ||
          [string isEqualToString:@"9"]))
    {
        return NO;
    }
    return YES;
}

/**
 *  判断价格的格式
 *  0.00   5.26
 */
- (BOOL)decidePriceTextFormat:(NSString *)priceString
{
    if (priceString.length == 0){return NO;}
    
    //1.先判断是否为一个小数点
    NSArray *arr = [priceString componentsSeparatedByString:@"."];
    if (arr.count > 2) {
        return NO;
    }
    
    //2.小数的位数
    NSRange range = [priceString rangeOfString:@"." options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        NSString *decimalStr = [priceString substringFromIndex:range.location+1];
        if (decimalStr.length > 2) {
            //多于两位小数
            return NO;
        }
        
        //判断小数点前面是否有值
        if (range.location==0) {
            return NO;
        }
    }
    
    BOOL isPureInt = [self isPureInt:priceString];
    BOOL isPureFloat = [self isPureFloat:priceString];
    if (!isPureInt || !isPureFloat) {
        return NO;
    }
    
    //3.是否未零
    CGFloat price = [priceString floatValue];
    if (price == 0) {
        return NO;
    }
    
    return YES;
}

//判断是否为整形
- (BOOL)isPureInt:(NSString*)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
- (BOOL)isPureFloat:(NSString*)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];

}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.mDelegate && [self.mDelegate respondsToSelector:@selector(priceTextFieldEndEditing:isQualified:)]) {
        [self.mDelegate priceTextFieldEndEditing:self isQualified:[self decidePriceTextFormat:textField.text]];
    }
}

@end

