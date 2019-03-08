# Linux
Linux is a popular choice for a cloud server. There are a variety of open-source distributions each with a large community of hobbyists and professionals supporting them. Unique development tools are widespread and simple to install, use, and maintain. And most distributions are very capable without the resource overhead of a graphical desktop user interface, making the system very lightweight.

On a headless server (without a graphical interface), the most popular way to interact with a server is through a terminal interface. The most widespread is a shell known as Bash, the Borne Again Shell.

## Shell
A shell is a program that interprets user input. Emulating the look and feel of an old mainframe terminal interface, many shells like Bash provide their users access to several command-line interface (CLI) tools as well as useful conveniences such as auto-completion, a scripting language syntax, and I/O redirection.

To use a CLI tool a user types the name of a program followed by any parameters or flags.

## Scripting
Text files saved with the `.sh` extension are commonly used as shell scripts - a manifest of commands for Bash to run automatically line by line. To write a script, a shebang is commonly used on the first line to denote the shell program of choice. To execute a script, either pass the file as an argument to the `sh` or `bash` command, or make the file executable using `chmod` and call the file in the shell.

#### Example `script.sh`
```bash
#!/bin/bash

# Updating and installing packages through yum
sudo yum update -y
sudo yum remove -y java
sudo yum install -y git java-1.8.0-openjdk-devel

# Adding external yum repository for Maven
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum update -y
sudo yum install -y apache-maven

#Installing Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
sudo yum install -y jenkins
sudo service jenkins start
```

## Sudo
The `sudo` command elevates the shell prompt with root permissions. Root is the default administrator account and is rarely stopped by the system from doing anything. Whlie some programs require root access and thus must be used together with `sudo`, it is dangerous to use carelessly.

## Package Management
Linux distributions maintain a variety of public and private repositories of program installation scripts. These repositories and their related CLI tool makes quick work of installing, updating, and uninstalling programs with simple commands. The program `yum` is commonly used on Amazon Linux and any Red Hat derived systems (RHEL, Fedora, CentOS), while `apt` is popular on Debian-based systems (Debian, Ubuntu).

#### Examples (using `yum`)
```bash
# To update all packages
sudo yum update

# To install a program (git)
sudo yum install git

# To uninstall a program (java)
sudo yum remove java

# To install OpenJDK Java 8
sudo yum install java-1.8.0-openjdk-devel
```

## Man
The `man` command will seek and display the manual page for most CLI tools installed through a package manager. Used like `sudo`, it takes a CLI command as an argument.
```bash
# Will display the manual page for yum
man yum
```

## Grep
The global regular expression print tool (`grep`) processes files and standard output text to search for an expression matching what was passed to the command.
```bash
# Will search for lines with 'tim' inside users.txt
grep tim users.txt
```

# AWS
AWS (Amazon Web Services) is a PaaS (Platform as a Service) which offers many SaaS (Software as a Service) and IaaS (Infrastructure as a Service) IT solutions on the cloud (i.e. hosted remotely on their many server farms). Amazon offers many services at various price points and dominates the cloud IT market today.

## EC2
EC2, Elastic Cloud Compute, is a web service providing flexible computing power in the form of a server running a headless operating system on virtual hardware.An instance is a single EC2 machine with predefined hardware resources (CPU, RAM, Network I/O), and can be configured individually or as part of a group of instances in a VPC (Virtual Private Cloud). Security Group settings, Auto-Scaling groups, Load Balancers, and EBS (Elastic Block Storage) drives can be attached to each instance. When creating a new instance, users must choose an AMI from Amazon or the Amazon marketplace, attach an EBS drive, and create or assign existing key pairs for secure SSH connections to the instance in the future.

### AMI
An AMI (Amazon Machine Image) is a snapshot of a preconfigured operating system ready to be flashed onto a new EC2 instance. Amazon offers many Linux and Windows AMIs, including its own Linux distribution 'Amazon Linux', all of which come with pre-installed tools and services as well as proper security settings and user account configurations.

### Security Group
EC2 instances have strict firewall settings by default and must be configured through security group settings to allow specific kinds of traffic through specific ports or port ranges. By default a security group allows incoming SSH protocol connections on port 22.

### Auto Scaling and Elastic Load Balancing
An EC2 instance can be horizontally scaled, i.e. multiple instances sharing the same configuration can be deployed or removed to provide a small army of servers hosting multiple instances of your EC2 machine. Auto Scaling groups provide users control over hardware or network thresholds that trigger automatic scaling of the number of instances, while an ELB (Elastic Load Balancer) manages efficient routing of traffic to these instances to evenly spread traffic to available resources.

### Connecting to an EC2 Instance
The standard protocol for connections to an EC2 instance is SSH (Secure Shell). Using the Unix `ssh` command or a Windows tool like `PuTTY` a user can establish a connection using a `.pem` key file which contains a private/public key pair. When an EC2 instance is created, the complimentary key value is stored on the instance as well and all connections must use this file to authenticate.

Using `ssh` to connect:
```bash
ssh -i 'path/to/your.pem' ec2UserName@ec2-IP-or-DNS
```

For Amazon Linux AMIs, the username is `ec2-user`. For an Ubuntu AMI, it would be `ubuntu`. The server can be reached via its short IPv4 address or the generated DNS name, both of which are generated for your EC2 instance. Be wary of any address changes after instances are shut down.

When first connecting, answer `yes` to the prompt asking to register the new server. Afterwards your shell prompt will now reflect a session on your EC2.

### EBS
Elastic Block Store (EBS) provides hard storage for EC2 instances, with various hardware options for desired performance and capacity. EC2 memory is volatile, so EBS offers a file storage option to back up any data on an EC2 instance. Furthermore, EBS volumes can be detached and reattached at will, and even cloned or attached to completely new instances.

EBS volumes are formatted with a file system for compatibility with an EC2 instance's operating system.

## S3
Amazon S3 (Simple Storage Service) offers an object storage service commonly used for hosting media or application files, backup storage, static website files, and software artifacts and binaries. As opposed to a block storage like EBS which includes a filesystem overhead for compatibility with Linux or Windows, an S3 simply stores objects in a bucket. An object is composed of a file and metadata while a bucket is a container hosting objects.

### Bucket Policy
An S3 bucket not only stores objects, but also provides url links to each object. The Bucket Policy for the bucket configures access permissions to these links, which are restricted by default. In the Permissions/Bucket Policy page, a JSON configuration file can be added to change it.

### Example Bucket Policy
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::your-bucket-name/*"
    }
  ]
}
```
This policy allows access to all files in the bucket named 'your-bucket-name'.

# Continuous Integration

>"Continuous Integration is a software development practice where members of a team integrate their work frequently, usually each person integrates at least daily - leading to multiple integrations per day. Each integration is verified by an automated build (including test) to detect integration errors as quickly as possible. Many teams find that this approach leads to significantly reduced integration problems and allows a team to develop cohesive software more rapidly." 
<div style="text-align: right">~Martin Fowler</div>

DevOps culture aims to minimize the barriers between developers and operations as a whole, but it also streamlines the development process itself through Continuous Integration (CI). 

When working with several developers on a single code repository, safely integrating many changes from each developer is a challenge. Too few integrations and the code base may introduce bugs or become broken without any clear insight into when and how it happened. Each developer should not only be responsible for maintaining up-to-date code on their development environments, but also be responsible for regularly committing new code that passes local unit tests.

## Automated builds
As developers integrate new code, an automated build on a server separate from each of their development environments should trigger. After the build is pulled from the repository, compiled, and tested automatically, the developers should be notified of any and all issues or errors introduced by recent commits. This ensures any problems introduced into the repository are quickly highlighted before becoming buried by the next round of commits.

### Scripts
On a build server, the automated process may be as simple as a scheduled script which pulls the latest code from the repository, builds a new artifact from the changes, and logs and reports on the status of any compiling errors or test failures. The following is an example for a Linux server. This can be added as a `cron` job to periodically trigger your build.

#### `build.sh`
```bash
#!/bin/bash
git pull https://your-repository.git
cd your-repository/
mvn clean package
#Mail log output from build to developers
```

### CI/CD Tools
Advanced tools like Jenkins, Circle-CI, Travis-CI, and many more simplify the automation process. Whether hosted on your own build server or as a cloud service, they can coordinate SCM, build, deployment, and messaging tools through a user-friendly web interface and have access to a large community of plugins or excellent integration with repository services like GitHub.

# Continuous Delivery
>The essence of my philosophy to software delivery is to build software so that it is always in a state where it could be put into production. We call this Continuous Delivery because we are continuously running a deployment pipeline that tests if this software is in a state to be delivered.
<div style="text-align: right">~Martin Fowler</div>

Just as a team of developers use continuous, automated builds to integrate new changes to their code base rapidly, efficiently, and safely, an operations team benefits from automating a rapid delivery process of that build to the various teams and servers in preparation for deployment.

## Pipelines
The process of moving the build (or rebuilding from source) beyond the initial Continuous Integration build is called Continuous Delivery (CD), and the solution that implements this process is known as the deployment (or build) pipeline.

The first CI bulid, the build triggered by a commit or series of commits by developers, should be done quickly to satisfy CI requirements: quick unit tests and error-free compilations are enough. But afterwards the code base should be made available to other teams to run more extensive testing and performance monitoring.

An example two stage deployment pipeline would have the first stage do the CI compilation and unit testing while the second stage builds on a separate testing server to handle integration and end-to-end behavior testing. Further stages can be added at will, triggered at their own intervals.

Just like with CI, simple scripts can automate the process of building, testing, or deploying to staging servers. Tools such as Jenkins also simplify the process of building pipelines and can coordinate multiple servers with ease.

# Jenkins
Forked from Sun's Hudson project after it was acquired by Oracle, Jenkins is a popular open-source CI/CD tool used throughout the industry to create and manage build pipelines. Jenkins is distributed as a Java `war` package and can be deployed to a Tomcat server or run as a self-executing `war`. The Jenkins dashboard is then accessible through a web application.

## Setup
When Jenkins first runs, it creates a `.jenkins` directory where pipelines and project workspaces will be managed, along with an installation directory elsewhere for managing tools, plugins, and users.

Once Jenkins is up and running, the dashboard can be found at `http://localhost:8080` by default. The Unlock Jenkins page will prevent further access until the autogenerated password is copied from the file location specified on the page or on the console log output when running Jenkins as an executable `war`.

Once unlocked, Jenkins can download several popular plugins and help configure the admin account.

## Plugins
The popularity of Jenkins is in part thanks to its rich plugin community offering many helpful tools for a variety of build actions. On initial setup a variety of popular plugins come bundled with Jenkins and can be installed individually. More plugins can be discovered and installed (or removed).

## Global Tools
Jenkins runs its processes as a special user on its host operating system. In order to work with a variety of tools, it must install and configure permissions for these tools, ranging from command line programs such as Git or Maven to authentication of external services like GitHub or Slack. If certain tools are missing, Jenkins can be configured to automatically install them during a build.

## Users
A default admin account is registered during initial setup. If this admin account creation is skipped, the password will be the autogenerated password used to unlock Jenkins. Other accounts can be created, and permissions can be set by the admin using the security matrix. This is useful for restricting access to your pipelines to developers who may not require it.

## Jobs
A pipeline is defined through a Jenkins Job, a project created and monitored on the Jenkins dashboard. Jobs can be structured in multiple ways using a variety of archetypes. Each job creates a folder with a workspace directory where a bulid can be isolated from other jobs. A job is configured through a graphical wizard interface or programmatically using a Jenkinsfile script (written in Groovy, a JVM scripting language).

Besides the build itself, various pre-build and post-build stages can be defined in order to set environment variables, prepare build tools, poll SCM repositories, and log messages to email or other messaging services like Slack.

## Agents
Jenkins jobs normally run on the master node, the server the Jenkins instance defining the pipeline shares. But distributed builds are possible through a Jenkins Agent, a separate node hosted on a different server and linked to a master node through SSH. A Jenkins master with one or more agents can run a build on these agents thereby freeing up resources on the master for other jobs.

## Example Plugin use: GitHub Hooks
Rather than poll a GitHub repository at regular intervals, Jenkins can be configured to listen to the repository for any updates, then trigger a build.

## On GitHub
On a repository, under "Settings" and "Webhooks", Click "Add webhook" and add your Jenkins hook URL: `http://<your public DNS or IP>:8080/github-webhook/`. This will notify Jenkins of a specified event and can be used with the GitHub plugin's "GitHub hook trigger for GITScm polling" option under your Jenkins job's "Build Triggers" configuration settings.

# Hibernate
The Hibernate framework is a ORM (Object-Relational Mapping) implementation which is built around JDBC.

ORM refers to the long-standing problem of setting up a relationship between a program's objects and rows in a SQL table.

```
class Customer {
    int id;
    String name;
    List<Account>;
}
```
```sql
Create Table Customer(
    id integer primary key,
    name varchar2(50),
    account_id foreign key references Account(id)
    --The above is an issue for mapping
);
```

Map our Java objects to database entities through Hibernate, built on top of JDBC, which will abstract for us all the persistence and transactions that we would normally do ourselves. Hibernate can use interfaces to abstract several different database connections, but can also generate SQL.

## Packages
- org.hibernate
- javax.persistence
    - JPA (Java Persistence API)
    - Generic annotations for ORMs

## Exceptions
- HibernateException
    - RuntimeException which wraps SQLException

## Dependencies
- hibernate-core
- hibernate-entityManager

## JDBC Interfaces vs Hibernate Interfaces
### JDBC
- DriverManager
- Connection
- Statement
- PreparedStatement
- CallableStatement
- ResultSet

### Hibernate
- **Configuration** creates session factories through a specified configuration file or class
- **SessionFactory** is a singleton which generates session objects using a factory design pattern.
    - >SessionFactory sf = new Configuration().configure("file").buildSessionFactory();
- **Session** represents the database connection
    - >Session s = sf.openSession();
    - >s.close();
- **Query** is used to write complex CRUD operations using HQL (Hibernate Query Language)
- **Criteria** is for programmatically writing Select queries
    ```java
    List<Animal> a = session.createCriteria(Animal.class)
        .addOrder(Order.asc("age"))
        .add(Restriction.between("age", 3, 7))
        .list();
    ```
- **Transaction** is an interface for managing ACID-complient transactions
    > Transaction tx = session.beginTransation();
    > //some inserts here
    > tx.commit();

## ACID
ACID is a set of rules to be respected whenever a transaction occures in a SQL database.

1. Atomicity
    - All or nothing approach, either every single line in a transaction succeeds without errors, or none do
1. Consistency
    - Every transaction must leave the database in a consistent state: respecting data, domain, and referential integrity
1. Isolation
    - All transactions that occur concurrently should create the same result in the database as if those transactions occured in series
1. Durability
    - All transactions must be permanent, leaving the database in a committed state that cannot be rolled back or lost

## Mapping with JPA Annotations
- @Entity: marks class for Hibernate
- @Table: maps entity to a table in database
- @Id: maps a property in an entity as a primary key in the database
- @Column: maps a property in an entity as a column in the database
- @JoinColumn: maps a property in an entity as a foreign key in the database

```java
//Student.java
import javax.persistence.*
@Entity
@Table(name=”student”)
public class Student(){
  @Id
  @column(name=”s_id”)
  private Integer studentId;
  
  @column(name=”s_name”)
  private String studentName;
}
```

- Multiplicity
  - @OneToOne
  - @OneToMany: used on parent relation
  - @ManyToOne: used on child relation
  - @ManyToMany

```java
@Entity
@Table(name=”dept”)
public class Department {
  @Id
  @Column(name=”d_id”)
  private Integer id;

  @Column(name=”d_name”)
  private String deptName
}

@Entity
@Table(name=”emp”)
public class Employee {
  @Id
  @Column(name=”e_id”)
  private Integer id;

  @Column(name=”e_name”)
  private String empName;
  
  @ManyToOne
  @JoinColumn(name=”dept_id”)
  private Department dept;
}
```

Alternatively, in Department.java:
```java
@OneToMany(mappedBy=”dept”)
private List<Employee> emps;
```

## Cascades
- By default, no transitive persistence or cascading of state in Hibernate objects with multiplicity relationships
- No default cascading of state or persistence by reachability
- Set up cascade types such as all, none, delete-orphan, etc, in mapping document or in annotation to establish parent/child lifecycle tables, where child lifespan is bounded by parent's lifespan

## Lazy/Eager Fetching
- Eager grabs all information, including associated objects, immediately
- Lazy grabs data only when needed, and creates a proxy in place of associated objects until then
- Proxies can be filled as long as session is open, otherwise a LazyInitializationException is thrown after session closes
- Ex: `@ManyToOne(fetch=FetchType.LAZY)`

## Object States
- Transient
  - Just Instantiated with 'new'
  - Not associated with a session
  - No database representation
- Persistent
  - Has database representation and an identifier
  - Within scope of a session
  - Any changes made in Java will be detected by Hibernate and reflected in database
- Detached
  - Was in a persistent state, but then the session ended
  - Automatic Dirty Checking
  - When connection closes, Hibernate checks for changes in persistent objects and puts all objects in Detached state
  
## Eager vs Lazy Hibernate session CRUD
- Get
  - Immediately (Eagerly) retrieve object from DB
  - Null if object does not exist
- Load
  - Retrieves a proxy (Lazily) which is filled only when used
  - Accessible while session is open

- Save
  - Returns generated PK
  - Immediately inserts regardless of transaction
- Persist
  - Void return type
  - Only inserts during a transaction

- Update
  - Updates object in DB
  - Brings transient object to persistent state
- Merge
  - Checks if object exists
  - Makes persistent object if it doesn't
  - Copies data into new persistent object

- SaveOrUpdate
  - Universal tool for persistent objects
  - If object exists, it will update
  - If not, it will create
  
## Caching
- Level 1
  - Session scope
  - Enabled by default (no config)
  - Session.evict() removes one object
  - Session.clear() removes entire cache
  - Session.contains() returns t/f if cached object is available
  
- Level 2
  - SessionFactory scope
  - Not default behavior (must configure w/ 3rd party library like Ehcache)
  - Strategies/Use cases:
    - Read_Only – good for app config, things that are never updated
    - Read_Write – for objects to be updated, only aware of changes through hibernate
