//
//  MultiColorUsageBar.m
//  UsageBarDemo
//
//  Created by Anil Saini on 9/8/15.
//  Copyright (c) 2015. All rights reserved.
//

#import "MultiColorUsageBar.h"

@interface MultiColorUsageBarValue()
{
    NSRect rect;
}

@property (nonatomic) NSRect rect;

@end

@implementation MultiColorUsageBarValue
@synthesize categoryName;
@synthesize color;
@synthesize rect;
@synthesize usageValue;

- (instancetype)init
{
    if(self = [super init])
    {
        [self defaultValues];
    }
    return self;
}

- (instancetype)initWithUsageValue:(double)inUsageValue categoryName:(NSString*)inCategoryName color:(NSColor*)inColor
{
    if (self = [super init])
    {
        self.usageValue = inUsageValue;
        self.categoryName = inCategoryName;
        self.color = inColor;
        self.rect = NSZeroRect;
    }
    return self;
}

- (void)defaultValues
{
    self.usageValue = 0.0;
    self.categoryName = nil;
    self.color = [NSColor clearColor];
    self.rect = NSZeroRect;
}

@end

@interface MultiColorUsageBar()
{
    NSMutableArray *multiColorUsageBarValues;
    NSRect oldRect;
}
@property (nonatomic) double totalSpace;

- (void)initDefaultValues;
- (void)createRectForUsageBar;
- (void)drawLeftRoundedRect:(NSBezierPath*)path forRect:(NSRect)rect;
- (void)drawRightRoundedRect:(NSBezierPath*)path forRect:(NSRect)rect;

@end

@implementation MultiColorUsageBar
@synthesize borderColor;
@synthesize borderWidth;
@synthesize totalSpace;
@synthesize categoryFontSize;
@synthesize usageUnit;
@synthesize categoryTextColor;
@synthesize categoryAlignment;
@synthesize leftCategoryPadding;
@synthesize rightCategoryPadding;
@synthesize categoryFontName;
@synthesize isRoundedCornerBar;
@synthesize roundedCornerRadius;
@synthesize isCenterCategoryTitle;
@synthesize isBelowCategoryTitle;
@synthesize isCategoryToolTip;
@synthesize delegate;

- (void)awakeFromNib
{
    if (multiColorUsageBarValues == nil)
    {
        multiColorUsageBarValues = [NSMutableArray array];
        
    }
}

- (instancetype)init
{
    if (self = [super initWithFrame:CGRectZero])
    {
        [self initDefaultValues];
    }
    
    return  self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder])
    {
        [self initDefaultValues];
    }
    return  self;
}

- (void)dealloc
{
    if (multiColorUsageBarValues != nil)
    {
        [multiColorUsageBarValues removeAllObjects];
    }
    multiColorUsageBarValues = nil;
    self.categoryFontName = nil;
    self.usageUnit = nil;
    self.delegate = nil;
    if (self.isCategoryToolTip)
    {
        [self removeAllToolTips];
    }
}

- (void)initDefaultValues
{
    if (multiColorUsageBarValues == nil)
    {
        multiColorUsageBarValues = [NSMutableArray array];
        
    }
    self.categoryFontName = @"Helvetica Bold";
    self.categoryFontSize = 10.0;
    self.categoryAlignment = NSCenterTextAlignment;
    self.categoryTextColor = [NSColor blackColor];
    self.leftCategoryPadding = 0.0;
    self.rightCategoryPadding = 0.0;
    self.borderWidth = 0.1;
    self.borderColor = [NSColor darkGrayColor];
    self.totalSpace = 0.0;
    self.usageUnit = @"GB";
    self.isRoundedCornerBar = YES;
    self.roundedCornerRadius = 10.0;
    self.isCenterCategoryTitle = YES;
    self.isBelowCategoryTitle = NO;
    self.isCategoryToolTip = YES;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    if (dirtyRect.size.height != oldRect.size.height || dirtyRect.size.width != oldRect.size.width)
    {
        if (self.isCategoryToolTip)
        {
            [self removeAllToolTips];
        }
        
        [self createRectForUsageBar];
        oldRect = dirtyRect;
    }
    
    for(MultiColorUsageBarValue *mClrUsgBarValue in multiColorUsageBarValues)
    {
        NSRect rect = mClrUsgBarValue.rect;
        
        [NSGraphicsContext saveGraphicsState];
        NSBezierPath *path = [NSBezierPath bezierPath];
        
        if(isRoundedCornerBar && [multiColorUsageBarValues count] == 1)
        {
            path = [NSBezierPath bezierPathWithRoundedRect:rect xRadius:self.roundedCornerRadius yRadius:self.roundedCornerRadius];
        }
        else if (isRoundedCornerBar && [mClrUsgBarValue isEqualTo:[multiColorUsageBarValues objectAtIndex:0]])
        {
            //radius should not be greater than bar height
            if (self.roundedCornerRadius > rect.size.height)
            {
                self.roundedCornerRadius = rect.size.height;
            }
            [self drawLeftRoundedRect:path forRect:mClrUsgBarValue.rect];
        }
        else if (isRoundedCornerBar && [mClrUsgBarValue isEqualTo:[multiColorUsageBarValues objectAtIndex:[multiColorUsageBarValues count] - 1]])
        {
            [self drawRightRoundedRect:path forRect:rect];
        }
        else
        {
            path = [NSBezierPath bezierPathWithRect:rect];
        }
        
        [mClrUsgBarValue.color set];
        [path fill];
        
        //Draw rect border
        [self.borderColor set];
        //Set border width
        path.lineWidth = self.borderWidth;
        [path stroke];
        [NSGraphicsContext restoreGraphicsState];
        
        [self drawTitle:mClrUsgBarValue];
    }
}

- (void)drawTitle:(MultiColorUsageBarValue*)mClrUsgBarValue
{
    //Draw title
    NSRect rect = mClrUsgBarValue.rect;
    NSFont *font = [NSFont fontWithName:self.categoryFontName size:self.categoryFontSize];
    if (font==nil) {
        font = [NSFont fontWithName:@"Helvetica Bold" size:10.0];
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setParagraphStyle:[NSParagraphStyle defaultParagraphStyle]];
    [paragraphStyle setAlignment:self.categoryAlignment];
    
    NSDictionary *textAttribute = [NSDictionary dictionaryWithObjects:@[font, self.categoryTextColor, paragraphStyle] forKeys:@[NSFontAttributeName, NSForegroundColorAttributeName, NSParagraphStyleAttributeName]];
    NSSize txtSize = [mClrUsgBarValue.categoryName sizeWithAttributes:textAttribute];
    NSRect titlePositionRect = NSZeroRect;
    
    if (self.isCenterCategoryTitle)
    {
        titlePositionRect = NSMakeRect(rect.origin.x + self.leftCategoryPadding - (2 * self.rightCategoryPadding), rect.origin.y + (rect.size.height - txtSize.height)/2.0, rect.size.width, txtSize.height);
        [mClrUsgBarValue.categoryName drawInRect:titlePositionRect withAttributes:textAttribute];
    }
    
    if(self.isBelowCategoryTitle)
    {
        float txtPadding = 10.0;
        [paragraphStyle setAlignment:NSLeftTextAlignment];
        NSRect titleRect = NSMakeRect(rect.origin.x + self.leftCategoryPadding - (2 * self.rightCategoryPadding), rect.origin.y - rect.size.height - 2.0, txtPadding, txtPadding);
        NSBezierPath *titlePath = [NSBezierPath bezierPathWithRect:titleRect];
        [mClrUsgBarValue.color set];
        [titlePath fill];
        
        titlePositionRect = NSMakeRect(titleRect.origin.x + titleRect.size.width + txtPadding, titleRect.origin.y, rect.size.width - titleRect.size.width, txtSize.height);
        [mClrUsgBarValue.categoryName drawInRect:titlePositionRect withAttributes:textAttribute];
    }
    
    paragraphStyle = nil;
    textAttribute = nil;
}

- (void)drawLeftRoundedRect:(NSBezierPath*)path forRect:(NSRect)rect
{
    // Draw top left round corner
    [path moveToPoint:NSMakePoint(NSMinX(rect), NSMaxY(rect))];
    
    // Draw side border and a top-left rounded corner
    [path lineToPoint:NSMakePoint(NSMinX(rect), NSMinY(rect) + self.roundedCornerRadius)];
    NSPoint topLeftCorner = NSMakePoint(NSMinX(rect), NSMinY(rect));
    [path curveToPoint:NSMakePoint(NSMinX(rect) + self.roundedCornerRadius, NSMinY(rect)) controlPoint1:topLeftCorner
         controlPoint2:topLeftCorner];
    
    [path lineToPoint:NSMakePoint(NSMaxX(rect), NSMinY(rect))];
    [path lineToPoint:NSMakePoint(NSMaxX(rect), NSMaxY(rect))];
    
    // Draw left border and a bottom-left rounded corner
    [path moveToPoint:NSMakePoint(NSMinX(rect), NSMaxY(rect))];
    [path lineToPoint:NSMakePoint(NSMinX(rect) + self.roundedCornerRadius, NSMaxY(rect))];
    
    NSPoint bottomLeftCorner = NSMakePoint(NSMinX(rect), NSMaxY(rect));
    [path lineToPoint:NSMakePoint(NSMinX(rect) + self.roundedCornerRadius, NSMaxY(rect))];
    [path curveToPoint:NSMakePoint(NSMinX(rect), NSMaxY(rect) - self.roundedCornerRadius)
         controlPoint1:bottomLeftCorner controlPoint2:bottomLeftCorner];
}

- (void)drawRightRoundedRect:(NSBezierPath*)path forRect:(NSRect)rect
{
    // Draw top right round corner
    [path moveToPoint:NSMakePoint(NSMinX(rect), NSMinY(rect))];
    
    // Draw top border and a top-right rounded corner
    NSPoint topRightCorner = NSMakePoint(NSMaxX(rect), NSMinY(rect));
    [path lineToPoint:NSMakePoint(NSMaxX(rect) - self.roundedCornerRadius, NSMinY(rect))];
    [path curveToPoint:NSMakePoint(NSMaxX(rect), NSMinY(rect) + self.roundedCornerRadius)
         controlPoint1:topRightCorner controlPoint2:topRightCorner];
    
    // Draw bottom border and a bottom-right rounded corner
    NSPoint bottomRightCorner = NSMakePoint(NSMaxX(rect), NSMaxY(rect));
    [path lineToPoint:NSMakePoint(NSMaxX(rect), NSMaxY(rect) - self.roundedCornerRadius)];
    [path curveToPoint:NSMakePoint(NSMaxX(rect) - self.roundedCornerRadius, NSMaxY(rect))
         controlPoint1:bottomRightCorner controlPoint2:bottomRightCorner];
    
    [path lineToPoint:NSMakePoint(NSMinX(rect), NSMaxY(rect))];
    [path lineToPoint:NSMakePoint(NSMinX(rect), NSMinY(rect))];
}

- (void)createRectForUsageBar
{
    if ([multiColorUsageBarValues count] > 0)
    {
        float currentX = self.borderWidth;
        double scale = 1.0;
        float height = self.bounds.size.height - 2 * self.borderWidth;
        float yPosAdj = 0.0;
        if (self.totalSpace > 0)
        {
            scale = (self.bounds.size.width - 2 * self.borderWidth) / self.totalSpace;
        }
        
        if (self.isBelowCategoryTitle)
        {
            height /= 2.0;
            yPosAdj = self.bounds.size.height/2.0;
        }
        //float widthAdj = 0;
        
        for(MultiColorUsageBarValue *mClrUsgBarValue in multiColorUsageBarValues)
        {
            float width = mClrUsgBarValue.usageValue * scale;
            //Use the below code if some values are too small
            /* if (width < 20.0)
             {
             width += 20.0;
             widthAdj += width;
             }
             
             if( widthAdj > 0 && (currentX + width) > (self.bounds.size.width - 2 * self.borderWidth))
             {
             width = (self.bounds.size.width - 2 * self.borderWidth) - widthAdj;
             } */
            
            //Draw rect
            
            NSRect rect = NSMakeRect(currentX, self.bounds.origin.y + yPosAdj, width, height);
            [mClrUsgBarValue setRect:rect];
            if (self.isCategoryToolTip)
            {
                //Add tool tip to rect
                [self addToolTipRect:rect owner:self userData:nil];
            }
            
            currentX += width;
        }
    }
}

- (void)clearMultiColorUsageBar
{
    [multiColorUsageBarValues removeAllObjects];
    self.totalSpace = 0.0;
}

- (void)addMultiColorUsageBarValue:(MultiColorUsageBarValue*)multiColorUsageBarValue
{
    [multiColorUsageBarValues addObject:multiColorUsageBarValue];
    self.totalSpace += multiColorUsageBarValue.usageValue;
}

- (void)addUsageValue:(double)value categoryName:(NSString*)inCategoryName color:(NSColor*)inColor
{
    [self addMultiColorUsageBarValue:[[MultiColorUsageBarValue alloc] initWithUsageValue:value categoryName:inCategoryName color:inColor]];
}

- (void)drawUsageBar
{
    //create rect for categories and display them
    [self createRectForUsageBar];
    [self setNeedsDisplay:YES];
}

#pragma mark - NSView delegate

- (NSString *)view:(NSView *)view stringForToolTip:(NSToolTipTag)tag point:(NSPoint)point userData:(void *)data
{
    NSString *toolTip = nil;
    for(MultiColorUsageBarValue *mClrUsgBarValue in multiColorUsageBarValues)
    {
        if ([self.delegate respondsToSelector:@selector(stringForToolTip)])
        {
            toolTip = [self.delegate stringForToolTip];
        }
        else if (NSPointInRect(point, mClrUsgBarValue.rect))
        {
            toolTip = [NSString stringWithFormat:@"%@ \n%.5f %@", NSLocalizedString(mClrUsgBarValue.categoryName, @""), mClrUsgBarValue.usageValue, self.usageUnit];
        }
    }
    return toolTip;
}

@end
