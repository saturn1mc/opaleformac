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

@end
