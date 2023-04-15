# How to set up Windows

## Install Docker (and Docker Compose) in Windows

<https://docs.docker.com/desktop/install/windows-install/>

## Install VirtualBox in Windows

<https://www.virtualbox.org/wiki/Downloads>

## Install Vagrant in Windows

<https://developer.hashicorp.com/vagrant/docs/installation>

### Use Docker as the provider for Vagrant on Windows

To use Docker as the provider for Vagrant on our Windows, follow these steps:

Install Vagrant on our Windows by following the instructions on the official Vagrant documentation.

Install the Docker provider plugin for Vagrant by running the following command in our Terminal window:

`vagrant plugin install vagrant-docker-compose`

This command will install the Docker provider plugin for Vagrant.

Create a new Vagrantfile in our project directory or use an existing one.

In our Vagrantfile, configure Vagrant to use the Docker provider by adding the following line:

`config.vm.provider "docker"`

You can also configure additional settings for the Docker provider, such as the image to use, by adding more lines to our Vagrantfile.

Run the vagrant up command to start the Vagrant environment with the Docker provider.

`vagrant up --provider=docker`

This command will start the Vagrant environment with the Docker provider.

Once the Vagrant environment is started, we can use the vagrant ssh command to SSH into the environment and interact with our Docker containers.

## Install minikube in Windows

<https://minikube.sigs.k8s.io/docs/start/>

```dos
minikube start --driver=docker --kubernetes-version=v1.26.1

minikube version
```

## Install kubectl in Windows

```dos
minikube kubectl

kubectl version
```

## Install Helm in Windows

```dos
choco install kubernetes-helm

helm version
```

## Install Kind in Windows

```bash
choco install kind
```

## Install Git Bash in Windows

Here are the steps to install Git Bash on Windows:

Download the Git for Windows installer from the official website at <https://gitforwindows.org/>.

Run the installer and follow the prompts. When prompted for installation options, keep the default settings and click "Next" to proceed.

On the "Adjusting your PATH environment" screen, select "Use Git and optional Unix tools from the Command Prompt" and click "Next".

On the "Configuring the line ending conversions" screen, select "Checkout Windows-style, commit Unix-style line endings" and click "Next".

On the "Configuring the terminal emulator to use with Git Bash" screen, select "Use Windows' default console window" and click "Next".

On the "Configuring extra options" screen, leave the default settings and click "Next".

On the "Installing" screen, click "Install" to begin the installation process.

Once the installation is complete, click "Finish" to exit the installer.

You can now launch Git Bash by searching for "Git Bash" in the Start menu or by clicking the Git Bash shortcut on your desktop.

Git Bash is now installed on your Windows system, and you can use it to run Git commands and Unix utilities from the command line.

<!--
minikube in Windows has many issues

```dos
C:\devbox>minikube start --driver=none
😄  minikube v1.29.0 on Microsoft Windows 10 Enterprise 10.0.19044.2728 Build 19044.2728

❌  Exiting due to DRV_UNSUPPORTED_OS: The driver 'none' is not supported on windows/amd64

C:\devbox>minikube start --driver=ssh 
😄  minikube v1.29.0 on Microsoft Windows 10 Enterprise 10.0.19044.2728 Build 19044.2728
✨  Using the ssh driver based on user configuration

❌  Exiting due to MK_USAGE: No IP address provided. Try specifying --ssh-ip-address, or see https://minikube.sigs.k8s.io/docs/drivers/ssh/

C:\devbox>minikube start             
😄  minikube v1.29.0 on Microsoft Windows 10 Enterprise 10.0.19044.2728 Build 19044.2728
✨  Automatically selected the virtualbox driver
💿  Downloading VM boot image ...
    > minikube-v1.29.0-amd64.iso....:  65 B / 65 B [---------] 100.00% ? p/s 0s
    > minikube-v1.29.0-amd64.iso:  276.35 MiB / 276.35 MiB  100.00% 744.59 KiB 
👍  Starting control plane node minikube in cluster minikube
🔥  Creating virtualbox VM (CPUs=2, Memory=6000MB, Disk=20000MB) ...
🤦  StartHost failed, but will try again: creating host: create: precreate: This computer is running Hyper-V. VirtualBox won't boot a 64bits VM when Hyper-V is activated. Either use Hyper-V as a driver, or disable the Hyper-V 
hypervisor. (To skip this check, use --virtualbox-no-vtx-check)
🔥  Creating virtualbox VM (CPUs=2, Memory=6000MB, Disk=20000MB) ...
😿  Failed to start virtualbox VM. Running "minikube delete" may fix it: creating host: create: precreate: This computer is running Hyper-V. VirtualBox won't boot a 64bits VM when Hyper-V is activated. Either use Hyper-V as a 
driver, or disable the Hyper-V hypervisor. (To skip this check, use --virtualbox-no-vtx-check)

❌  Exiting due to PR_VBOX_HYPERV_64_BOOT: Failed to start host: creating host: create: precreate: This computer is running Hyper-V. VirtualBox won't boot a 64bits VM when Hyper-V is activated. Either use Hyper-V as a driver, o
r disable the Hyper-V hypervisor. (To skip this check, use --virtualbox-no-vtx-check)
💡  Suggestion: VirtualBox and Hyper-V are having a conflict. Use '--driver=hyperv' or disable Hyper-V using: 'bcdedit /set hypervisorlaunchtype off'
🍿  Related issues:
    ▪ https://github.com/kubernetes/minikube/issues/4051
    ▪ https://github.com/kubernetes/minikube/issues/4783

C:\devbox>minikube delete
💀  Removed all traces of the "minikube" cluster.

C:\devbox>minikube start --driver=hyperv 
😄  minikube v1.29.0 on Microsoft Windows 10 Enterprise 10.0.19044.2728 Build 19044.2728
✨  Using the hyperv driver based on user configuration

💣  Exiting due to PROVIDER_HYPERV_NOT_RUNNING: Hyper-V requires Administrator privileges
💡  Suggestion: Right-click the PowerShell icon and select Run as Administrator to open PowerShell in elevated mode.
```

Powershell admin mode

```dos
PS C:\WINDOWS\system32> minikube start --driver=hyperv                                                                                                          * minikube v1.29.0 on Microsoft Windows 10 Enterprise 10.0.19044.2728 Build 19044.2728                                                                          * Using the hyperv driver based on user configuration
* Starting control plane node minikube in cluster minikube
* Creating hyperv VM (CPUs=2, Memory=6000MB, Disk=20000MB) ...
* Preparing Kubernetes v1.26.1 on Docker 20.10.23 ...
  - Generating certificates and keys ...
  - Booting up control plane ...
  - Configuring RBAC rules ...
* Configuring bridge CNI (Container Networking Interface) ...
* Verifying Kubernetes components...
  - Using image gcr.io/k8s-minikube/storage-provisioner:v5
* Enabled addons: storage-provisioner, default-storageclass
* Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
```
-->
