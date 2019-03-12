# Spring
Spring Framework is a highly modular Application Framework built upon an IoC Container. It offers similar features to JavaEE's EJBs and can interface well with many other specifications such as JPA. Spring can be configured and deployed without the need for an application server with only a few modules, or it can become a self-executing server in the form of a Spring Boot project.

## Inversion of Control (IoC) Container
Spring implements inversion of control through its Core IoC Container, which manages object lifecycles and automatic dependency injection. An object managed by the container, known as a **Spring Bean**, is instantiated, deployed when requested, and destroyed automatically. Any dependencies required by the bean are also injected through constructor arguments, arguments to a factory method, or properties set on the object instance after its construction. The IoC Container is known today as the Application Context, and originally called the Bean Factory.

The goal of an IoC Container is to decouple execution from configuration. By separating these concerns, an application's code base becomes more modular, loosely coupled, with less focus on how code will be implemented and more on its business logic.

The phrase 'inversion of control' refers to this process of configuring dependencies for a bean, rather than the bean controlling the process for its own dependencies.

## Modules
The IoC container is made up of the spring-core, spring-beans, and spring-context modules, but other dependent modules such as spring-aop are commonly used as well. The container can be further extended with the inclusion of other Spring frameworks such as spring-mvc, spring-data, spring-security, spring-cloud, and much more.

## Configuration
While Spring Boot consolidates many modules and follows a 'convention over configuration' approach, most Spring modules can be individually configured either through an XML file or through Java annotations. Spring Boot can load properties files and also offers native support for YAML.

Many modules provide their own preconfigured beans, but custom beans can also be configured by registering them in the XML configuration file or through annotations which are then scanned by the container. Once all beans and configuration options are gathered, an Application Context is created to act as the IoC container for a program.

The Application Context is an interface with several factories to build one according to the manner of configuration, such as ClassPathXmlApplicationContext or FileSystemXmlApplicationContext for XML files, or XmlWebApplicationContext for Spring MVC built on Tomcat. There is also AnnotationConfigApplicationContext for a configuration class.

## BeanFactory vs ApplicationContext
The Bean Factory was the original interface for Spring, and has been superceded by the more capable Application Context. Bean Factory was a sophisticated implementation of the factory design pattern which lazily and programmatically instantiate beans as singletons.

Application Context is an extension of the Bean Factory, eagerly instantiating beans and capable of defining several different scopes besides singleton.

## Bean Lifecycle
Spring's container handles the lifecycle of a bean through a complex series of steps. In general, the setup phase involves instantiation of the empty object, handling of its dependencies, initialization of properties and default values, and any custom initialization methods before the bean is ready for use within the program. The teardown phase dereferences the bean when it passes out of scope (or the container is itself shutdown), but also calls any custom destroy methods along the way.

    Lifecycle:
        ▪ Instantiate Bean
        ▪ Populate Bean
        ▪ Bean Name Aware
            • SetBeanName()
        ▪ Bean Factory Aware
            • SetBeanFactory()
        ▪ BeanPostProcessor Pre-Initialization
        ▪ afterPropertiesSet() Initialization
        ▪ (Optional) Custom Init method
        ▪ BeanPostProcessor Post-Initialization
        ▪ Bean is ready for use!
        ▪ destroy()/custom destroy method (when container is shut down)
        
As a rule, we do not need to interfere with the lifecycle, but Spring provides several callback methods to customize it in subtle ways. We can implement the InitializingBean/DisposableBean interfaces and override their afterPropertiesSet/destroy methods, or we can define our own custom init and destroy methods in XML configuration or through @PostConstruct/@PreDestroy annotations.

## Bean Scopes
A bean has several scopes, two of which are available to a basic Application Context while the rest are usually seen in a Spring web program.

| Scope | Description |
|------|------|
| singleton | (Default) Scopes a single bean definition to a single object instance for each Spring IoC container.|
| prototype | Scopes a single bean definition to any number of object instances.|
|request | Scopes a single bean definition to the lifecycle of a single HTTP request. That is, each HTTP request has its own instance of a bean created off the back of a single bean definition. Only valid in the context of a web-aware Spring ApplicationContext.
| session | Scopes a single bean definition to the lifecycle of an HTTP Session. Only valid in the context of a web-aware Spring ApplicationContext.|
| application | Scopes a single bean definition to the lifecycle of a ServletContext. Only valid in the context of a web-aware Spring ApplicationContext. |
| websocket | Scopes a single bean definition to the lifecycle of a WebSocket. Only valid in the context of a web-aware Spring ApplicationContext. |

 The most important are Singleton and Prototype for most Spring applications. Singleton is the default scope where there is one bean (of its kind) per container, which is best for stateless objects. This is not to be confused with a proper Java singleton which has hardcoded scope within a class loader. A Singleton scoped bean is cached and returned whenever that named object is requested.

 Prototype scope can have any number of instances per bean definition, and instead of caching existing beans a new instance is created for each bean request. This makes it ideal for stateful objects, but Spring no longer manages the full lifecycle for us making it little different from calling the 'new' keyword ourselves.

## Bean Wiring 
Spring can inject beans as dependencies of other beans through Setter or Constructor Injection. Beans can be wired manually through property element attributes in an XML configuration file or through annotations. Dependencies can be registered and referenced either by its bean name or by its type.

By far the most popular and easiest method is 'Autowiring' where Spring will figure out a dependency 'automagically.'
