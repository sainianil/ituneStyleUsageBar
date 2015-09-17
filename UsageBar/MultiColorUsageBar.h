//
//  MultiColorUsageBar.h
//  UsageBarDemo
//
//  Created by Anil Saini on 9/8/15.
//  Copyright (c) 2015. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MultiColorUsageBarValue : NSObject
{
    double usageValue;
    NSString *categoryName;
    NSColor *color;
}
/* usageValue: usage value is value of the category i.e.
 if 4 GB of storage is used by images category then usageValue = 4 */
@property (nonatomic) double usageValue;
/* categoryName: category name is Images, Video, Apps and Free for storage. */
@property (nonatomic) NSString *categoryName;
/* color: fill color of category, usage bar fill the category with the provided color */
@property (nonatomic) NSColor *color;

- (instancetype)initWithUsageValue:(double)inUsageValue categoryName:(NSString*)inCategoryName color:(NSColor*)inColor;

@end

/* MultiColorUsageBarToolTipDelegate: provides option to customized tooltip. */
@protocol MultiColorUsageBarToolTipDelegate <NSObject>

- (NSString*)stringForToolTip;

@end

IB_DESIGNABLE
@interface MultiColorUsageBar : NSView

/* delegate: tooltip delegate is responsible for providing tool tip string.*/
@property(assign) id <MultiColorUsageBarToolTipDelegate> delegate;

/* borderColor: Usage Bar border color, set it from IB */
@property (nonatomic, retain) IBInspectable NSColor *borderColor;

/* borderWidth: Usage Bar border color, set it from IB */
@property (nonatomic) IBInspectable float borderWidth;

/* isCategoryTitle: Set YES if you want to display category name in the usage bar, 
 No- if you don't want to display category name in the usage bar */
@property (nonatomic) IBInspectable BOOL isCategoryTitle;

/* categoryFontSize: Font size of category Name, , set it from IB */
@property (nonatomic) IBInspectable double categoryFontSize;

/* categoryAlignment: Category name alignment on the usage bar
 // Visually left aligned as |<CategoryName1>---|<CategoryName2>---|
 // Visually right aligned as |---<CategoryName1>|---<CategoryName2>|
 // Visually centered as |--<CategoryName1>--|--<CategoryName2>--|
 Values accepted as:
 NSLeftTextAlignment = 0
 NSRightTextAlignment	= 1,
 NSCenterTextAlignment	= 2,
 NSJustifiedTextAlignment = 3,    // Fully-justified. The last line in a paragraph is natural-aligned.
 NSNaturalTextAlignment	= 4     // Indicates the default alignment for script*/
@property (nonatomic) IBInspectable NSUInteger categoryAlignment;

/* leftCategoryPadding: left padding for category name
 |<leftPadding><CategoryName1>---|<leftPadding><CategoryName2>---|*/
@property (nonatomic) IBInspectable float leftCategoryPadding;

/*rightCategoryPadding: right padding for category name
 |---<CategoryName1><rightPadding>|---<CategoryName2><rightPadding>|*/
@property (nonatomic) IBInspectable float rightCategoryPadding;

/* CategoryFontName: Category name is displayed with the provided font name such as 
 Helvetica Bold, Arial, Arial Black.
 If wrong font name is provided - category name is dispalyed with Helvetica Bold and font size = 10*/
@property (nonatomic) IBInspectable NSString *categoryFontName;

/* categoryTextColor: category name is displayed in the specified color. */
@property (nonatomic, retain) IBInspectable NSColor *categoryTextColor;

/* isCategoryToolTip: If YES, displays category tooltip with categoryName and usage value with unit, if NO- no tooltip is provided. Tooltip is displayed as below by default if isCategoryToolTip = YES
  --------
 | Images |
 | 4.0 GB |
  --------
 This class also provide customized tooltip, implement a delegate method stringForToolTip of MultiColorUsageBarToolTipDelegate */
@property (nonatomic) IBInspectable BOOL isCategoryToolTip;

/* usageUnit: Usage unit is data unit i.e. values can be
 KB, MB, GB, TB etc.*/
@property (nonatomic) IBInspectable NSString *usageUnit;

/* isRoundedCornerBar: If YES, displays usage bar with rounded corners, if NO- displays rectangle usage bar */
@property (nonatomic) IBInspectable BOOL isRoundedCornerBar;

/* roundedCornerRadious: If isRoundedCornerBar = YES, provide the radius for rounded corners but it should be less than or equal to the height of usage bar */
@property (nonatomic) IBInspectable float roundedCornerRadius;

/* This method clears all the present values, so you can add new values to redraw Usage Bar. */
- (void)clearMultiColorUsageBar;

/* This method takes MultiColorUsageBarValue and add to the usage bar. */
- (void)addMultiColorUsageBarValue:(MultiColorUsageBarValue*)multiColorUsageBarValue;

/*This method takes usage value, category name and color as in param and add it to Usage Bar. */
- (void)addUsageValue:(double)value categoryName:(NSString*)inCategoryName color:(NSColor*)inColor;

/*This method draws Usage Bar according to usage bar values. */
- (void)drawUsageBar;

@end
