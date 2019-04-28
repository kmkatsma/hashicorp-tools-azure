# HashiCorp Products on Azure

## Common Approaches

- As complement to Azure Native Features
  - Resource Management
  - Integrations with IaaS
  - Extensions for PaaS
- As complement to Kubernetes on AKS
  - Resource and Deployment Management
  - Plug-In to Clusters
  - Cross-Cluster functionality
- HashiCorp Suite as the Core
  - Resource and Deployment Management
  - Massive-Scale Service Based Architectecturs
  - Multi-Cloud scenarios
  - Hybrid Cloud scenarios

### Approach #1: Complement to Azure Native Features

1. **Terraform** for Managing Resources
2. **Consul** for Service Discovery, Software Defined Networking
3. **Vault** for robust Secret Management
4. **Nomad** for Scheduling Containers or Tasks directly on VM's

### Approach #2: Completement to Kubernetes on AKS

1. **Consul** for robust Service Discovery and Cross-Cluster communication
2. **Vault** for improved Secret Management
3. **Terraform** for management of Azure Resources _and_ Deployments in K8s clusters.

### Approach #3: Full Suite for massive scale, multi-cloud, hybrid-cloud scenarios

1. **Terraform** for infrastructure across cloud and on-prem resources
2. **Consul** for service discovery across _all_ environments
3. **Key Vault** for centralized secret management
4. **Nomad** for scheduling to _all_ environments, at largest cloud scale levels

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
