package hello.controller;

import java.net.URI;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import java.text.MessageFormat;

@RestController
@RequestMapping("/")
class HelloController {

  @GetMapping("/")
  String getHello() {

    Object[] params = new Object[]{
      System.getenv("ORG_DB_USERNAME"),
      System.getenv("ORG_DB_PASSWORD"),
      System.getenv("SPACE_DB_USERNAME"),
      System.getenv("SPACE_DB_PASSWORD")
    };

    String template = 
      "<h1>Visit us @ www.conjur.org!</h1>" +
      "<h3>Org-wide Secrets</h3>" +
      "<p>Database Username: {0}</p>" +
      "<p>Database Password: {1}</p>" +
      "<h3>Space-wide Secrets</h3>" +
      "<p>Database Username: {2}</p>" +
      "<p>Database Password: {3}</p>";


    String msg = MessageFormat.format("{0} world {1}", params);

    return msg;
  }
}
