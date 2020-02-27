package com.privalia.publicador_kafka.controller;

import com.privalia.publicador_kafka.producer.Sender;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class KafkaController {

    private final Sender sender;

    public KafkaController(Sender sender) {
        this.sender = sender;
    }

    @RequestMapping(value="/send", method= RequestMethod.POST)
    public void send(@RequestBody String data) {
        sender.send(data);
    }
}
