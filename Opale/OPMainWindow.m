//
//  OPMainWindow.m
//  Opale
//
//  Created by Camille on 06/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <WebKit/WebKit.h>

#import "OPPatient.h"
#import "OPConsultation.h"
#import "OPMail.h"
#import "OPDocument.h"

#import "OPMainWindow.h"
#import "OPAppDelegate.h"
#import "OPView.h"
#import "OPPatientsView.h"
#import "OPAdultMalePatientView.h"
#import "OPAdultFemalePatientView.h"
#import "OPBabyPatientView.h"
#import "OPConsultationView.h"
#import "OPCalendarView.h"
#import "OPProfessionalView.h"
#import "OPProfessionalsView.h"
#import "OPScanningView.h"

static const NSInteger babyAgeLimit  = 4;
static const NSInteger childAgeLimit = 17;

@implementation OPMainWindow

@synthesize nextButton, previousButton, currentScrollView, currentView, homeView, patientsView, calendarView, accountingView, statsView, adultMalePatientView, adultFemalePatientView, babyPatientView, consultationView, professionalsView, professionalView, scanningView, transition;

- (void)awakeFromNib{
    
    transition = [CATransition animation];
    
    NSView *mainView = [self contentView];
    [mainView setAnimations:[NSDictionary dictionaryWithObject:transition forKey:@"subviews"]];
    [mainView setWantsLayer:YES];
    
    [self showHomeView:self];
}

#pragma marks - Model methods

-(NSURL*)directoryFor:(OPPatient*)patient{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    OPAppDelegate* appDelegate = (OPAppDelegate*) self.delegate;
    
    NSURL* patientDirectory = [[appDelegate applicationFilesDirectory] URLByAppendingPathComponent:[[[patient objectID] URIRepresentation] path]];
    
    BOOL isDir = NO;
    
    if(!([fileManager fileExistsAtPath:[patientDirectory path] isDirectory:&isDir] && isDir)){
        [fileManager createDirectoryAtURL:patientDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return patientDirectory;
}

-(NSURL*)mailDirectoryFor:(OPPatient*)patient{
    NSURL* patientDirectory = [self directoryFor:patient];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL* documentDirectory = [patientDirectory URLByAppendingPathComponent:@"mails"];
    
    BOOL isDir = NO;
    
    if(!([fileManager fileExistsAtPath:[documentDirectory path] isDirectory:&isDir] && isDir)){
        [fileManager createDirectoryAtURL:documentDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return documentDirectory;
}

-(NSURL*)documentDirectoryFor:(OPPatient*)patient{
    NSURL* patientDirectory = [self directoryFor:patient];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL* documentDirectory = [patientDirectory URLByAppendingPathComponent:@"documents"];
    
    BOOL isDir = NO;
    
    if(!([fileManager fileExistsAtPath:[documentDirectory path] isDirectory:&isDir] && isDir)){
        [fileManager createDirectoryAtURL:documentDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return documentDirectory;
}

-(void)openMail:(OPMail *)mail{
    [[NSWorkspace sharedWorkspace] openFile:[mail filePath] withApplication:@"Microsoft Word.app"];
}

-(void)openDocument:(OPDocument *)document{
    [[NSWorkspace sharedWorkspace] openFile:[document filePath]];
}

-(void)openCalendarAtDate:(NSDate *)date{
    [[calendarView datePicker] setDateValue:date];
    [calendarView refreshView];
    [calendarView changeSelection:self];
    
    [calendarView setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
    [transition setType:kCATransitionFade];
    [self openNewView:calendarView withReset:NO];
}

#pragma marks - Views

-(IBAction)showHomeView:(id)sender{
    [homeView setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
    [transition setType:kCATransitionFade];
    [self openNewView:homeView];
}

-(IBAction)showPatientsView:(id)sender{
    [patientsView setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
    [transition setType:kCATransitionFade];
    [self openNewView:patientsView];
}

-(IBAction)showCalendarView:(id)sender{
    [calendarView setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
    [transition setType:kCATransitionFade];
    [self openNewView:calendarView];
}

-(IBAction)showAccountingView:(id)sender{
    [accountingView setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
    [transition setType:kCATransitionFade];
    [self openNewView:accountingView];
}

-(IBAction)showStatsView:(id)sender{
    [statsView setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
    [transition setType:kCATransitionFade];
    [self openNewView:statsView];
}

-(IBAction)showProfessionalsView:(id)sender{
    [professionalsView setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
    [transition setType:kCATransitionFade];
    [self openNewView:professionalsView];
}

-(IBAction)showProfessionalViewFor:(OPProfessional*)professional{
    [self showProfessionalViewFor:professional withLockState:YES];
}

-(IBAction)showProfessionalViewFor:(OPProfessional*)professional withLockState:(BOOL)locked{
    [professionalView loadProfessional:professional];
    [self fadeSubview:professionalView];
}

-(IBAction)showPatientViewFor:(OPPatient*)patient{
    [self showPatientViewFor:patient withLockState:YES];
}

-(IBAction)showPatientViewFor:(OPPatient*)patient withLockState:(BOOL)locked{
    NSDate* today = [NSDate date];
    
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    
    NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:patient.birthday  toDate:today  options:0];
    
    NSInteger ageInYears = breakdownInfo.year;
    
    if(ageInYears < babyAgeLimit){ //Baby
        [babyPatientView loadPatient:patient];
        [babyPatientView setLocked:locked];
        [self fadeSubview:babyPatientView];
    }else if (ageInYears < childAgeLimit){ //Child
        
        //!!!!!!!!!!!!!!!!!!!!!!!!
        //TODO Child patient view
        //!!!!!!!!!!!!!!!!!!!!!!!!
        
        if([patient.sex integerValue] == 0){ //Male
            [adultMalePatientView loadPatient:patient];
            [adultMalePatientView setLocked:locked];
            [self fadeSubview:adultMalePatientView];
        }
        else{ //Female
            [adultFemalePatientView loadPatient:patient];
            [adultFemalePatientView setLocked:locked];
            [self fadeSubview:adultFemalePatientView];
        }
    }else{ //Adult
        
        if([patient.sex integerValue] == 0){ //Male
            [adultMalePatientView loadPatient:patient];
            [adultMalePatientView setLocked:locked];
            [self fadeSubview:adultMalePatientView];
        }
        else{ //Female
            [adultFemalePatientView loadPatient:patient];
            [adultFemalePatientView setLocked:locked];
            [self fadeSubview:adultFemalePatientView];
        }
    }
}

-(IBAction)showConsultationViewFor:(OPConsultation*)consultation{
    [consultationView loadConsultation:consultation];
    [self pushSubview:consultationView];
}

-(IBAction)showScanningView:(id)sender{
    [scanningView resetView];
    [self fadeSubview:scanningView];
}

#pragma marks - Subview

-(void)pushSubview:(OPView *)newView{
    [transition setType:kCATransitionPush];
    [transition setSubtype:kCATransitionFromRight];
    [self openNewView:newView];
}

-(void)fadeSubview:(OPView *)newView{
    [transition setType:kCATransitionFade];
    [self openNewView:newView];
}

#pragma marks - Navigation

-(IBAction)previousView:(id)sender{
    if(currentView){
        if([currentView canGoToPreviousView]){
            [transition setType:kCATransitionPush];
            [transition setSubtype:kCATransitionFromLeft];
            [self switchView:currentView.previousView];
        }
    }
}

-(IBAction)nextView:(id)sender{
    if(currentView){
        if([currentView canGoToNextView]){
            [transition setType:kCATransitionPush];
            [transition setSubtype:kCATransitionFromRight];
            [self switchView:currentView.nextView];
        }
    }
}

-(void)openNewView:(OPView *)newView{
    [self openNewView:newView withReset:YES];
}

-(void)openNewView:(OPView *)newView withReset:(BOOL)reset{
    if(currentView != nil){
        if([currentView quitView]){
            [newView setPreviousView:currentView];
            [currentView setNextView:newView];
            [self switchView:newView withReset:reset];
        }
    }
    else{
        [self switchView:newView withReset:reset];
    }
}

-(void)switchView:(OPView *)newView{
    [self switchView:newView withReset:YES];
}

-(void)switchView:(OPView *)newView withReset:(BOOL)reset{
    if(currentView != newView){
        if(reset){
            [newView resetView];
        }
        
        NSView *mainView = [self contentView];
        
        NSScrollView* newScrollView = [[NSScrollView alloc] initWithFrame:mainView.frame];
        [newScrollView setHasVerticalScroller:YES];
        [newScrollView setHasHorizontalScroller:YES];
        [newScrollView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
        [newScrollView setDocumentView:newView];
        
        if(!currentView){
            [mainView.animator addSubview:newScrollView];
        }
        else{
            [mainView.animator replaceSubview:currentScrollView with:newScrollView];
        }
        
        currentScrollView = newScrollView;
        currentView = newView;
    }
}

@end
