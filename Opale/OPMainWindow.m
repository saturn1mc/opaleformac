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

#import "OPMainWindow.h"
#import "OPPatientsView.h"
#import "OPAdultMalePatientView.h"
#import "OPAdultFemalePatientView.h"
#import "OPBabyPatientView.h"
#import "OPAdultChildConsultationView.h"
#import "OPCalendarView.h"
#import "OPView.h"

static const NSInteger babyAgeLimit  = 4;
static const NSInteger childAgeLimit = 17;

@implementation OPMainWindow

@synthesize nextButton, previousButton, currentScrollView, currentView, homeView, patientsView, calendarView, accountingView, statsView, networkView, adultMalePatientView, adultFemalePatientView, babyPatientView, adultChildConsultationView;

- (void)awakeFromNib{
    
    transition = [CATransition animation];
    
    NSView *mainView = [self contentView];
    [mainView setAnimations:[NSDictionary dictionaryWithObject:transition forKey:@"subviews"]];
    [mainView setWantsLayer:YES];
    
    [self showHomeView:self];
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
    [statsView setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
    [transition setType:kCATransitionFade];
    [self openNewView:calendarView];
    
    [[[calendarView webView] mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.com/calendar"]]];
}

-(IBAction)showAccountingView:(id)sender{
    [statsView setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
    [transition setType:kCATransitionFade];
    [self openNewView:accountingView];
}

-(IBAction)showStatsView:(id)sender{
    [statsView setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
    [transition setType:kCATransitionFade];
    [self openNewView:statsView];
}

-(IBAction)showNetworkView:(id)sender{
    [statsView setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
    [transition setType:kCATransitionFade];
    [self openNewView:networkView];
}

-(IBAction)showPatientViewFor:(OPPatient*)patient{
    //TODO take age into account
    NSDate* today = [NSDate date];
    
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    
    NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:patient.birthday  toDate:today  options:0];
    
    NSInteger ageInYears = breakdownInfo.year;
    
    if(ageInYears < babyAgeLimit){ //Baby
        [babyPatientView loadPatient:patient];
        [self fadeSubview:babyPatientView];
    }else if (ageInYears < childAgeLimit){ //Child
        //TODO child views
        if([patient.sex isEqualToString:@"Homme"]){
            [adultMalePatientView loadPatient:patient];
            [self fadeSubview:adultMalePatientView];
        }
        else{
            [adultFemalePatientView loadPatient:patient];
            [self fadeSubview:adultFemalePatientView];
        }
    }else{ //Adult
        if([patient.sex isEqualToString:@"Homme"]){
            [adultMalePatientView loadPatient:patient];
            [self fadeSubview:adultMalePatientView];
        }
        else{
            [adultFemalePatientView loadPatient:patient];
            [self fadeSubview:adultFemalePatientView];
        }
    }
}

-(IBAction)showConsultationViewFor:(OPConsultation*)consultation{
    //TODO switch view given patient age and/or sex
    [adultChildConsultationView loadConsultation:consultation];
    [self pushSubview:adultChildConsultationView];
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
    if(currentView != nil){
        if([currentView quitView]){
            [newView setPreviousView:currentView];
            [currentView setNextView:newView];
            [self switchView:newView];
        }
    }
    else{
        [self switchView:newView];   
    }
}

-(void)switchView:(OPView *)newView{
    if(currentView != newView){
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
