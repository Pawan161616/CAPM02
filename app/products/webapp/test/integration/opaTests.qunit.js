sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'pawan/app/products/test/integration/FirstJourney',
		'pawan/app/products/test/integration/pages/ProductSetList',
		'pawan/app/products/test/integration/pages/ProductSetObjectPage',
		'pawan/app/products/test/integration/pages/ProductSet_textsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductSetList, ProductSetObjectPage, ProductSet_textsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('pawan/app/products') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProductSetList: ProductSetList,
					onTheProductSetObjectPage: ProductSetObjectPage,
					onTheProductSet_textsObjectPage: ProductSet_textsObjectPage
                }
            },
            opaJourney.run
        );
    }
);