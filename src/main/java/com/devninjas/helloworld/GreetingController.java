package  com.devninjas.helloworld;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GreetingController {

    @GetMapping("/")
    public String root() {
        return "";
    }

    @GetMapping("/hello")
    public String hello() {
        return "Hallo Welt!";
    }
}