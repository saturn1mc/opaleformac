//
//  OPMainWindow.h
//  Opale
//
//  Created by Camille on 06/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@class OPView, OPPatient, OPConsultation, OPPatientsView, OPCalendarView, OPAdultMalePatientView, OPAdultFemalePatientView, OPBabyPatientView, OPAdultChildConsultationView;

@interface OPMainWindow : NSWindow {
    
    IBOutlet NSToolbarItem* nextButton;
    IBOutlet NSToolbarItem* previousButton;
    
    IBOutlet NSScrollView* currentScrollView;
    IBOutlet OPView* currentView;
    
    IBOutlet OPView* homeView;
    IBOutlet OPPatientsView* patientsView;
    IBOutlet OPCalendarView* calendarView;
    IBOutlet OPView* accountingView;
    IBOutlet OPView* statsView;
    IBOutlet OPView* networkView;
    
    IBOutlet OPAdultMalePatientView* adultMalePatientView;
    IBOutlet OPAdultFemalePatientView* adultFemalePatientView;
    IBOutlet OPBabyPatientView* babyPatientView;
    IBOutlet OPAdultChildConsultationView* adultChildConsultationView;
    
    CATransition *transition;
}

@property (nonatomic, retain) IBOutlet NSToolbarItem* nextButton;
@property (nonatomic, retain) IBOutlet NSToolbarItem* previousButton;


@property (nonatomic, retain) IBOutlet NSScrollView* currentScrollView;
@property (nonatomic, retain) IBOutlet OPView* currentView;

@property (nonatomic, retain) IBOutlet OPView* homeView;
@property (nonatomic, retain) IBOutlet OPPatientsView* patientsView;
@property (nonatomic, retain) IBOutlet OPCalendarView* calendarView;
@property (nonatomic, retain) IBOutlet OPView* accountingView;
@property (nonatomic, retain) IBOutlet OPView* statsView;
@property (nonatomic, retain) IBOutlet OPView* networkView;

@property (nonatomic, retain) IBOutlet OPAdultMalePatientView* adultMalePatientView;
@property (nonatomic, retain) IBOutlet OPAdultFemalePatientView* adultFemalePatientView;
@property (nonatomic, retain) IBOutlet OPBabyPatientView* babyPatientView;
@property (nonatomic, retain) IBOutlet OPAdultChildConsultationView* adultChildConsultationView;

-(IBAction)showHomeView:(id)sender;
-(IBAction)showPatientsView:(id)sender;
-(IBAction)showCalendarView:(id)sender;
-(IBAction)showAccountingView:(id)sender;
-(IBAction)showStatsView:(id)sender;
-(IBAction)showNetworkView:(id)sender;

-(IBAction)showPatientViewFor:(OPPatient*)patient;
-(IBAction)showConsultationViewFor:(OPConsultation*)consultation;

-(void)pushSubview:(OPView *)newView;
-(void)fadeSubview:(OPView *)newView;

-(IBAction)previousView:(id)sender;
-(IBAction)nextView:(id)sender;

-(void)openNewView:(OPView*)newView;
-(void)switchView:(OPView*)newView;

@end
