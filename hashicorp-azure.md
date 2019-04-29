# HashiCorp Products on Azure

## Four Maturity Paths on Azure

### Lift and Shift with Cloud Features

- Bringing resources over from On-Premise As Is
- Integrate Cloud IaaS functionality where appropriate
- Hybrid Cloud scenarios
- Eventually Migrate to one of following three options.

### PaaS-Centric

- Migrating On-Premise IaaS to PaaS directly
- Utilize App Services, Azure SQL, etc As complement to Azure Native Features
- New Development in PaaS features like App Services, Logic Apps, Function Apps.

### Kubernetes on AKS

- Cloud Native strategy built on Kubernetes architecture
- Need to utilize add-ons/plug-ins to Kubernetes
- May need Cross-Cluster functionality

### Cloud Native IaaS

- Internet-Scale solutions built on Cloud Infrastructure
- Multi-Cloud scenarios
- Need to maximize performance, scalability

### Hashiform Tools for PaaS-Centric : Complement to Azure Native Features

- **Terraform** for Managing Resources
  - Enterprise version for management and prevention of sprawl.
- **Vault** for robust Secret Management
  - Ideally provide a SaaS/PaaS Vault for client!
- **Consul** for Vault BackEnd

### Approach #2: Completement to Kubernetes on AKS

- **Consul** for robust Service Discovery and Cross-Cluster communication
- **Vault** for improved Secret Management
- **Terraform** for management of Azure Resources _and_ Deployments in K8s clusters.

### Approach #3: Full Suite for massive scale, multi-cloud, hybrid-cloud scenarios

- **Terraform** for infrastructure across cloud and on-prem resources
- **Consul** for service discovery across _all_ environments
- **Key Vault** for centralized secret management
- **Nomad** for scheduling to _all_ environments, at largest cloud scale levels

## HashiCorp Tools in the Azure Ecosystem

### Why Terraform in Azure?

- Logical first step in integrating HashiCorp tool suite into Azure - always need a way to manage resources.
- Integration with Azure DevOps to replace ARM Templates.
- Superior to ARM templates - persists state, clean language, helpful error messages, code comments!
- Improved input and output variable management.
- Avoid mix of powershell/ARM (i.e., Resource groups can't be created with ARM).
- Terraform Enteprise provides robust management capabilities - sharing, security, resource limits.
- Can use same tool to deploy to all major clouds.
- Can use to deploy on-premise, and into Kubernetes clusters.
- Use Terraform Enterprise to define rules for management and policy.

### Why Vault in Azure?

- Azure KeyVault is good as a backend, but _management_ of the keys is lacking
- Vault can automate creation, renewal of secrets.
- Let Vault do the heavy lifting; complex key management behavior should not fall to developers.

### Why Consul in Azure?

- Ability to eliminate NSG configuration layers in network architecture.
- Software defined routing and security.
- Manage and enforce TLS between all connected resources.
- Robustness and features not available in traditional Load Balancer.

### Why Nomad in Azure?

- Non-opinionated scheduler
- Supports cloud and on-premise
- Cross-platform - windows and linux
- Not limited to only docker containers - can handle processes, containers, VM's
- Can utilize Azure DevOps to wrap Nomad for developers

# Why HashiCorp?

- Cloud agnostic. Tools to integrate across clouds; don't really care which cloud.
- Doesn't even matter _if_ you use cloud.
- Products Focused on Doing One Thing Well
  - Products that try to do everything don't do anything very well
  - Non-Opiniated - tools integrate, but you are not forced into integrations.
  - Can use side-by-side to enhance native cloud resources
- Future Proofed:
  - Suport for wherever you are at now on cloud integration path.
  - Base tooling will never need to change.
  - Single toolset to learn.
  - Core tooling all open source.
