//
//  OPView.m
//  Opale
//
//  Created by Camille on 08/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OPView.h"
#import "OPMainWindow.h"
#import "OPAppDelegate.h"

@implementation OPView

@synthesize parent, nextView, previousView;

-(NSManagedObjectContext *)managedObjectContext{
    OPAppDelegate* appDelegate = (OPAppDelegate*)parent.delegate;
    return appDelegate.managedObjectContext;
}

-(void)saveAction{
    OPAppDelegate* appDelegate = (OPAppDelegate*)parent.delegate;
    [appDelegate saveAction:self];
}

-(void)resetView{
    //Nothing
}

-(BOOL)isFlipped{
    return YES;
}

-(BOOL)quitView{
    return YES;
}

-(BOOL)canGoToPreviousView{
    return ([self quitView] && previousView != nil);
}

-(BOOL)canGoToNextView{
    return ([self quitView] && nextView != nil);
}

+(void)initFormCell:(NSFormCell*)formCell withString:(NSString*)value{
    if(value){
        [formCell setStringValue:[NSString stringWithString:value]];
    }
    else{
        [formCell setStringValue:@""];
    }
}

+(void)initTextField:(NSTextField*)textField withString:(NSString*)value{
    if(value){
        [textField setStringValue:[NSString stringWithString:value]];
    }
    else{
        [textField setStringValue:@""];
    }
}

+(void)initTextView:(NSTextView*)textView withString:(NSString*)value{
    if(value){
        [textView setString:[NSString stringWithString:value]];
    }
    else{
        [textView setString:@""];
    }
}

+(void)initFormCell:(NSFormCell*)formCell withDate:(NSDate*)date{
    if(date){
        NSLocale* frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        [dateFormatter setLocale:frLocale];
        [formCell setStringValue: [dateFormatter stringFromDate:date]];
    }
    else{
        [formCell setStringValue:@""];
    }
}

+(void)initTextField:(NSTextField*)textField withDate:(NSDate*)date{
    if(date){
        NSLocale* frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        [dateFormatter setLocale:frLocale];
        
        [textField setStringValue: [dateFormatter stringFromDate:date]];
    }
    else{
        [textField setStringValue:@""];
    }

}

+(void)initTextView:(NSTextView*)textView withDate:(NSDate*)date{
    if(date){
        NSLocale* frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
        
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        [dateFormatter setLocale:frLocale];
        
        [textView setString: [dateFormatter stringFromDate:date]];
    }
    else{
        [textView setString:@""];
    }

}

@end
