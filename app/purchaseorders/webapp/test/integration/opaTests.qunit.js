sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'pawan/app/purchaseorders/test/integration/FirstJourney',
		'pawan/app/purchaseorders/test/integration/pages/POsList',
		'pawan/app/purchaseorders/test/integration/pages/POsObjectPage',
		'pawan/app/purchaseorders/test/integration/pages/POItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, POsList, POsObjectPage, POItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('pawan/app/purchaseorders') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOsList: POsList,
					onThePOsObjectPage: POsObjectPage,
					onThePOItemsObjectPage: POItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);