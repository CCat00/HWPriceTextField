
////////////////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TextFieldType) {
    TextFieldTypePrice,
    TextFieldTypeNum,
};

////////////////////////////////////////////////////////////////////////////////

@class HWPriceTextField;
@protocol HWPriceTextFieldDelegate <NSObject>

/**
 *  结束编辑的时候会调用这个方法
 *
 *  @param priceTextField   self
 *  @param m_isQualified    价格是否是正确的格式 (YES 为正确的格式)
 */
- (void)priceTextFieldEndEditing:(HWPriceTextField *)priceTextField isQualified:(BOOL)m_isQualified;

@end

////////////////////////////////////////////////////////////////////////////////

@interface HWPriceTextField : UITextField

@property (nonatomic, weak) id <HWPriceTextFieldDelegate> mDelegate;

/**
 *  输入的类型 (默认是价格类型)
 *  TextFieldTypePrice  价格类型，包含'0~9'和'.'
 *  TextFieldTypeNum    数量类型，包含'0~9'
 */
@property (nonatomic) TextFieldType type;

@end
