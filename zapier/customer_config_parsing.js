// Input data (from the previous Zapier step)
const jsonContent = JSON.parse(inputData.jsonContent);

// Extract specific values (example)
const orgs = [];
for (const orgId in jsonContent) {
  const org = jsonContent[orgId];
  orgs.push({
    orgId: orgId,
    loginOrgName: org.loginOrgName,
    appEnvironment: org.appEnvironment,
    cloudProvider: org.cloudConfig ? org.cloudConfig.provider : '',
    cloudRegion: org.cloudConfig ? org.cloudConfig.region : '',
    applicationsEnabled: org.applicationsEnabled ? org.applicationsEnabled.join(', ') : '',
    enableNewDashboard: org.hasOwnProperty('enableNewDashboard') ? org.enableNewDashboard : false,
    enableGhgBreakdown: org.hasOwnProperty('enableGhgBreakdown') ? org.enableGhgBreakdown : false,
    enableEsgReporting: org.esgReporting && org.esgReporting.hasOwnProperty('isEnabled') ? org.esgReporting.isEnabled : false,
    enableFlag: org.flagConfig && org.flagConfig.hasOwnProperty('isEnabled') ? org.flagConfig.isEnabled : false,
    enableAnalytics: org.analytics && org.analytics.hasOwnProperty('isEnabled') ? org.analytics.isEnabled : false,
    enableNetZeroConfig: org.netZeroConfig && org.netZeroConfig.hasOwnProperty('isEnabled') ? org.netZeroConfig.isEnabled : false,
    enableLocalisation: org.localisation && org.localisation.hasOwnProperty('isEnabled') ? org.localisation.isEnabled : false,
    enableLokalise: org.localisation && org.localisation.hasOwnProperty('isLokaliseEnabled') ? org.localisation.isLokaliseEnabled : false,
    enableDapConfig: org.dapConfig && org.dapConfig.hasOwnProperty('isEnabled') ? org.dapConfig.isEnabled : false,
    enableDataProfilingConfig: org.dataProfilingConfig && org.dataProfilingConfig.hasOwnProperty('isEnabled') ? org.dataProfilingConfig.isEnabled : false,

    // measureConfig    
    enableEfVersionControl: org.measureConfig && org.measureConfig.hasOwnProperty('enableEfVersionControl') ? org.measureConfig.enableEfVersionControl : false,
    enableHubspotHelpWidget: org.measureConfig && org.measureConfig.hasOwnProperty('enableHubspotHelpWidget') ? org.measureConfig.enableHubspotHelpWidget : false,
    enableActivityTag: org.measureConfig && org.measureConfig.hasOwnProperty('isActivityTagEnabled') ? org.measureConfig.isActivityTagEnabled : false,
    enableReportingTimePeriod: org.measureConfig && org.measureConfig.hasOwnProperty('isReportingTimePeriodEnabled') ? org.measureConfig.isReportingTimePeriodEnabled : false,

    // manageConfig
    enableManageConfig: org.manageConfig && org.manageConfig.hasOwnProperty('enable') ? org.manageConfig.enable : false,
    manageSupportedDbForDriverTree: org.manageConfig && org.manageConfig.supportedDbForDriverTree ? org.manageConfig.supportedDbForDriverTree.join(', ') : '',
    manageSupportedDbForEfSimulation: org.manageConfig && org.manageConfig.supportedDbForEfSimulation ? org.manageConfig.supportedDbForEfSimulation.join(', ') : '',
    manageSupportedDbForCompositeProduct: org.manageConfig && org.manageConfig.supportedDbForCompositeProduct ? org.manageConfig.supportedDbForCompositeProduct.join(', ') : '',
    manageActivitySimulation: org.manageConfig && org.manageConfig.hasOwnProperty('activitySimulation') ? org.manageConfig.activitySimulation : false,
    manageInitiatives: org.manageConfig && org.manageConfig.hasOwnProperty('initiatives') ? org.manageConfig.initiatives : false,
    manageLeverRecommedations: org.manageConfig && org.manageConfig.hasOwnProperty('leverRecommendations') ? org.manageConfig.leverRecommendations : false
  });
}

// Output data
return { orgs: orgs };