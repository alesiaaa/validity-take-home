package com.validity.monolithstarter.service;

import org.springframework.stereotype.Service;

@Service
public class HelloService {
    public String getHelloMessage() {
        return "Hello from the server!";
    }
}
