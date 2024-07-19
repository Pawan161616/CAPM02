sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'pawan.app.products',
            componentId: 'ProductSet_textsObjectPage',
            contextPath: '/ProductSet/texts'
        },
        CustomPageDefinitions
    );
});