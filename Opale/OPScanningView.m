//
//  OPScanningView.m
//  Opale
//
//  Created by Camille on 01/12/12.
//
//

#import "OPScanningView.h"
#import "OPMainWindow.h"
#import "OPPatient.h"
#import "OPDocument.h"

@implementation OPScanningView

@synthesize patient, splitView, deviceBrowser, scannerView;


-(void)setPatient:(OPPatient*)nPatient{
    patient = nPatient;
}

-(void)resetView{
    [self setScanner:(ICScannerDevice*)[deviceBrowser selectedDevice]];
}

-(BOOL)quitView{
    ICScannerDevice* scanner = scannerView.scannerDevice;
    if(scanner){
        [scanner requestCloseSession];
    }
    
    return YES;
}

#pragma mark - Device browser delegate methods
-(void)deviceBrowserView:(IKDeviceBrowserView *)deviceBrowserView selectionDidChange:(ICDevice *)device{
    if(device.type & ICDeviceTypeScanner){
        [self setScanner:(ICScannerDevice*)device];
    }
}

-(void)deviceBrowserView:(IKDeviceBrowserView *)deviceBrowserView didEncounterError:(NSError *)error{
    NSLog(@"%@", error);
}

#pragma mark - Scanner device delegate methods

-(void)scannerDeviceView:(IKScannerDeviceView *)scannerDeviceView didScanToURL:(NSURL *)url fileData:(NSData *)data error:(NSError *)error{
    
    if(error){
        NSLog(@"%@", error);
    }
    else{
        
        OPDocument* nDocument = [NSEntityDescription insertNewObjectForEntityForName:@"Document" inManagedObjectContext:[self managedObjectContext]];
        
        NSLog(@"%@", url.path);
        
        nDocument.filePath = url.path;
        nDocument.patient = patient;
        
        [self saveAction];
    }
}

-(void)scannerDeviceView:(IKScannerDeviceView *)scannerDeviceView didEncounterError:(NSError *)error{
    //TODO error management
    NSLog(@"%@", error);
}

-(void)setScanner:(ICScannerDevice*)scanner{
    
    ICScannerDevice* currentScanner = scannerView.scannerDevice;
    if(currentScanner && currentScanner != scanner){
        [currentScanner requestCloseSession];
    }
    
    [scanner setDownloadsDirectory:[parent documentDirectoryFor:patient]];
    [scanner setDocumentName:@"Document"];
    
    [scannerView setDownloadsDirectory:[parent documentDirectoryFor:patient]];
    [scannerView setDocumentName:@"Document"];
    
    [scannerView setScannerDevice:scanner];
}

@end
