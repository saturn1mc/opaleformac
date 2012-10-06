//
//  OPView.h
//  Opale
//
//  Created by Camille on 08/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class OPMainWindow;

@interface OPView : NSView{
    IBOutlet OPMainWindow* parent;
    
    OPView* nextView;
    OPView* previousView;
}

@property (nonatomic, retain) IBOutlet OPMainWindow* parent;
@property (nonatomic, retain) OPView* nextView;
@property (nonatomic, retain) OPView* previousView;

-(void)saveAction;
-(NSManagedObjectContext *)managedObjectContext;
-(BOOL)quitView;
-(BOOL)canGoToPreviousView;
-(BOOL)canGoToNextView;

@end
