# Salesforce Production Org Backup

This repository contains a complete backup of the Salesforce production environment for Tremila Advisory, capturing all customizations and configurations as of the initial backup date.

## 📋 Overview

This repository serves as the source of truth for all Salesforce customizations and provides version control for future changes. It was created to capture the current state of the production org after direct changes were made without proper version control.

## 🏗️ Repository Structure

```
force-app/main/default/
├── classes/           # Apex classes and test classes
├── flows/            # Salesforce Flows and Process Builder processes
├── layouts/          # Page layouts for all objects
├── lwc/              # Lightning Web Components
├── objects/          # Custom objects, fields, and related metadata
├── pages/            # Visualforce pages
├── permissionsets/   # Permission sets
└── profiles/         # User profiles
```

## 🚀 Key Components

### Custom Objects
- **TAG_Project__c**: Main project management object
- **TAG_Approval_List__c**: Approval workflow management
- **TAG_Links__c**: Link management for projects
- **TAG_Team_Members__c**: Team member assignments
- **Target_Company__c**: Target company information
- **CRMF_Error__c**: Error logging and management
- **CRMF_Automation_Settings__c**: Automation configuration
- **In_App_Checklist_Settings__c**: Checklist configuration

### Flows
- **TAG_Project_After_Save_Create_Tasks**: Automated task creation
- **TAG_Opportunity_Before_Save_Set_Close_Date**: Opportunity automation
- **TAG_Account_After_Save_Set_Primary_Contact**: Account management
- **Outreach_Fill_Update_Date_Added_to_Sequence_Contact**: Outreach automation
- And many more business process flows

### Apex Classes
- **PDFB_ListConvertorController**: PDF list conversion functionality
- **PDFButler_Actionable_GetThumbnailsUrl**: PDF thumbnail generation

### Lightning Web Components
- **screenFlowRichText**: Rich text component for screen flows

## 🔧 Setup Instructions

### Prerequisites
- Salesforce CLI installed
- Git configured
- Access to the Salesforce org

### Local Development Setup
1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd salesforce-prod-backup
   ```

2. Authenticate with your Salesforce org:
   ```bash
   sf org login web --alias prod --set-default
   ```

3. Deploy to a scratch org for development:
   ```bash
   sf org create scratch --definition-file config/project-scratch-def.json --alias dev --set-default
   sf project deploy start --target-org dev
   ```

## 📝 Development Workflow

### Making Changes
1. Create a new branch for your feature:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes in the appropriate metadata files

3. Test your changes in a scratch org:
   ```bash
   sf org create scratch --definition-file config/project-scratch-def.json --alias test
   sf project deploy start --target-org test
   ```

4. Run tests:
   ```bash
   sf apex run test --target-org test
   ```

5. Commit and push your changes:
   ```bash
   git add .
   git commit -m "Description of changes"
   git push origin feature/your-feature-name
   ```

### Deploying to Production
1. Create a pull request and have it reviewed
2. Merge to main branch
3. Deploy to production:
   ```bash
   sf project deploy start --target-org prod
   ```

## 🛡️ Security & Best Practices

- **Never commit sensitive data**: API keys, passwords, or personal information
- **Use scratch orgs for development**: Never develop directly in production
- **Test thoroughly**: Run all tests before deploying to production
- **Code reviews**: All changes should be reviewed before merging
- **Backup before major changes**: Always backup before significant modifications

## 📊 Monitoring & Maintenance

- Regular metadata retrieval to keep repository in sync
- Monitor for drift between repository and production
- Regular cleanup of unused metadata
- Documentation updates for new features

## 🆘 Troubleshooting

### Common Issues
1. **Deployment failures**: Check for missing dependencies or validation errors
2. **Test failures**: Ensure all test classes have proper coverage
3. **Metadata conflicts**: Use `sf project retrieve start` to sync latest changes

### Getting Help
- Check Salesforce documentation
- Review error messages in deployment logs
- Consult with the development team

## 📅 Change Log

### Initial Backup (Current)
- Captured all custom objects, fields, flows, and layouts
- Retrieved all Apex classes and Lightning Web Components
- Backed up all profiles and permission sets
- Documented current production state

## 🤝 Contributing

1. Follow the established coding standards
2. Write comprehensive test coverage
3. Update documentation for new features
4. Use meaningful commit messages
5. Ensure all tests pass before submitting PR

## 📞 Support

For questions or issues related to this repository, please contact the development team or create an issue in the repository.

---

**Note**: This repository contains production metadata. Always test changes in a development environment before deploying to production.
