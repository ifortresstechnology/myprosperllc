package com.prosperllc.controller;

import com.prosperllc.model.ServiceInfo;
import com.prosperllc.repository.ServiceInfoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class WebController {

    @Autowired
    private ServiceInfoRepository serviceInfoRepository;

    @GetMapping("/services")
    public List<ServiceInfo> getAllServices() {
        return serviceInfoRepository.findAll();
    }
}
