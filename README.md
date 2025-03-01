# **GCP VM Auto-Scaling and Security Implementation**

## **Overview**
This project demonstrates the setup of a **Virtual Machine (VM) on Google Cloud Platform (GCP)** with **auto-scaling, IAM security, and firewall configurations**. It includes:
- **Creating a VM instance** in GCP.
- **Configuring auto-scaling policies** to dynamically adjust the number of instances.
- **Implementing IAM roles** to restrict access.
- **Setting up firewall rules** to allow/deny traffic.

## **Prerequisites**
- A **Google Cloud Platform (GCP) account** with billing enabled.
- Google Cloud SDK installed (optional for CLI operations).
- Basic knowledge of GCP services like **Compute Engine, IAM, and VPC Network**.

---

## **Setup Instructions**

### **1. Create a VM Instance**
```sh
# Navigate to Compute Engine
Go to https://console.cloud.google.com/compute
```
1. Click **Create Instance**.
2. Configure the instance:
   - **Name**: `vm-instance-1`
   - **Region**: Choose the nearest region.
   - **Machine Type**: `e2-medium (2 vCPUs, 4GB RAM)`
   - **Boot Disk**: `Ubuntu 22.04 LTS`
3. Click **Create**.

### **2. Configure Auto-Scaling**
```sh
# Create an instance template
Go to https://console.cloud.google.com/compute/instanceTemplates
```
1. Click **Create Instance Template**.
2. Attach the previously created VM configuration.
3. Navigate to **Compute Engine > Instance Groups**.
4. Click **Create Instance Group** and configure:
   - **Autoscaling Mode**: CPU Utilization (`60%` target)
   - **Min Instances**: `1`, **Max Instances**: `5`
   - **Health Check**: Enable HTTP check on port `80`
5. Click **Create**.

### **3. Implement Security Measures**
#### **A. Configure IAM Roles**
```sh
# Navigate to IAM
Go to https://console.cloud.google.com/iam-admin/iam
```
1. Click **Grant Access**.
2. Assign roles:
   - `Compute OS Login` (For SSH access only)
   - `Compute Instance Admin (v1)` (Full VM management)
3. Enable OS Login (Recommended for secure SSH):
   - Navigate to **Compute Engine > Metadata**.
   - Add key `enable-oslogin` → Value `TRUE`.
   - Click **Save**.

#### **B. Configure Firewall Rules**
```sh
# Navigate to Firewall
Go to https://console.cloud.google.com/networking/firewalls
```
1. **Allow SSH (TCP:22)**:
   - Name: `allow-ssh`
   - Source IP: `YOUR_PUBLIC_IP` (Recommended) or `0.0.0.0/0` (Not Secure)
   - Action: Allow
2. **Deny All Other Traffic**:
   - Name: `deny-all`
   - Source IP: `0.0.0.0/0`
   - Action: Deny
3. Click **Create**.

---

## **Testing**
### **1. Test SSH Access**
```sh
gcloud compute ssh <instance-name> --zone=<your-zone>
```
If IAM restrictions apply, only authorized users should be able to log in.

### **2. Simulate Auto-Scaling**
```sh
# Generate CPU Load
yes > /dev/null &
```
Monitor **Compute Engine > Instance Groups** for new instances being created.

To stop the test:
```sh
killall yes
```

---

## **Project Structure**
```
📂 GCP-AutoScaling-Security
 ├── 📄 README.md  # Documentation
 ├── 📄 instance_template.yaml  # Instance configuration (optional)
 ├── 📄 firewall_rules.sh  # Script to create firewall rules
 ├── 📄 autoscaling_config.yaml  # Auto-scaling policy configuration
 ├── 📂 docs  # Additional resources and screenshots
```

---


