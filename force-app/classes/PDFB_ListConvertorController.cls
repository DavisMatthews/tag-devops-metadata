global  with sharing class PDFB_ListConvertorController {

    global String recordIds  {get; set;}
    global Integer size  {get; set;}
    global cadmus_core.ConvertController.ConvertDataModel cdm {get; set;}
    global String originalUrl { get; set; }

    global PDFB_ListConvertorController(ApexPages.StandardController controller) {
    }

    global PDFB_ListConvertorController(ApexPages.StandardSetController controller) {

        List<String> recordIdsTemp = new List<String>();
        for(sObject rec: controller.getSelected()) {
            recordIdsTemp.add('"' + rec.Id + '"');
        }
        size = recordIdsTemp.size();
        recordIds = String.join(recordIdsTemp, ',');
        // Get all variables from querystring and put them in CDM
        cdm = new cadmus_core.ConvertController.ConvertDataModel();
        //cdm.docConfigId = 'a0J1v00000CysmvEAB'; //REPLACE WITH YOUR DOCCONFIG ID OR RETRIEVED VIA LOGIC
        
        originalUrl = controller.cancel().getUrl();
    }

    /*
     * , String docConfigIds, String locale, String numCurrLocale, String alternative, String targetType, String pdfActionType, 
                                String packId, String DeliveryTypeOverwrite
     */
    @RemoteAction
    global static String doConvert(String docConfigId, String objectId, String locale, String alternative, String packId) {

        return cadmus_core.ConvertComponentController.convert(docConfigId, null, objectId, locale, null, alternative, null, null, null,
                                packId, null);
    }
}