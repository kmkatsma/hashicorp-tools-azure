# HashiCorp Tools with Azure

## Infrastructure Abstraction Levels on Azure

There are currently three fundamental levels of infrastructure abstraction supported by Azure. HashiCorp has tools that can help with all three, though the extent to which they can be used, and the value they can provide will in general increase futher down the abstraction layers.

From highest levels of abstraction to lowest, they are PaaS, CaaS, IaaS.

### Platform as a Service (PaaS) / Functions as a Service (FaaS aka Serverless)

- Azure provides managed environments, using native Azure platform components.
- Examples:
  - Azure Functions, Azure AppService
- Use Cases:
  - Migrating On-Premise IaaS to PaaS directly
  - New development as PaaS/FaaS, want to focus on application development without concern for how the application is running.
- Limitations:
  - Lack of control/customization
  - Cloud Vendor Lock-In.
  - No Cross-Cloud support
- Relevant HashiCorp Tools:
  - Terraform for Resource Provisioning
  - Consul for Cross-Cloud communication (low)
  - Vault for Secret Management (low)

### Containers as a Service (CaaS)

- Container-based applications deployed into a "cluster" hosted by a PaaS or IaaS based cluster management framework.
- Examples:
  - Kubernetes, Mesosphere, Service Fabric
- Use Cases:
  - Cloud development built with technologies that can use containerization
- Limitations:
  - CaaS - Must use tools capable of containerization; can only run containers.
  - Service Fabric - only .NET currently
  - Highly opinionated
  - Limited or no built-in support for cross-cluster or cloud.
- Relevant HashiCorp Tools:
  - Terraform for Resource Provisioning
  - Consul for cross-cluster or external service access
  - Vault for Secret Management

### Infrastructure as a Service (IaaS)

- Custom applications built directly on Cloud-based implementations of Network, Storage, and Compute.
- Examples:
  - Lift and Shift applications to the cloud
  - High Scale Cloud Native Architectures
- Limitations:
  - The imagination of the architects involved
- Relevant HashiCorp Tools:
  - Consul for Hybrid and Multi-Cloud scenarios
  - Terraform for Resource Provisioning
  - Nomad for Container or VM scheduling, scaling
  - Vault for Secret Management

## The Example Solution

- An IaaS-based Consul and Nomad cluster, deployed with Terraform
- Provides maximum flexibility, performance, and control
- Running Containers in VM, scheduled by Nomad
  - But Not limited to containers!
- Packer images - VM definitions can be converted to reusable, fixed Images.
- Can add Vault for robust secret management - certificates, passwords.
- As you use more HashiCorp tools, you will find that the value you can get from each tool increases synergistically.
  - For example, in the solution, Nomad automatically detects and connects to Consul

### Why Terraform?

- Logical first step in integrating HashiCorp tool suite into Azure - always need a way to manage resources.
- Integration with Azure DevOps to replace ARM Templates.
- Superior to ARM templates - persists state, clean language, helpful error messages, code comments!
- Improved input and output variable management.
- Avoid mix of powershell/ARM (i.e., Resource groups can't be created with ARM).
- Terraform Enteprise provides robust management capabilities - sharing, security, resource limits.
- Can use same tool to deploy to all major clouds.
- Can use to deploy on-premise, and into Kubernetes clusters.
- Use Terraform Enterprise to define rules for management and policy.

### Why Consul?

- Ability to eliminate NSG configuration layers in network architecture.
- Software defined routing and security.
- Manage and enforce TLS between all connected resources.
- Robustness and features not available in traditional Load Balancer.

### Why Nomad?

- Non-opinionated scheduler
- Supports cloud and on-premise
- Cross-platform - windows and linux
- Not limited to only docker containers - can handle processes, containers, VM's
- Can utilize Azure DevOps to wrap Nomad for developers

### Why Vault?

- Azure KeyVault is good as a backend, but _management_ of the keys is lacking
- Vault can automate creation, renewal of secrets.
- Let Vault do the heavy lifting; complex key management behavior should not fall to developers.

# Why HashiCorp?

- Beyond the tooling, what does HashiCorp offer?
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
- The TAO of HashiCorp
  - https://www.hashicorp.com/tao-of-hashicorp
  - Workflows, Not Technologies
  - Simple, Modular, Composable
  - Communicating Sequential Processes
  - Immutability
  - Versioning through Codification
  - Automation through Codification
  - Resilient Systems
  - Pragmatism
