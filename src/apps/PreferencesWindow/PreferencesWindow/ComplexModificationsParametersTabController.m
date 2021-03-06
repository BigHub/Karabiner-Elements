#import "ComplexModificationsParametersTabController.h"
#import "KarabinerKit/KarabinerKit.h"

@interface ComplexModificationsParametersTabController ()

@property(weak) IBOutlet NSStepper* basicToIfAloneTimeoutMillisecondsStepper;
@property(weak) IBOutlet NSTextField* basicToIfAloneTimeoutMillisecondsText;
@property(weak) IBOutlet NSStepper* basicToDelayedActionDelayMillisecondsStepper;
@property(weak) IBOutlet NSTextField* basicToDelayedActionDelayMillisecondsText;

@end

@implementation ComplexModificationsParametersTabController

- (void)setup {
  [[NSNotificationCenter defaultCenter] addObserverForName:kKarabinerKitConfigurationIsLoaded
                                                    object:nil
                                                     queue:[NSOperationQueue mainQueue]
                                                usingBlock:^(NSNotification* note) {
                                                  [self updateValues];
                                                }];

  [self updateValues];
}

- (void)updateValues {
  KarabinerKitCoreConfigurationModel* coreConfigurationModel = [KarabinerKitConfigurationManager sharedManager].coreConfigurationModel;

  {
    int value = [coreConfigurationModel getSelectedProfileComplexModificationsParameter:@"basic.to_if_alone_timeout_milliseconds"];
    self.basicToIfAloneTimeoutMillisecondsStepper.integerValue = value;
    self.basicToIfAloneTimeoutMillisecondsText.integerValue = value;
  }
  {
    int value = [coreConfigurationModel getSelectedProfileComplexModificationsParameter:@"basic.to_delayed_action_delay_milliseconds"];
    self.basicToDelayedActionDelayMillisecondsStepper.integerValue = value;
    self.basicToDelayedActionDelayMillisecondsText.integerValue = value;
  }
}

- (IBAction)valueChanged:(id)sender {
  {
    NSStepper* stepper = self.basicToIfAloneTimeoutMillisecondsStepper;
    NSTextField* text = self.basicToIfAloneTimeoutMillisecondsText;
    if (sender == stepper) {
      text.integerValue = stepper.integerValue;
    }
    if (sender == text) {
      stepper.integerValue = text.integerValue;
    }
  }
  {
    NSStepper* stepper = self.basicToDelayedActionDelayMillisecondsStepper;
    NSTextField* text = self.basicToDelayedActionDelayMillisecondsText;
    if (sender == stepper) {
      text.integerValue = stepper.integerValue;
    }
    if (sender == text) {
      stepper.integerValue = text.integerValue;
    }
  }

  KarabinerKitCoreConfigurationModel* coreConfigurationModel = [KarabinerKitConfigurationManager sharedManager].coreConfigurationModel;
  [coreConfigurationModel setSelectedProfileComplexModificationsParameter:@"basic.to_if_alone_timeout_milliseconds"
                                                                    value:self.basicToIfAloneTimeoutMillisecondsText.intValue];
  [coreConfigurationModel setSelectedProfileComplexModificationsParameter:@"basic.to_delayed_action_delay_milliseconds"
                                                                    value:self.basicToDelayedActionDelayMillisecondsText.intValue];
  [coreConfigurationModel save];
}

@end
