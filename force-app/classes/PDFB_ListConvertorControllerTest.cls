@IsTest(SeeAllData=true)
public class PDFB_ListConvertorControllerTest {

    @isTest
    static void testConstructor() {
        List <Account> lstAccount = [SELECT Id FROM Account LIMIT 1];
            
        Test.setCurrentPage(Page.PDFB_ListConvertor);
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(lstAccount);
        stdSetController.setSelected(lstAccount);
		PDFB_ListConvertorController ext = new PDFB_ListConvertorController(stdSetController);
    }
    
    @isTest
    static void testPdfButler() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        
        cadmus_core.CadmusHttpCalloutMock.setTestCalloutMockSuccess(acc.Id);
            
		PDFB_ListConvertorController.doConvert(acc.Id, acc.Id, null, null, null);
    }
}