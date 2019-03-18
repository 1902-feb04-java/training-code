# SOAP + Spring MVC + Apache CXF
Contract Last approach to generating a JAX-WS implementation of a Soap service with Apache CXF. SEI (Service Endpoint Interface) set as com.revature.soap.HelloServiceImpl.

### WSDL generated at:
http://localhost:8080/soap/Hello?wsdl

### Send a message (text/xml):
```xml
<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/">
    <Body>
        <getHello xmlns="http://soap.revature.com/">
            <arg0 xmlns="">YourNameHere</arg0>
        </getHello>
    </Body>
</Envelope>
```
