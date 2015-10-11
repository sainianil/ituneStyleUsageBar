//
//  UsageBarTests.m
//  UsageBarTests
//
//  Created by Anil Saini on 9/8/15.
//  Copyright (c) 2015. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import <UsageBar/UsageBar.h>

@interface UsageBarTests : XCTestCase

@end

@implementation UsageBarTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNotNilMultiColorUsageBarValue
{
    MultiColorUsageBarValue *mClrUsageBarValue = [[MultiColorUsageBarValue alloc] init];
    XCTAssertNotNil(mClrUsageBarValue, @"Object is nil!");
    
}

- (void)testDefaultMultiColorUsageBarValue
{
    float usageValue = 0.0;
    NSString *catName = nil;
    NSColor *color = [NSColor clearColor];
    MultiColorUsageBarValue *mClrUsageBarValue = [[MultiColorUsageBarValue alloc] init];
    XCTAssertEqual([mClrUsageBarValue usageValue], usageValue, @"Usage value is not default!");
    XCTAssertEqual([mClrUsageBarValue categoryName], catName, @"Category name is not nil!");
    XCTAssertEqual([mClrUsageBarValue color], color, @"Usage color is not clear color!");
}

- (void)testCustomInitOfMultiColorUsageBarValue
{
    float usageValue = 2.2;
    NSString *catName = @"Images";
    NSColor *color = [NSColor orangeColor];
    MultiColorUsageBarValue *mClrUsageBarValue = [[MultiColorUsageBarValue alloc] initWithUsageValue:usageValue categoryName:catName color:color];
    XCTAssertEqual([mClrUsageBarValue usageValue], usageValue, @"Usage value is not matching!");
    XCTAssertEqual([mClrUsageBarValue categoryName], catName, @"Category name is not matching!");
    XCTAssertEqual([mClrUsageBarValue color], color, @"Usage color is not orange color!");
}

- (void)testNotNilMultiColorUsageBar
{
    MultiColorUsageBar *mClrUsageBar = [[MultiColorUsageBar alloc] init];
    XCTAssertNotNil(mClrUsageBar, @"Object is not nil!");
}

- (void)testDefaultMultiColorUsageBar
{
    NSString *categoryFontName = @"Helvetica Bold";
    float categoryFontSize = 10.0;
    NSUInteger categoryAlignment = NSCenterTextAlignment;
    NSColor *categoryTextColor = [NSColor blackColor];
    float leftCategoryPadding = 0.0;
    float rightCategoryPadding = 0.0;
    float borderWidth = 0.1;
    NSColor *borderColor = [NSColor darkGrayColor];
    NSString *usageUnit = NSLocalizedString(@"GB", @"");
    BOOL isRoundedCornerBar = YES;
    float roundedCornerRadius = 10.0;
    BOOL isCategoryTitle = YES;
    BOOL isCategoryToolTip = YES;

    MultiColorUsageBar *mClrUsageBar = [[MultiColorUsageBar alloc] init];
    XCTAssertEqualObjects([mClrUsageBar categoryFontName], categoryFontName, @"Font name is not default!");
    XCTAssertEqual([mClrUsageBar categoryFontSize], categoryFontSize, @"Font size is not default!");
    XCTAssertEqual([mClrUsageBar categoryAlignment], categoryAlignment, @"Alignment is not default!");
    XCTAssertEqual([mClrUsageBar categoryTextColor], categoryTextColor, @"Text color is not default!");
    XCTAssertEqual([mClrUsageBar leftCategoryPadding], leftCategoryPadding, @"Left category padding is not default!");
    XCTAssertEqual([mClrUsageBar rightCategoryPadding], rightCategoryPadding, @"Rght category padding is not default!");
    XCTAssertEqual([mClrUsageBar borderWidth], borderWidth, @"Border width is not default!");
    XCTAssertEqual([mClrUsageBar borderColor], borderColor, @"Border color is not default!");
    XCTAssertEqualObjects([mClrUsageBar usageUnit], usageUnit, @"Usage unit is not default!");
    XCTAssertEqual([mClrUsageBar isRoundedCornerBar], isRoundedCornerBar, @"isRoundedCornerBar is not default!");
    XCTAssertEqual([mClrUsageBar roundedCornerRadius], roundedCornerRadius, @"roundedCornerRadious is not default!");
    XCTAssertEqual([mClrUsageBar isCenterCategoryTitle], isCategoryTitle, @"isCategoryTitle is not default!");
    XCTAssertEqual([mClrUsageBar isCategoryToolTip], isCategoryToolTip, @"isCategoryToolTip is not default!");
}

- (void)testCustomInitOfMultiColorUsageBar
{
    NSString *categoryFontName = @"Arial";
    float categoryFontSize = 12.0;
    NSUInteger categoryAlignment = NSRightTextAlignment;
    NSColor *categoryTextColor = [NSColor redColor];
    float leftCategoryPadding = 2.0;
    float rightCategoryPadding = 3.0;
    float borderWidth = 1.1;
    NSColor *borderColor = [NSColor grayColor];
    NSString *usageUnit = NSLocalizedString(@"TB", @"");
    BOOL isRoundedCornerBar = NO;
    float roundedCornerRadius = 12.0;
    BOOL isCategoryTitle = NO;
    BOOL isCategoryToolTip = NO;
    
    MultiColorUsageBar *mClrUsageBar = [[MultiColorUsageBar alloc] init];
    [mClrUsageBar setCategoryFontName:categoryFontName];
    XCTAssertEqualObjects([mClrUsageBar categoryFontName], categoryFontName, @"Font name is not matching!");
    [mClrUsageBar setCategoryFontSize:categoryFontSize];
    XCTAssertEqual([mClrUsageBar categoryFontSize], categoryFontSize, @"Font size is not matching!");
    [mClrUsageBar setCategoryAlignment:categoryAlignment];
    XCTAssertEqual([mClrUsageBar categoryAlignment], categoryAlignment, @"Alignment is not matching!");
    [mClrUsageBar setCategoryTextColor:categoryTextColor];
    XCTAssertEqual([mClrUsageBar categoryTextColor], categoryTextColor, @"Text color is not matching!");
    [mClrUsageBar setLeftCategoryPadding:leftCategoryPadding];
    XCTAssertEqual([mClrUsageBar leftCategoryPadding], leftCategoryPadding, @"Left category padding is not matching!");
    [mClrUsageBar setRightCategoryPadding:rightCategoryPadding];
    XCTAssertEqual([mClrUsageBar rightCategoryPadding], rightCategoryPadding, @"Rght category padding is not matching!");
    [mClrUsageBar setBorderWidth:borderWidth];
    XCTAssertEqual([mClrUsageBar borderWidth], borderWidth, @"Border width is not matching!");
    [mClrUsageBar setBorderColor:borderColor];
    XCTAssertEqual([mClrUsageBar borderColor], borderColor, @"Border color is not matching!");
    [mClrUsageBar setUsageUnit:usageUnit];
    XCTAssertEqualObjects([mClrUsageBar usageUnit], usageUnit, @"Usage unit is not matching!");
    [mClrUsageBar setIsRoundedCornerBar:isRoundedCornerBar];
    XCTAssertEqual([mClrUsageBar isRoundedCornerBar], isRoundedCornerBar, @"isRoundedCornerBar is not matching!");
    [mClrUsageBar setRoundedCornerRadius:roundedCornerRadius];
    XCTAssertEqual([mClrUsageBar roundedCornerRadius], roundedCornerRadius, @"roundedCornerRadious is not matching!");\
    [mClrUsageBar setIsCenterCategoryTitle:isCategoryTitle];
    XCTAssertEqual([mClrUsageBar isCenterCategoryTitle], isCategoryTitle, @"isCategoryTitle is not matching!");
    [mClrUsageBar setIsCategoryToolTip:isCategoryToolTip];
    XCTAssertEqual([mClrUsageBar isCategoryToolTip], isCategoryToolTip, @"isCategoryToolTip is not matching!");
}

@end
