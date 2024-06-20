package  com.devninjas.helloworld;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GreetingController {
    @Value("${POD_NAME:UNKNOWN_POD_NAME}")
    private String podName;

    @Value("${POD_NAMESPACE:UNKNOWN_POD_NAMESPACE}")
    private String podNamespace;

    @Value("${POD_IP:UNKNOWN_POD_IP}")
    private String podIp;

    @Value("${NODE_NAME:UNKNOWN_NODE}")
    private String nodeName;

    @GetMapping("/")
    public String root() {
        return String.format("Hello from %s/%s (%s), my home is %s", podName, podNamespace, podIp, nodeName);
    }

    @GetMapping("/hello")
    public String hello() {
        return "Hallo Welt!";
    }
}