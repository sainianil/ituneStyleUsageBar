# ituneStyleUsageBar
# ituneStyleUsageBar
UsageBar is a framework which display data in multicolor usage bar similar to iTune. Similar library is available in swift for iOS https://github.com/prine/ROStorageBar
so I wrote in Objectiv-C with NSBezierPath for OSX.

![alt text](https://github.com/sainianil/ituneStyleUsageBar/blob/master/snapshot.png "Usage Bar Snapshot")

# Pod support available

```ruby
platform :osx, '10.10'

target 'Project Target' do

pod 'UsageBar'

end
```

# How to use?
- Add NSView on UI from XIB
- Change the class of NSView to UsageBar from XIB
- Create IBOutlet in ViewController
- Set the value of following properties from XIB
```objective-c
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

/* roundedCornerRadius: If isRoundedCornerBar = YES, provide the radius for rounded corners but it should be less than or equal to the height of usage bar */
@property (nonatomic) IBInspectable float roundedCornerRadius;
```
- Write following code to draw the Usage Bar

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    
    [multiClrUsageBar addUsageValue:4.0 categoryName:@"Music" color:[NSColor cyanColor]];
    [multiClrUsageBar addUsageValue:2.0 categoryName:@"Apps" color:[NSColor greenColor]];
    [multiClrUsageBar addUsageValue:3.0 categoryName:@"Videos" color:[NSColor orangeColor]];
    [multiClrUsageBar addUsageValue:1.0 categoryName:@"Free" color:[NSColor grayColor]];
    
    [multiClrUsageBar drawUsageBar];
}
```

<I>Sample demos are added in the respository for the reference</I>
