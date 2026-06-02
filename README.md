Infrastructure as Code projects built on AWS using Terraform — focused on modular, production-ready deployments.

---

## 🚀 Projects

### [WordPress Deployment](./wordpress-deployment)
A fully modular Terraform deployment of a WordPress site on AWS.

**Stack:** Terraform · AWS EC2 · AWS RDS (MySQL) · AWS VPC · Route53

**Highlights:**
- Infrastructure split into reusable VPC, RDS, and EC2 modules
- WordPress auto-configured on launch via bash script
- RDS deployed in private subnets, EC2 in public subnet
- DNS managed via Route53

---

## 📚 Learning

The [`learning`](./learning) folder contains Terraform experiments and exercises completed during the learning process. Not production ready — just a record of the journey.

---

## 🛠️ Tech Stack
- **Terraform** — Infrastructure as Code
- **AWS** — Cloud provider
- **MySQL** — Database engine
- **Bash** — Instance bootstrap scripting