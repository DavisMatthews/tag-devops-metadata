public with sharing class OppDocConfigResolver {
    public List<Id> recordIds { get; private set; }
    public Map<Id, String> docConfigByOpp { get; private set; }

    // Expose JSON for the VF page's JS
    public String recordIdsJSON { get { return JSON.serialize(recordIds); } }
    public String docConfigByOppJSON { get { return JSON.serialize(docConfigByOpp); } }

    public OppDocConfigResolver(ApexPages.StandardSetController ssc) {
        recordIds = new List<Id>();
        for (SObject sob : ssc.getSelected()) {
            Id oppId = (Id)sob.get('Id');
            if (oppId != null) recordIds.add(oppId);
        }
        if (recordIds.isEmpty()) {
            ApexPages.addMessage(new ApexPages.Message(
                ApexPages.Severity.ERROR,
                'Please select at least one Opportunity in the list view.'
            ));
            docConfigByOpp = new Map<Id, String>();
            return;
        }

        // Adjust API names below only if they differ in your org:
        // - Opportunity.TAG_Approval_List__c  (lookup to TAG_Approval_List__c)
        // - TAG_Approval_List__c.TAG_Project__c (MD/lookup to TAG_Project__c)
        // - TAG_Project__c.Marketing_Deck_DocConfig__c (Doc Config Id field)
        Map<Id, Opportunity> opps = new Map<Id, Opportunity>([
            SELECT Id,
                   TAG_Approval_List__c,
                   TAG_Approval_List__r.TAG_Project__c,
                   TAG_Approval_List__r.TAG_Project__r.Marketing_Deck_DocConfig__c
            FROM Opportunity
            WHERE Id IN :recordIds
        ]);

        docConfigByOpp = new Map<Id, String>();
        for (Opportunity o : opps.values()) {
            String cfg =
                (o.TAG_Approval_List__r == null || o.TAG_Approval_List__r.TAG_Project__r == null)
                ? null
                : o.TAG_Approval_List__r.TAG_Project__r.Marketing_Deck_DocConfig__c;

            if (String.isNotBlank(cfg)) {
                docConfigByOpp.put(o.Id, cfg);
            }
        }
    }
}