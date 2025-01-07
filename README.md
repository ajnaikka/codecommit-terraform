Project : Secure Code Commit Repository with Terraform 

Objective: Automate the creation and management of a secure AWS Code Commit repository with stringent approval rules and CI/CD integration.

•	Repository Setup: Created Terraform code to establish Code Commit repositories with specific approval rules, ensuring only project managers could approve pull requests.

•	Access Control: Restricted the dev group IAM users from pushing changes directly to production and staging branches, enforcing best practices.

•	CI/CD Integration: Leveraged AWS Lambda to trigger Jenkins jobs, linking multiple projects using remote data sources.
