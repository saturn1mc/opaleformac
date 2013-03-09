//
//  OPView.h
//  Opale
//
//  Created by Camille on 08/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Quartz/Quartz.h>

@class OPMainWindow;

@interface OPView : NSView{
    IBOutlet OPMainWindow* parent;
    
    OPView* nextView;
    OPView* previousView;
    
    CATransition* transition;
}

@property (nonatomic, retain) IBOutlet OPMainWindow* parent;

@property (nonatomic, retain) OPView* nextView;
@property (nonatomic, retain) OPView* previousView;
@property (nonatomic, retain) CATransition* transition;

-(NSManagedObjectContext *)managedObjectContext;

-(void)saveAction;
-(void)resetView;
-(BOOL)quitView;
-(BOOL)canGoToPreviousView;
-(BOOL)canGoToNextView;

+(void)initFormCell:(NSFormCell*)formCell withString:(NSString*)value;
+(void)initTextField:(NSTextField*)textField withString:(NSString*)value;
+(void)initTextView:(NSTextView*)textView withString:(NSString*)value;
+(void)initFormCell:(NSFormCell*)formCell withDate:(NSDate*)date;
+(void)initTextField:(NSTextField*)textField withDate:(NSDate*)date;
+(void)initTextView:(NSTextView*)textView withDate:(NSDate*)date;

@end
